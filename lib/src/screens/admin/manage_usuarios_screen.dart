import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../blocs/admin_bloc/admin_bloc.dart';
// import '../../models/usuario/user_model.dart'; // From Auth module

class ManageUsuariosScreen extends StatefulWidget {
  const ManageUsuariosScreen({super.key});

  @override
  State<ManageUsuariosScreen> createState() => _ManageUsuariosScreenState();
}

class _ManageUsuariosScreenState extends State<ManageUsuariosScreen> {
  @override
  void initState() {
    super.initState();
    // BlocProvider.of<AdminBloc>(context).add(const LoadAdminUserList());
    print('ManageUsuariosScreen: Loading user list (placeholder)');
  }

  void _showChangeRoleDialog(BuildContext context, String userId, String currentRoleName) {
    // final adminBloc = BlocProvider.of<AdminBloc>(context);
    // String selectedRole = currentRoleName; // UserRole.turista.name
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cambiar Rol de Usuario'),
        content: StatefulBuilder( // To update dropdown inside dialog
          builder: (BuildContext context, StateSetter setState) {
            return DropdownButtonFormField<String>(
              value: currentRoleName, // Assuming currentRoleName matches one of the enum names
              items: ['turista', 'administrador'] // UserRole.values.map((role) => role.name)
                  .map((roleName) => DropdownMenuItem(value: roleName, child: Text(roleName)))
                  .toList(),
              onChanged: (value) {
                // setState(() { selectedRole = value!; });
                print('Selected role: $value for user $userId (placeholder)');
              },
              decoration: const InputDecoration(labelText: 'Nuevo Rol'),
            );
          }
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () {
              // adminBloc.add(UpdateUserRoleByAdmin(userId: userId, newRole: selectedRole));
              print('Update role for user $userId to selectedRole (placeholder)');
              Navigator.of(ctx).pop();
            },
            child: const Text('Actualizar Rol'),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteUserDialog(BuildContext context, String userId, String userName) {
    // final adminBloc = BlocProvider.of<AdminBloc>(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirmar Eliminación'),
        content: Text('¿Estás seguro de que quieres eliminar al usuario "$userName"? Esta acción no se puede deshacer.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancelar')),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () {
              // adminBloc.add(DeleteUserByAdmin(userId: userId));
              print('Delete user $userId (placeholder)');
              Navigator.of(ctx).pop();
            },
            child: const Text('Eliminar Usuario'),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    // Mock user list
    final mockUsers = [
      {'id': 'user1', 'nombre': 'Ana García', 'email': 'ana@example.com', 'rol': 'turista'},
      {'id': 'user2', 'nombre': 'Luis Solis (Anfitrión)', 'email': 'luis_host@example.com', 'rol': 'turista'},
      {'id': 'user3', 'nombre': 'Pedro Admin', 'email': 'pedro_admin@example.com', 'rol': 'administrador'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Gestionar Usuarios')),
      // body: BlocBuilder<AdminBloc, AdminState>(
      //   builder: (context, state) {
      //     if (state is AdminLoading && state.message == 'Cargando lista de usuarios...') {
      //       return const Center(child: CircularProgressIndicator());
      //     } else if (state is AdminUserListLoaded) {
      //       if (state.users.isEmpty) {
      //         return const Center(child: Text('No hay usuarios registrados.'));
      //       }
      //       return ListView.builder(
      //         itemCount: state.users.length,
      //         itemBuilder: (context, index) {
      //           final user = state.users[index];
      //           return Card(
      //             margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      //             child: ListTile(
      //               leading: CircleAvatar(child: Text(user.nombre.substring(0,1))),
      //               title: Text(user.nombre),
      //               subtitle: Text('${user.email} - Rol: ${user.rol.name}'),
      //               trailing: PopupMenuButton<String>(
      //                 onSelected: (value) {
      //                   if (value == 'change_role') _showChangeRoleDialog(context, user.id, user.rol.name);
      //                   else if (value == 'delete') _confirmDeleteUserDialog(context, user.id, user.nombre);
      //                 },
      //                 itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
      //                   const PopupMenuItem<String>(value: 'change_role', child: Text('Cambiar Rol')),
      //                   const PopupMenuItem<String>(value: 'delete', child: Text('Eliminar Usuario', style: TextStyle(color: Colors.red))),
      //                 ],
      //               ),
      //             ),
      //           );
      //         },
      //       );
      //     } else if (state is AdminError) {
      //       return Center(child: Text('Error: ${state.message}'));
      //     }
      //     return const Center(child: Text('Cargando usuarios...'));
      //   },
      // ),
      body: ListView.builder(
        itemCount: mockUsers.length,
        itemBuilder: (context, index) {
          final user = mockUsers[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: ListTile(
              leading: CircleAvatar(child: Text((user['nombre'] as String).substring(0,1))),
              title: Text(user['nombre'] as String),
              subtitle: Text('${user['email']} - Rol: ${user['rol']}'),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'change_role') _showChangeRoleDialog(context, user['id'] as String, user['rol'] as String);
                  else if (value == 'delete') _confirmDeleteUserDialog(context, user['id'] as String, user['nombre'] as String);
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(value: 'change_role', child: Text('Cambiar Rol')),
                  const PopupMenuItem<String>(value: 'delete', child: Text('Eliminar Usuario', style: TextStyle(color: Colors.red))),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
