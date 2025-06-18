part of 'admin_bloc.dart';

abstract class AdminState extends Equatable {
  const AdminState();
  @override
  List<Object?> get props => [];
}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {
  final String? message;
  const AdminLoading({this.message});
   @override
  List<Object?> get props => [message];
}

class DashboardStatsLoaded extends AdminState {
  final DashboardStats stats;
  const DashboardStatsLoaded({required this.stats});
  @override
  List<Object> get props => [stats];
}

class AdminUserListLoaded extends AdminState {
  final List<User> users; // Assuming User model from auth module
  const AdminUserListLoaded({required this.users});
  @override
  List<Object> get props => [users];
}

class AdminOperationSuccess extends AdminState {
  final String message;
  const AdminOperationSuccess({required this.message});
   @override
  List<Object> get props => [message];
}

class AdminOperationFailure extends AdminState {
  final String message;
  const AdminOperationFailure({required this.message});
  @override
  List<Object> get props => [message];
}

class AdminError extends AdminState { // For loading errors
  final String message;
  const AdminError({required this.message});
  @override
  List<Object> get props => [message];
}
