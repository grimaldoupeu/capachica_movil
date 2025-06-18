part of 'favorito_bloc.dart';

abstract class FavoritoState extends Equatable {
  const FavoritoState();
  @override
  List<Object?> get props => [];
}

class FavoritosInitial extends FavoritoState {}

class FavoritosLoading extends FavoritoState {}

// This state could hold a list of Favorito objects or a list of full Alojamiento objects.
// For simplicity with mock data and avoiding complex joins now, let's assume it holds Alojamiento IDs.
// A more advanced implementation might hold full Alojamiento objects.
class FavoritosLoaded extends FavoritoState {
  final List<String> alojamientoIdsFavoritos; // List of IDs of favorited alojamientos
  // OR: final List<Alojamiento> alojamientosFavoritos;
  // OR: final List<Favorito> favoritos; // List of Favorito link objects

  const FavoritosLoaded({required this.alojamientoIdsFavoritos});

  @override
  List<Object> get props => [alojamientoIdsFavoritos];

  // Helper to check if an ID is in the list
  bool isFavorito(String alojamientoId) => alojamientoIdsFavoritos.contains(alojamientoId);
}

class IsFavoritoStatus extends FavoritoState {
  final String alojamientoId;
  final bool isFavorito;
  const IsFavoritoStatus({required this.alojamientoId, required this.isFavorito});
   @override
  List<Object> get props => [alojamientoId, isFavorito];
}


class FavoritoOperationSuccess extends FavoritoState {
  final String message;
  final String alojamientoId; // ID of item affected
  final bool isFavorito; // New status
  const FavoritoOperationSuccess({required this.message, required this.alojamientoId, required this.isFavorito});
   @override
  List<Object> get props => [message, alojamientoId, isFavorito];
}

class FavoritoOperationFailure extends FavoritoState {
  final String message;
  const FavoritoOperationFailure({required this.message});
  @override
  List<Object> get props => [message];
}

class FavoritosError extends FavoritoState { // For loading errors
  final String message;
  const FavoritosError({required this.message});
  @override
  List<Object> get props => [message];
}
