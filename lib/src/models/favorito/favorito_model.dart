import 'package:equatable/equatable.dart';

class Favorito extends Equatable {
  final String id; // Unique ID for the favorite entry itself
  final String usuarioId;
  final String alojamientoId; // ID of the favorited accommodation
  final DateTime fechaAgregado;

  // Optional: Could denormalize some Alojamiento info here if displaying
  // a list of Favorito objects directly, e.g., nombreAlojamiento, urlFotoPrincipal.
  // However, it's often better to fetch full Alojamiento details separately
  // or have the BLoC manage a list of full Alojamiento objects that are favorites.

  const Favorito({
    required this.id,
    required this.usuarioId,
    required this.alojamientoId,
    required this.fechaAgregado,
  });

  @override
  List<Object?> get props => [id, usuarioId, alojamientoId, fechaAgregado];
}
