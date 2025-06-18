import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../blocs/favorito_bloc/favorito_bloc.dart';
// import '../../../blocs/auth_bloc/auth_bloc.dart'; // To get current user ID

class FavoriteToggleIconWidget extends StatefulWidget {
  final String alojamientoId; // Could be generic itemId later
  final bool initialIsFavorito; // Optional: pass initial state to avoid flicker

  const FavoriteToggleIconWidget({
    super.key,
    required this.alojamientoId,
    this.initialIsFavorito = false, // Default to not favorite
  });

  @override
  State<FavoriteToggleIconWidget> createState() => _FavoriteToggleIconWidgetState();
}

class _FavoriteToggleIconWidgetState extends State<FavoriteToggleIconWidget> {
  late bool _isFavorito;

  @override
  void initState() {
    super.initState();
    _isFavorito = widget.initialIsFavorito;

    // In a real app, you might want to check the actual status from the BLoC
    // if not relying solely on an overall list that dictates this initial state.
    // final userId = context.read<AuthBloc>().state.user?.id;
    // if (userId != null) {
    //   context.read<FavoritoBloc>().add(CheckIsFavorito(usuarioId: userId, alojamientoId: widget.alojamientoId));
    // }
    print('FavoriteToggleIconWidget for ${widget.alojamientoId}: initial state $_isFavorito. Placeholder for fetching actual state.');
  }

  void _toggleFavorite() {
    // final userId = context.read<AuthBloc>().state.user?.id;
    // if (userId == null) {
    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Debes iniciar sesión para guardar favoritos.')));
    //   return;
    // }
    final String placeholderUserId = 'mock_user_for_fav_toggle';

    // final favoritoBloc = BlocProvider.of<FavoritoBloc>(context);
    if (_isFavorito) {
      // favoritoBloc.add(RemoveFavorito(usuarioId: userId, alojamientoId: widget.alojamientoId));
      print('Remove favorito: ${widget.alojamientoId} by user $placeholderUserId');
    } else {
      // favoritoBloc.add(AddFavorito(usuarioId: userId, alojamientoId: widget.alojamientoId));
      print('Add favorito: ${widget.alojamientoId} by user $placeholderUserId');
    }
    // Optimistically update UI, BLoC listener below would confirm/revert
    setState(() {
      _isFavorito = !_isFavorito;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return BlocListener<FavoritoBloc, FavoritoState>(
    //   listener: (context, state) {
    //     // Listen for updates specific to this item
    //     if (state is FavoritoOperationSuccess && state.alojamientoId == widget.alojamientoId) {
    //       if (mounted) { // Check if widget is still in the tree
    //         setState(() {
    //           _isFavorito = state.isFavorito;
    //         });
    //       }
    //     } else if (state is IsFavoritoStatus && state.alojamientoId == widget.alojamientoId) {
    //        if (mounted) {
    //          setState(() {
    //           _isFavorito = state.isFavorito;
    //         });
    //        }
    //     } else if (state is FavoritosLoaded) { // If the whole list reloads
    //        if (mounted) {
    //          setState(() {
    //           _isFavorito = state.isFavorito(widget.alojamientoId);
    //         });
    //        }
    //     }
    //   },
    //   child: IconButton(
    //     icon: Icon(
    //       _isFavorito ? Icons.favorite : Icons.favorite_border,
    //       color: _isFavorito ? Colors.pink : Colors.grey,
    //       size: 28.0, // Adjust size as needed
    //     ),
    //     tooltip: _isFavorito ? 'Quitar de favoritos' : 'Añadir a favoritos',
    //     onPressed: _toggleFavorite,
    //   ),
    // );

    // Placeholder button without BlocListener for now:
    return IconButton(
      icon: Icon(
        _isFavorito ? Icons.favorite : Icons.favorite_border,
        color: _isFavorito ? Colors.pink : Colors.grey[700],
        size: 28.0,
      ),
      tooltip: _isFavorito ? 'Quitar de favoritos' : 'Añadir a favoritos',
      onPressed: _toggleFavorite,
    );
  }
}
