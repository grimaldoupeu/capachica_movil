import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../blocs/servicio_bloc/servicio_bloc.dart';
// import '../../models/servicio/servicio_model.dart';

class ManageServiciosScreen extends StatelessWidget {
  const ManageServiciosScreen({super.key});

  void _showAddEditServicioDialog(BuildContext context, {Map<String, dynamic>? servicio}) {
    final _formKey = GlobalKey<FormState>();
    final _nombreController = TextEditingController(text: servicio?['nombre'] as String?);
    final _descripcionController = TextEditingController(text: servicio?['descripcion'] as String?);
    final _iconoController = TextEditingController(text: servicio?['iconoUrlOrCode'] as String?);
    final bool isEditing = servicio != null;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(isEditing ? 'Editar Servicio Maestro' : 'Agregar Servicio Maestro'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    controller: _nombreController,
                    decoration: const InputDecoration(labelText: 'Nombre del Servicio'),
                    validator: (value) => value == null || value.isEmpty ? 'Ingresa un nombre' : null,
                  ),
                  TextFormField(
                    controller: _descripcionController,
                    decoration: const InputDecoration(labelText: 'Descripción (Opcional)'),
                  ),
                  TextFormField(
                    controller: _iconoController,
                    decoration: const InputDecoration(labelText: 'Código de Ícono (Ej: wifi, pets)'),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            ElevatedButton(
              child: Text(isEditing ? 'Guardar Cambios' : 'Agregar'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // final servicioBloc = BlocProvider.of<ServicioBloc>(context);
                  if (isEditing) {
                    // servicioBloc.add(UpdateMasterServicio(
                    //   servicioId: servicio!['id'] as String,
                    //   nombre: _nombreController.text,
                    //   descripcion: _descripcionController.text,
                    //   iconoUrlOrCode: _iconoController.text,
                    // ));
                    print('Update Master Servicio: ID: ${servicio!['id']}, Nombre: ${_nombreController.text}');
                  } else {
                    // servicioBloc.add(CreateMasterServicio(
                    //   nombre: _nombreController.text,
                    //   descripcion: _descripcionController.text,
                    //   iconoUrlOrCode: _iconoController.text,
                    // ));
                    print('Create Master Servicio: Nombre: ${_nombreController.text}');
                  }
                  Navigator.of(dialogContext).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Mock list of master services for admin view
    final mockMasterServicios = [
      {'id': 'serv1', 'nombre': 'WiFi', 'descripcion': 'Acceso a internet', 'iconoUrlOrCode': 'wifi'},
      {'id': 'serv2', 'nombre': 'Desayuno', 'descripcion': 'Desayuno incluido', 'iconoUrlOrCode': 'free_breakfast'},
      {'id': 'serv3', 'nombre': 'Tour Local', 'descripcion': 'Paseo guiado', 'iconoUrlOrCode': 'tour'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestionar Servicios Maestros'),
        // actions: [
        //   IconButton( // If loading is manual
        //     icon: const Icon(Icons.refresh),
        //     onPressed: () => BlocProvider.of<ServicioBloc>(context).add(LoadMasterServicios()),
        //   )
        // ],
      ),
      body:
      // BlocConsumer<ServicioBloc, ServicioState>( // Use BlocConsumer for feedback
      //   listener: (context, state) {
      //     if (state is ServicioOperationSuccess) {
      //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message), backgroundColor: Colors.green));
      //     } else if (state is ServicioOperationFailure) {
      //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message), backgroundColor: Colors.red));
      //     }
      //   },
      //   builder: (context, state) {
      //     if (state is ServiciosLoading) {
      //       return const Center(child: CircularProgressIndicator());
      //     } else if (state is MasterServiciosLoaded) {
      //       if (state.servicios.isEmpty) {
      //         return const Center(child: Text('No hay servicios maestros definidos.'));
      //       }
      //       return ListView.builder(
      //         itemCount: state.servicios.length,
      //         itemBuilder: (context, index) {
      //           final servicio = state.servicios[index];
      //           return ListTile(
      //             leading: servicio.iconoUrlOrCode != null ? Icon(ServicioListWidget(serviciosData: [])._getIconData(servicio.iconoUrlOrCode)) : null, // Hacky way to access icon logic
      //             title: Text(servicio.nombre),
      //             subtitle: Text(servicio.descripcion ?? 'Sin descripción'),
      //             trailing: Row(
      //               mainAxisSize: MainAxisSize.min,
      //               children: [
      //                 IconButton(
      //                   icon: const Icon(Icons.edit, color: Colors.blue),
      //                   onPressed: () => _showAddEditServicioDialog(context, servicio: servicio), // Pass Servicio object
      //                 ),
      //                 IconButton(
      //                   icon: const Icon(Icons.delete, color: Colors.red),
      //                   onPressed: () {
      //                      // Show confirmation dialog then:
      //                      // BlocProvider.of<ServicioBloc>(context).add(DeleteMasterServicio(servicioId: servicio.id));
      //                      print('Delete Master Servicio: ${servicio.id}');
      //                   },
      //                 ),
      //               ],
      //             ),
      //           );
      //         },
      //       );
      //     } else if (state is ServiciosError) {
      //       return Center(child: Text('Error: ${state.message}'));
      //     }
      //     return const Center(child: Text('Cargando servicios maestros...'));
      //   },
      // )
      // Placeholder list for admin:
      ListView.builder(
        itemCount: mockMasterServicios.length,
        itemBuilder: (context, index) {
          final item = mockMasterServicios[index];
          return ListTile(
            leading: item['iconoUrlOrCode'] != null ? Icon(ServicioListWidget(serviciosData: [])._getIconData(item['iconoUrlOrCode'])) : null,
            title: Text(item['nombre']!),
            subtitle: Text(item['descripcion'] ?? 'Sin descripción'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: Icon(Icons.edit, color: Colors.blue), onPressed: () {
                   _showAddEditServicioDialog(context, servicio: item);
                   print('Edit ${item['id']}');
                }),
                IconButton(icon: Icon(Icons.delete, color: Colors.red), onPressed: () {
                  print('Delete ${item['id']}');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Placeholder to Delete Master ${item['nombre']}')),
                  );
                }),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEditServicioDialog(context),
        tooltip: 'Agregar Servicio Maestro',
        child: const Icon(Icons.add),
      ),
    );
  }
}
