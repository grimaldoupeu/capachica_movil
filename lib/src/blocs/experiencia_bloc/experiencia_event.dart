part of 'experiencia_bloc.dart';

abstract class ExperienciaEvent extends Equatable {
  const ExperienciaEvent();
  @override
  List<Object?> get props => [];
}

class LoadExperiencias extends ExperienciaEvent {
  final CategoriaExperiencia? categoria; // Optional filter by category
  const LoadExperiencias({this.categoria});
   @override
  List<Object?> get props => [categoria];
}

class LoadExperienciaDetails extends ExperienciaEvent {
  final String experienciaId;
  const LoadExperienciaDetails({required this.experienciaId});
  @override
  List<Object> get props => [experienciaId];
}

class CreateReservaExperiencia extends ExperienciaEvent {
  final String experienciaId;
  final String usuarioId;
  final DateTime fechaHoraExperiencia;
  final int numeroPersonas;
  final double costoTotalReserva; // Should be calculated and confirmed
  final String? notasAdicionales;

  const CreateReservaExperiencia({
    required this.experienciaId,
    required this.usuarioId,
    required this.fechaHoraExperiencia,
    required this.numeroPersonas,
    required this.costoTotalReserva,
    this.notasAdicionales,
  });
  @override
  List<Object?> get props => [experienciaId, usuarioId, fechaHoraExperiencia, numeroPersonas, costoTotalReserva, notasAdicionales];
}

// Admin events
class CreateExperiencia extends ExperienciaEvent {
  final Experiencia experienciaData; // Pass the whole model for creation
  const CreateExperiencia({required this.experienciaData});
   @override
  List<Object> get props => [experienciaData];
}

class UpdateExperiencia extends ExperienciaEvent {
  final Experiencia experienciaData;
  const UpdateExperiencia({required this.experienciaData});
  @override
  List<Object> get props => [experienciaData];
}

class DeleteExperiencia extends ExperienciaEvent {
  final String experienciaId;
  const DeleteExperiencia({required this.experienciaId});
  @override
  List<Object> get props => [experienciaId];
}

class LoadUserReservasExperiencia extends ExperienciaEvent {
  final String usuarioId;
  const LoadUserReservasExperiencia({required this.usuarioId});
  @override
  List<Object> get props => [usuarioId];
}
