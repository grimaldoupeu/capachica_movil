import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../blocs/experiencia_bloc/experiencia_bloc.dart';
// import '../../models/experiencia/experiencia_model.dart';
// For Add/Edit screen (not created in this step)
// import './add_edit_experiencia_screen.dart';

class ManageExperienciasScreen extends StatelessWidget {
  const ManageExperienciasScreen({super.key});

  void _addEditExperiencia(BuildContext context, {Map<String, dynamic>? experiencia}) {
    // This would navigate to a dedicated AddEditExperienciaScreen
    // For placeholder, show a simple dialog or print
    final isEditing = experiencia != null;
    print('${isEditing ? "Edit" : "Add"} Experiencia action. Experiencia: ${experiencia?['nombre']}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Placeholder for ${isEditing ? "Edit" : "Add"} Experiencia Screen')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mockAdminExperiencias = [
      {'id': 'exp1', 'nombre': 'Tour en Kayak por Uros', 'categoria': 'Tour Guiado', 'precio': 80.0},
      {'id': 'exp2', 'nombre': 'Taller de Textiles en Taquile', 'categoria': 'Taller Cultural', 'precio': 120.0},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestionar Experiencias'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            tooltip: 'Agregar Experiencia',
            onPressed: () => _addEditExperiencia(context),
          ),
        ],
      ),
      body:
      // BlocBuilder<ExperienciaBloc, ExperienciaState>(
      //   builder: (context, state) {
      //     if (state is ExperienciasLoading) { /* ... */ }
      //     else if (state is ExperienciasLoaded) {
      //       return ListView.builder(
      //         itemCount: state.experiencias.length,
      //         itemBuilder: (context, index) {
      //           final exp = state.experiencias[index];
      //           return ListTile(
      //             title: Text(exp.nombre),
      //             subtitle: Text('${exp.categoria.name} - \$${exp.precioPorPersona.toStringAsFixed(2)}'),
      //             trailing: Row(mainAxisSize: MainAxisSize.min, children: [ /* Edit, Delete buttons */ ]),
      //             onTap: () => _addEditExperiencia(context, experiencia: exp), // Open for edit
      //           );
      //         },
      //       );
      //     } /* ... other states ... */
      //     return const Center(child: Text('Cargando experiencias...'));
      //   }
      // ),
      ListView.builder(
        itemCount: mockAdminExperiencias.length,
        itemBuilder: (context, index) {
          final item = mockAdminExperiencias[index];
          return ListTile(
            title: Text(item['nombre']! as String),
            subtitle: Text('${item['categoria']} - \$${(item['precio'] as double).toStringAsFixed(2)} PEN'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: Icon(Icons.edit, color: Colors.blue), onPressed: () => _addEditExperiencia(context, experiencia: item)),
                IconButton(icon: Icon(Icons.delete, color: Colors.red), onPressed: () {
                  print('Delete Experiencia: ${item['id']}');
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Placeholder to Delete ${item['nombre']}')));
                }),
              ],
            ),
            onTap: () => _addEditExperiencia(context, experiencia: item),
          );
        },
      ),
    );
  }
}
