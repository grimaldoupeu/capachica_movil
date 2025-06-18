part of 'favorito_bloc.dart';

abstract class FavoritoEvent extends Equatable {
  const FavoritoEvent();
  @override
  List<Object?> get props => [];
}

class LoadFavoritos extends FavoritoEvent {
  final String usuarioId;
  const LoadFavoritos({required this.usuarioId});
  @override
  List<Object> get props => [usuarioId];
}

class AddFavorito extends FavoritoEvent {
  final String usuarioId;
  final String alojamientoId;
  // final Alojamiento alojamientoData; // Optionally pass full data to optimistically update UI

  const AddFavorito({
    required this.usuarioId,
    required this.alojamientoId,
    // required this.alojamientoData
  });

  @override
  List<Object> get props => [usuarioId, alojamientoId];
}

class RemoveFavorito extends FavoritoEvent {
  final String usuarioId; // For validation/scoping
  final String alojamientoId; // More common to identify by what was favorited
  // Or: final String favoritoId; // If you have the ID of the Favorito entry

  const RemoveFavorito({required this.usuarioId, required this.alojamientoId});

  @override
  List<Object> get props => [usuarioId, alojamientoId];
}

// Event to check if a specific item is a favorite, useful for UI updates
class CheckIsFavorito extends FavoritoEvent {
  final String usuarioId;
  final String alojamientoId;
  const CheckIsFavorito({required this.usuarioId, required this.alojamientoId});
   @override
  List<Object> get props => [usuarioId, alojamientoId];
}
