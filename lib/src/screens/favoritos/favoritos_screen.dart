import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../blocs/favorito_bloc/favorito_bloc.dart';
// import '../../blocs/alojamiento_bloc/alojamiento_bloc.dart'; // To fetch full alojamiento details
// import '../../models/alojamiento/alojamiento_model.dart';
// import '../../widgets/alojamiento_card/alojamiento_card.dart'; // Re-use existing card

class FavoritosScreen extends StatefulWidget {
  const FavoritosScreen({super.key});

  @override
  State<FavoritosScreen> createState() => _FavoritosScreenState();
}

class _FavoritosScreenState extends State<FavoritosScreen> {
  @override
  void initState() {
    super.initState();
    // final userId = context.read<AuthBloc>().state.user?.id; // Example
    // if (userId != null) {
    //   BlocProvider.of<FavoritoBloc>(context).add(LoadFavoritos(usuarioId: userId));
    // }
    print('FavoritosScreen: InitState - Placeholder for loading user favorites.');
  }

  @override
  Widget build(BuildContext context) {
    // Mock data for favorite alojamientos (assuming we get full Alojamiento objects)
    final mockFavoriteAlojamientos = [
      // These would ideally be full Alojamiento objects fetched based on favorite IDs
      {'id': 'alo1', 'nombre': 'Cabaña del Sol (Favorito)', 'precioPorNoche': 150.0, 'urlFoto': 'https://via.placeholder.com/150x100.png?text=Fav+Cabaña', 'ciudad': 'Capachica', 'calificacionPromedio': 4.5, 'numeroDeResenas': 25},
      {'id': 'alo2', 'nombre': 'Casa Rural Pacha Mama (Favorito)', 'precioPorNoche': 120.0, 'urlFoto': 'https://via.placeholder.com/150x100.png?text=Fav+Pacha', 'ciudad': 'Llachon', 'calificacionPromedio': 4.8, 'numeroDeResenas': 30},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Mis Favoritos')),
      // body: BlocBuilder<FavoritoBloc, FavoritoState>(
      //   builder: (context, state) {
      //     if (state is FavoritosLoading) {
      //       return const Center(child: CircularProgressIndicator());
      //     } else if (state is FavoritosLoaded) {
      //       // If state.alojamientoIdsFavoritos is used, you'd need another BlocBuilder
      //       // for AlojamientoBloc to fetch details for each ID.
      //       // For simplicity, if FavoritosLoaded directly contains List<Alojamiento>
      //       // final List<Alojamiento> favAlojamientos = state.alojamientosFavoritos;

      //       // Using IDs and fetching details (conceptual):
      //       // if (state.alojamientoIdsFavoritos.isEmpty) {
      //       //   return const Center(child: Text('No tienes alojamientos guardados en favoritos.'));
      //       // }
      //       // return ListView.builder(
      //       //   itemCount: state.alojamientoIdsFavoritos.length,
      //       //   itemBuilder: (context, index) {
      //       //     final alojamientoId = state.alojamientoIdsFavoritos[index];
      //       //     // Here you would fetch the Alojamiento details using AlojamientoBloc
      //       //     // or have a way to get it from a list of pre-fetched alojamientos.
      //       //     // For now, just display the ID or use a mock.
      //       //     // return AlojamientoCard(alojamiento: fetchedAlojamiento);
      //       //     return ListTile(title: Text('Favorito: Alojamiento ID ${alojamientoId}'));
      //       //   },
      //       // );

      //       // Placeholder using mock full objects:
      //       if (mockFavoriteAlojamientos.isEmpty) { // Replace with actual list from state if it holds full objects
      //            return const Center(child: Text('No tienes alojamientos guardados en favoritos.'));
      //       }
      //       return ListView.builder(
      //         itemCount: mockFavoriteAlojamientos.length,
      //         itemBuilder: (context, index) {
      //           final alojamientoData = mockFavoriteAlojamientos[index];
      //           // return AlojamientoCard(alojamientoData: alojamientoData); // If AlojamientoCard takes Map
      //           // For a simpler list item:
      //           return Card(
      //               margin: const EdgeInsets.all(8),
      //               child: ListTile(
      //                   leading: Image.network(alojamientoData['urlFoto'] as String, width: 100, fit: BoxFit.cover, errorBuilder: (c,e,s) => Icon(Icons.image_not_supported)),
      //                   title: Text(alojamientoData['nombre'] as String),
      //                   subtitle: Text('\$${(alojamientoData['precioPorNoche'] as double).toStringAsFixed(2)} / noche'),
      //                   // trailing: FavoriteToggleIconWidget(alojamientoId: alojamientoData['id'] as String, /* Pass initial state or let it fetch */),
      //                   onTap: () { /* Navigate to detail */ }
      //               )
      //           );
      //         }
      //       );

      //     } else if (state is FavoritosError) {
      //       return Center(child: Text('Error al cargar favoritos: ${state.message}'));
      //     }
      //     return const Center(child: Text('Cargando tus favoritos...'));
      //   },
      // ),
      body: mockFavoriteAlojamientos.isEmpty
          ? const Center(child: Text('Aún no has añadido nada a favoritos.'))
          : ListView.builder(
              itemCount: mockFavoriteAlojamientos.length,
              itemBuilder: (context, index) {
                final favData = mockFavoriteAlojamientos[index];
                // return AlojamientoCard(alojamientoData: favData); // Assuming AlojamientoCard is adapted
                // Simplified version for this screen:
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal:16, vertical: 8),
                  child: ListTile(
                    leading: Image.network(
                      favData['urlFoto'] as String,
                      width: 80, height: 80, fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(Icons.business_outlined, size: 40),
                    ),
                    title: Text(favData['nombre'] as String),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('\$${(favData['precioPorNoche'] as num).toStringAsFixed(2)} PEN por noche'),
                        Text(favData['ciudad'] as String? ?? 'Ubicación no disponible'),
                      ],
                    ),
                    trailing: IconButton( // Placeholder for FavoriteToggleIconWidget
                      icon: const Icon(Icons.favorite, color: Colors.pink), // Assuming it's a favorite
                      onPressed: () {
                        // BlocProvider.of<FavoritoBloc>(context).add(RemoveFavorito(usuarioId: 'current_user_id', alojamientoId: favData['id'] as String));
                        print('Remove ${favData['id']} from favorites (placeholder)');
                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Quitar ${favData['nombre']} de favoritos (placeholder)')));
                      },
                    ),
                    isThreeLine: true,
                    onTap: () {
                      print('Navigate to Alojamiento Detail: ${favData['id']}');
                      // Navigator.push(context, MaterialPageRoute(builder: (_) => AlojamientoDetailScreen(alojamientoId: favData['id'] as String)));
                    },
                  ),
                );
              },
            ),
    );
  }
}
