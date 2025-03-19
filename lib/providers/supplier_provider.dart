import 'package:flutter/material.dart';
import '../models/supplier.dart';

class SupplierProvider extends ChangeNotifier {
  final List<Supplier> _suppliers = [];

  List<Supplier> get suppliers => _suppliers;

  void addSupplier(Supplier supplier) {
    _suppliers.add(supplier);
    notifyListeners();
  }

  void updateSupplier(Supplier supplier) {
    final index = _suppliers.indexWhere((s) => s.id == supplier.id);
    if (index >= 0) {
      _suppliers[index] = supplier;
      notifyListeners();
    }
  }

  void deleteSupplier(int id) {
    _suppliers.removeWhere((s) => s.id == id);
    notifyListeners();
  }

  Supplier? getSupplierById(int id) {
    try {
      return _suppliers.firstWhere((s) => s.id == id);
    } catch (e) {
      return null;
    }
  }

  void incrementProductCount(int supplierId) {
    final index = _suppliers.indexWhere((s) => s.id == supplierId);
    if (index >= 0) {
      final supplier = _suppliers[index];
      _suppliers[index] = Supplier(
        id: supplier.id,
        name: supplier.name,
        email: supplier.email,
        phone: supplier.phone,
        address: supplier.address,
        productCount: supplier.productCount + 1,
        createdAt: supplier.createdAt,
        updatedAt: DateTime.now(),
      );
      notifyListeners();
    }
  }

  void decrementProductCount(int supplierId) {
    final index = _suppliers.indexWhere((s) => s.id == supplierId);
    if (index >= 0) {
      final supplier = _suppliers[index];
      if (supplier.productCount > 0) {
        _suppliers[index] = Supplier(
          id: supplier.id,
          name: supplier.name,
          email: supplier.email,
          phone: supplier.phone,
          address: supplier.address,
          productCount: supplier.productCount - 1,
          createdAt: supplier.createdAt,
          updatedAt: DateTime.now(),
        );
        notifyListeners();
      }
    }
  }
}
