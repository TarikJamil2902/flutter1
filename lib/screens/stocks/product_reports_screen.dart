import 'package:flutter/material.dart';
import 'package:new_flutter_app/models/category.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../providers/product_provider.dart';

class ProductReportsScreen extends StatelessWidget {
  const ProductReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBar(
            automaticallyImplyLeading: false,
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Overview'),
                Tab(text: 'Categories'),
                Tab(text: 'Stock'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [_OverviewTab(), _CategoriesTab(), _StockTab()],
        ),
      ),
    );
  }
}

class _OverviewTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        final products = productProvider.products;
        final totalProducts = products.length;
        final totalStock = products.fold<int>(
          0,
          (sum, product) => sum + product.quantity,
        );
        final lowStockProducts = products.where((p) => p.quantity < 10).length;
        final outOfStockProducts =
            products.where((p) => p.quantity <= 0).length;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Product Overview',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'Total Products',
                      totalProducts.toString(),
                      Icons.inventory_2,
                      Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      'Total Stock',
                      totalStock.toString(),
                      Icons.warehouse,
                      Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'Low Stock',
                      lowStockProducts.toString(),
                      Icons.warning,
                      Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      'Out of Stock',
                      outOfStockProducts.toString(),
                      Icons.error,
                      Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(title, style: TextStyle(color: color.withOpacity(0.8))),
        ],
      ),
    );
  }
}

class _CategoriesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<CategoryProvider, ProductProvider>(
      builder: (context, categoryProvider, productProvider, child) {
        final categories = categoryProvider.categories;

        if (categories.isEmpty) {
          return const Center(child: Text('No categories available'));
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                'Products by Category',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: PieChart(
                  PieChartData(
                    sections:
                        categories.map((category) {
                          final double percentage =
                              category.productCount /
                              categories.fold(
                                0,
                                (sum, cat) => sum + cat.productCount as int,
                              );
                          return PieChartSectionData(
                            color:
                                Colors.primaries[categories.indexOf(category) %
                                    Colors.primaries.length],
                            value: percentage * 100,
                            title:
                                '${category.name}\n${(percentage * 100).toStringAsFixed(1)}%',
                            radius: 100,
                            titleStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          );
                        }).toList(),
                    sectionsSpace: 2,
                    centerSpaceRadius: 0,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StockTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        final products = productProvider.products;

        if (products.isEmpty) {
          return const Center(child: Text('No products available'));
        }

        final stockLevels = [
          products.where((p) => p.quantity <= 0).length,
          products.where((p) => p.quantity > 0 && p.quantity < 10).length,
          products.where((p) => p.quantity >= 10).length,
        ];

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                'Stock Levels',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: products.length.toDouble(),
                    barGroups: [
                      _buildBarGroup(0, stockLevels[0], Colors.red),
                      _buildBarGroup(1, stockLevels[1], Colors.orange),
                      _buildBarGroup(2, stockLevels[2], Colors.green),
                    ],
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            switch (value.toInt()) {
                              case 0:
                                return const Text('Out of\nStock');
                              case 1:
                                return const Text('Low\nStock');
                              case 2:
                                return const Text('In\nStock');
                              default:
                                return const Text('');
                            }
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                        ),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  BarChartGroupData _buildBarGroup(int x, int y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y.toDouble(),
          color: color,
          width: 20,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
        ),
      ],
    );
  }
}
