import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../models/favorito/favorito_model.dart';
// import '../../../models/alojamiento/alojamiento_model.dart'; // If FavoritosLoaded holds List<Alojamiento>
import '../../../services/favorito_service/favorito_service.dart'; // Placeholder

part 'favorito_event.dart';
part 'favorito_state.dart';

class FavoritoBloc extends Bloc<FavoritoEvent, FavoritoState> {
  final FavoritoService _favoritoService;
  // Store the list of favorite IDs locally for quick checks
  List<String> _currentFavoriteAlojamientoIds = [];

  FavoritoBloc(this._favoritoService) : super(FavoritosInitial()) {
    on<LoadFavoritos>(_onLoadFavoritos);
    on<AddFavorito>(_onAddFavorito);
    on<RemoveFavorito>(_onRemoveFavorito);
    on<CheckIsFavorito>(_onCheckIsFavorito);
  }

  Future<void> _onLoadFavoritos(LoadFavoritos event, Emitter<FavoritoState> emit) async {
    emit(FavoritosLoading());
    try {
      // final favoritos = await _favoritoService.getFavoritosByUsuario(event.usuarioId);
      // _currentFavoriteAlojamientoIds = favoritos.map((f) => f.alojamientoId).toList();
      // For mock:
      await Future.delayed(const Duration(milliseconds: 300));
      _currentFavoriteAlojamientoIds = _getMockUserFavoriteIds(event.usuarioId);

      // If you were fetching full Alojamiento objects:
      // List<Alojamiento> fullFavoritos = [];
      // for (String id in _currentFavoriteAlojamientoIds) {
      //   // final alojamiento = await _alojamientoService.getAlojamientoDetails(id); // Need AlojamientoService
      //   // if (alojamiento != null) fullFavoritos.add(alojamiento);
      // }
      // emit(FavoritosLoaded(alojamientosFavoritos: fullFavoritos));

      emit(FavoritosLoaded(alojamientoIdsFavoritos: List.from(_currentFavoriteAlojamientoIds)));
    } catch (e) {
      emit(FavoritosError(message: e.toString()));
    }
  }

  Future<void> _onAddFavorito(AddFavorito event, Emitter<FavoritoState> emit) async {
    // Optimistic update can be done here if needed, by adding to _currentFavoriteAlojamientoIds first
    // and emitting FavoritosLoaded, then making the call.
    // For simplicity, direct call:
    try {
      // final nuevoFavorito = await _favoritoService.addFavorito(event.usuarioId, event.alojamientoId);
      await Future.delayed(const Duration(milliseconds: 200)); // Simulate
      if (!_currentFavoriteAlojamientoIds.contains(event.alojamientoId)) {
        _currentFavoriteAlojamientoIds.add(event.alojamientoId);
      }
      emit(FavoritoOperationSuccess(message: 'Alojamiento añadido a favoritos.', alojamientoId: event.alojamientoId, isFavorito: true));
      // emit(FavoritosLoaded(alojamientoIdsFavoritos: List.from(_currentFavoriteAlojamientoIds))); // Also update the main list state
      // Or reload all: add(LoadFavoritos(usuarioId: event.usuarioId));
    } catch (e) {
      emit(FavoritoOperationFailure(message: 'Error al añadir favorito: ${e.toString()}'));
    }
  }

  Future<void> _onRemoveFavorito(RemoveFavorito event, Emitter<FavoritoState> emit) async {
    try {
      // await _favoritoService.removeFavorito(event.usuarioId, event.alojamientoId);
      await Future.delayed(const Duration(milliseconds: 200)); // Simulate
      _currentFavoriteAlojamientoIds.remove(event.alojamientoId);
      emit(FavoritoOperationSuccess(message: 'Alojamiento quitado de favoritos.', alojamientoId: event.alojamientoId, isFavorito: false));
      // emit(FavoritosLoaded(alojamientoIdsFavoritos: List.from(_currentFavoriteAlojamientoIds))); // Also update the main list state
      // Or reload all: add(LoadFavoritos(usuarioId: event.usuarioId));
    } catch (e) {
      emit(FavoritoOperationFailure(message: 'Error al quitar favorito: ${e.toString()}'));
    }
  }

  void _onCheckIsFavorito(CheckIsFavorito event, Emitter<FavoritoState> emit) {
    // This event is primarily for UI elements that need to know the status of a single item
    // without necessarily reloading all favorites. It relies on the _currentFavoriteAlojamientoIds.
    // Ensure LoadFavoritos has been called at least once.
    final isFav = _currentFavoriteAlojamientoIds.contains(event.alojamientoId);
    emit(IsFavoritoStatus(alojamientoId: event.alojamientoId, isFavorito: isFav));
  }

  // Mock data helper
  List<String> _getMockUserFavoriteIds(String usuarioId) {
    // Simulate different users having different favorites
    if (usuarioId == 'user123_with_favs') {
      return ['alo1', 'exp2']; // Assuming 'exp2' is an alojamientoId for this mock
    } else if (usuarioId == 'user_empty_favs') {
      return [];
    }
    return ['alo2']; // Default mock
  }
}
