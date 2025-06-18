part of 'experiencia_bloc.dart';

abstract class ExperienciaState extends Equatable {
  const ExperienciaState();
  @override
  List<Object?> get props => [];
}

class ExperienciasInitial extends ExperienciaState {}

class ExperienciasLoading extends ExperienciaState {}

class ExperienciasLoaded extends ExperienciaState {
  final List<Experiencia> experiencias;
  const ExperienciasLoaded({required this.experiencias});
  @override
  List<Object> get props => [experiencias];
}

class ExperienciaDetailsLoading extends ExperienciaState {}

class ExperienciaDetailsLoaded extends ExperienciaState {
  final Experiencia experiencia;
  const ExperienciaDetailsLoaded({required this.experiencia});
  @override
  List<Object> get props => [experiencia];
}

class ReservaExperienciaInProgress extends ExperienciaState {}

class ReservaExperienciaSuccess extends ExperienciaState {
  final ReservaExperiencia reservaExperiencia;
  const ReservaExperienciaSuccess({required this.reservaExperiencia});
  @override
  List<Object> get props => [reservaExperiencia];
}

class ReservaExperienciaFailure extends ExperienciaState {
  final String message;
  const ReservaExperienciaFailure({required this.message});
  @override
  List<Object> get props => [message];
}

class UserReservasExperienciaLoading extends ExperienciaState {}

class UserReservasExperienciaLoaded extends ExperienciaState {
    final List<ReservaExperiencia> reservas;
    const UserReservasExperienciaLoaded({required this.reservas});
    @override
    List<Object> get props => [reservas];
}

class ExperienciaOperationSuccess extends ExperienciaState { // For Admin CRUD
  final String message;
  final Experiencia? experiencia; // Optional: return created/updated object
  const ExperienciaOperationSuccess({required this.message, this.experiencia});
   @override
  List<Object?> get props => [message, experiencia];
}

class ExperienciaOperationFailure extends ExperienciaState { // For Admin CRUD
  final String message;
  const ExperienciaOperationFailure({required this.message});
  @override
  List<Object> get props => [message];
}

class ExperienciasError extends ExperienciaState {
  final String message;
  const ExperienciasError({required this.message});
  @override
  List<Object> get props => [message];
}
