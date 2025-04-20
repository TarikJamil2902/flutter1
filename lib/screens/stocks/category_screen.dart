// import 'package:flutter/material.dart';
// import 'package:new_flutter_app/models/category.dart';
// import 'package:new_flutter_app/screens/stocks/drawer.dart';
// import 'package:provider/provider.dart';

// class CategoryScreen extends StatefulWidget {
//   const CategoryScreen({super.key});

//   @override
//   _CategoryScreenState createState() => _CategoryScreenState();
// }

// class _CategoryScreenState extends State<CategoryScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
//   }

//   void _showAddCategoryDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder:
//           (context) => Dialog(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: AddCategoryForm(
//                 onSuccess: () async {
//                   Navigator.of(context).pop();
//                   await Provider.of<CategoryProvider>(
//                     context,
//                     listen: false,
//                   ).fetchCategories();
//                 },
//               ),
//             ),
//           ),
//     );
//   }

//   void _showEditCategoryDialog(BuildContext context, Category category) {
//     showDialog(
//       context: context,
//       builder:
//           (context) => Dialog(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: AddCategoryForm(
//                 category: category,
//                 onSuccess: () async {
//                   Navigator.of(context).pop();
//                   await Provider.of<CategoryProvider>(
//                     context,
//                     listen: false,
//                   ).fetchCategories();
//                 },
//               ),
//             ),
//           ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Categories')),
//       drawer: Drawer(child: DreawerWidget()),
//       body: Consumer<CategoryProvider>(
//         builder: (context, categoryProvider, child) {
//           final categories = categoryProvider.categories;
//           if (categories.isEmpty) {
//             return const Center(child: Text('No category found.'));
//           }

//           return LayoutBuilder(
//             builder: (context, constraints) {
//               return Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: ConstrainedBox(
//                     constraints: BoxConstraints(minWidth: constraints.maxWidth),
//                     child: DataTable(
//                       columnSpacing: 20,
//                       columns: const [
//                         DataColumn(label: Text('Name')),
//                         DataColumn(label: Text('Code')),
//                         DataColumn(label: Text('Description')),
//                         DataColumn(label: Text('Actions')),
//                       ],
//                       rows:
//                           categories.map((category) {
//                             return DataRow(
//                               cells: [
//                                 DataCell(Text(category.name)),
//                                 DataCell(Text(category.code)),
//                                 DataCell(Text(category.description)),
//                                 DataCell(
//                                   Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       IconButton(
//                                         icon: const Icon(
//                                           Icons.edit,
//                                           color: Colors.blue,
//                                         ),
//                                         onPressed:
//                                             () => _showEditCategoryDialog(
//                                               context,
//                                               category,
//                                             ),
//                                       ),
//                                       IconButton(
//                                         icon: const Icon(
//                                           Icons.delete,
//                                           color: Colors.red,
//                                         ),
//                                         onPressed: () async {
//                                           final confirmed = await showDialog<
//                                             bool
//                                           >(
//                                             context: context,
//                                             builder:
//                                                 (context) => AlertDialog(
//                                                   title: const Text(
//                                                     'Delete Category',
//                                                   ),
//                                                   content: Text(
//                                                     'Are you sure you want to delete "${category.name}"?',
//                                                   ),
//                                                   actions: [
//                                                     TextButton(
//                                                       onPressed:
//                                                           () => Navigator.pop(
//                                                             context,
//                                                             false,
//                                                           ),
//                                                       child: const Text(
//                                                         'Cancel',
//                                                       ),
//                                                     ),
//                                                     TextButton(
//                                                       onPressed:
//                                                           () => Navigator.pop(
//                                                             context,
//                                                             true,
//                                                           ),
//                                                       child: const Text(
//                                                         'Delete',
//                                                         style: TextStyle(
//                                                           color: Colors.red,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                           );
//                                           if (confirmed == true) {
//                                             await Provider.of<CategoryProvider>(
//                                               context,
//                                               listen: false,
//                                             ).deleteCategory(category.id!);
//                                           }
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             );
//                           }).toList(),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () => _showAddCategoryDialog(context),
//         icon: const Icon(Icons.add),
//         label: const Text('Add Category'),
//       ),
//     );
//   }
// }

// class AddCategoryForm extends StatefulWidget {
//   final Category? category;
//   final VoidCallback? onSuccess;
//   const AddCategoryForm({this.category, this.onSuccess, super.key});

//   @override
//   _AddCategoryFormState createState() => _AddCategoryFormState();
// }

// class _AddCategoryFormState extends State<AddCategoryForm> {
//   final _formKey = GlobalKey<FormState>();
//   late TextEditingController _nameController;
//   late TextEditingController _codeController;
//   late TextEditingController _descriptionController;

//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController(text: widget.category?.name ?? '');
//     _codeController = TextEditingController(text: widget.category?.code ?? '');
//     _descriptionController = TextEditingController(
//       text: widget.category?.description ?? '',
//     );
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _codeController.dispose();
//     _descriptionController.dispose();
//     super.dispose();
//   }

//   Future<void> _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       final category = Category(
//         id: widget.category?.id,
//         name: _nameController.text,
//         code: _codeController.text,
//         description: _descriptionController.text,
//       );

//       final provider = Provider.of<CategoryProvider>(context, listen: false);

//       if (widget.category == null) {
//         await provider.addCategory(category);
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Category added successfully')),
//         );
//       } else {
//         await provider.updateCategory(category);
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Category updated successfully')),
//         );
//       }

//       widget.onSuccess?.call();
//       _formKey.currentState!.reset();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: ListView(
//         shrinkWrap: true,
//         children: [
//           TextFormField(
//             controller: _nameController,
//             decoration: const InputDecoration(labelText: 'Category Name'),
//             validator:
//                 (value) =>
//                     (value == null || value.isEmpty)
//                         ? 'Please enter category name'
//                         : null,
//           ),
//           TextFormField(
//             controller: _codeController,
//             decoration: const InputDecoration(labelText: 'Category Code'),
//             validator:
//                 (value) =>
//                     (value == null || value.isEmpty)
//                         ? 'Please enter category code'
//                         : null,
//           ),
//           TextFormField(
//             controller: _descriptionController,
//             decoration: const InputDecoration(labelText: 'Description'),
//             maxLines: 3,
//             validator:
//                 (value) =>
//                     (value == null || value.isEmpty)
//                         ? 'Please enter description'
//                         : null,
//           ),
//           const SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: _submitForm,
//             child: Text(
//               widget.category == null ? 'Add Category' : 'Update Category',
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
