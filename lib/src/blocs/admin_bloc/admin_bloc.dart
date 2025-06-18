import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../models/reporte/dashboard_stats_model.dart';
import '../../../models/usuario/user_model.dart'; // Assuming User model
import '../../../services/admin_service/admin_service.dart'; // Placeholder
// May need other services like UserService or directly use AuthService for user manipulation by admin

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final AdminService _adminService;
  // final AuthService _authService; // If admin actions on users are here

  AdminBloc(this._adminService /*, this._authService */) : super(AdminInitial()) {
    on<LoadDashboardStats>(_onLoadDashboardStats);
    on<LoadAdminUserList>(_onLoadAdminUserList);
    on<UpdateUserRoleByAdmin>(_onUpdateUserRoleByAdmin);
    on<DeleteUserByAdmin>(_onDeleteUserByAdmin);
  }

  Future<void> _onLoadDashboardStats(LoadDashboardStats event, Emitter<AdminState> emit) async {
    emit(const AdminLoading(message: 'Cargando estadísticas...'));
    try {
      // final stats = await _adminService.getDashboardStats();
      await Future.delayed(const Duration(seconds: 1)); // Simulate
      const mockStats = DashboardStats(
        totalUsuarios: 150,
        totalAlojamientos: 35,
        totalExperiencias: 15,
        totalReservasActivas: 22,
        totalReservasCompletadas: 180,
        ingresosEsteMes: 12550.75,
      );
      emit(const DashboardStatsLoaded(stats: mockStats));
    } catch (e) {
      emit(AdminError(message: 'Error al cargar estadísticas: ${e.toString()}'));
    }
  }

  Future<void> _onLoadAdminUserList(LoadAdminUserList event, Emitter<AdminState> emit) async {
    emit(const AdminLoading(message: 'Cargando lista de usuarios...'));
    try {
      // final users = await _adminService.getAllUsers(); // Or from a UserService
      await Future.delayed(const Duration(milliseconds: 500));
      final mockUsers = _getMockUsers();
      emit(AdminUserListLoaded(users: mockUsers));
    } catch (e) {
      emit(AdminError(message: 'Error al cargar usuarios: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateUserRoleByAdmin(UpdateUserRoleByAdmin event, Emitter<AdminState> emit) async {
    emit(const AdminLoading(message: 'Actualizando rol de usuario...'));
    try {
      // await _adminService.updateUserRole(event.userId, event.newRole);
      // Or: await _authService.adminUpdateUserRole(event.userId, event.newRole);
      await Future.delayed(const Duration(seconds: 1));
      emit(const AdminOperationSuccess(message: 'Rol de usuario actualizado.'));
      add(const LoadAdminUserList()); // Refresh user list
    } catch (e) {
      emit(AdminOperationFailure(message: 'Error al actualizar rol: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteUserByAdmin(DeleteUserByAdmin event, Emitter<AdminState> emit) async {
    emit(const AdminLoading(message: 'Eliminando usuario...'));
    try {
      // await _adminService.deleteUser(event.userId);
      // Or: await _authService.adminDeleteUser(event.userId);
      await Future.delayed(const Duration(seconds: 1));
      emit(const AdminOperationSuccess(message: 'Usuario eliminado.'));
      add(const LoadAdminUserList()); // Refresh user list
    } catch (e) {
      emit(AdminOperationFailure(message: 'Error al eliminar usuario: ${e.toString()}'));
    }
  }

  List<User> _getMockUsers() {
    return [
      const User(id: 'user1', nombre: 'Ana García', email: 'ana@example.com', rol: UserRole.turista),
      const User(id: 'user2', nombre: 'Luis Solis (Anfitrión)', email: 'luis_host@example.com', rol: UserRole.turista), // Role should be host/admin if applicable
      const User(id: 'user3', nombre: 'Pedro Admin', email: 'pedro_admin@example.com', rol: UserRole.administrador),
      const User(id: 'user4', nombre: 'Maria Viajera', email: 'maria.v@example.com', rol: UserRole.turista),
    ];
  }
}
