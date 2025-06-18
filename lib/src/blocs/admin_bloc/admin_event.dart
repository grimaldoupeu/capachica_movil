part of 'admin_bloc.dart';

abstract class AdminEvent extends Equatable {
  const AdminEvent();
  @override
  List<Object?> get props => [];
}

class LoadDashboardStats extends AdminEvent {}

class LoadAdminUserList extends AdminEvent {
  // Optional filters can be added: String? role, String? searchTerm
  const LoadAdminUserList();
}

// Events for user management by admin (can also be in AuthBloc or a dedicated UserManagementBloc)
class UpdateUserRoleByAdmin extends AdminEvent {
  final String userId;
  final String newRole; // UserRole.turista.name or UserRole.administrador.name
  const UpdateUserRoleByAdmin({required this.userId, required this.newRole});
  @override
  List<Object> get props => [userId, newRole];
}

class DeleteUserByAdmin extends AdminEvent {
  final String userId;
  const DeleteUserByAdmin({required this.userId});
  @override
  List<Object> get props => [userId];
}

// Other admin actions like managing categories, etc., might have their own events if not covered by module-specific BLoCs
