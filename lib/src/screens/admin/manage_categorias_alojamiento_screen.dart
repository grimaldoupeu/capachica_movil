import 'package:flutter/material.dart';
// This would typically have its own BLoC (e.g., CategoriaBloc) or use AdminBloc/AlojamientoBloc
// For simplicity, it's a very basic placeholder.

class ManageCategoriasAlojamientoScreen extends StatelessWidget {
  const ManageCategoriasAlojamientoScreen({super.key});

  void _showAddEditCategoriaDialog(BuildContext context, {Map<String, dynamic>? categoria}) {
    final _formKey = GlobalKey<FormState>();
    final _nombreController = TextEditingController(text: categoria?['nombre'] as String?);
    final isEditing = categoria != null;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isEditing ? 'Editar Categoría' : 'Nueva Categoría'),
        content: Form(
          key: _formKey,
          child: TextFormField(
            controller: _nombreController,
            decoration: const InputDecoration(labelText: 'Nombre de la Categoría'),
            validator: (value) => value == null || value.isEmpty ? 'Ingrese un nombre' : null,
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                print('${isEditing ? "Update" : "Create"} Categoría: ${_nombreController.text} (ID: ${categoria?['id']})');
                Navigator.of(ctx).pop();
              }
            },
            child: Text(isEditing ? 'Guardar' : 'Crear'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Mock data
    final mockCategorias = [
      {'id': 'cat1', 'nombre': 'Cabaña'},
      {'id': 'cat2', 'nombre': 'Casa Rural'},
      {'id': 'cat3', 'nombre': 'Habitación Privada'},
      {'id': 'cat4', 'nombre': 'Hostal Boutique'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Gestionar Categorías de Alojamiento')),
      body: ListView.builder(
        itemCount: mockCategorias.length,
        itemBuilder: (context, index) {
          final categoria = mockCategorias[index];
          return ListTile(
            title: Text(categoria['nombre']!),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: const Icon(Icons.edit, color: Colors.blue), onPressed: () => _showAddEditCategoriaDialog(context, categoria: categoria)),
                IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () {
                  print('Delete Categoría: ${categoria['id']} (placeholder)');
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Eliminar ${categoria['nombre']} (placeholder)')));
                }),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEditCategoriaDialog(context),
        tooltip: 'Agregar Categoría',
        child: const Icon(Icons.add),
      ),
    );
  }
}
