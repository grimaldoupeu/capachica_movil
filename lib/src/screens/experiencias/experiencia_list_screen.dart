import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../blocs/experiencia_bloc/experiencia_bloc.dart';
// import '../../models/experiencia/experiencia_model.dart';
// import './experiencia_detail_screen.dart'; // For navigation

class ExperienciaListScreen extends StatelessWidget {
  const ExperienciaListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // For placeholder:
    final mockExperiencias = [
      {'id': 'exp1', 'nombre': 'Tour en Kayak por Uros', 'precioPorPersona': 80.0, 'categoria': 'Tour Guiado', 'urlFoto': 'https://via.placeholder.com/150x100.png?text=Kayak+Uros', 'calificacionPromedio': 4.5},
      {'id': 'exp2', 'nombre': 'Taller de Textiles en Taquile', 'precioPorPersona': 120.0, 'categoria': 'Taller Cultural', 'urlFoto': 'https://via.placeholder.com/150x100.png?text=Textiles+Taquile', 'calificacionPromedio': 4.8},
      {'id': 'exp3', 'nombre': 'Pachamanca Tradicional', 'precioPorPersona': 150.0, 'categoria': 'Gastronomía', 'urlFoto': 'https://via.placeholder.com/150x100.png?text=Pachamanca', 'calificacionPromedio': 4.9},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Experiencias en Capachica'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              print('Filter experiencias button pressed');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Placeholder for Experiencia Filters')),
              );
            },
          ),
        ],
      ),
      body:
      // BlocBuilder<ExperienciaBloc, ExperienciaState>(
      //   builder: (context, state) {
      //     if (state is ExperienciasLoading) {
      //       return const Center(child: CircularProgressIndicator());
      //     } else if (state is ExperienciasLoaded) {
      //       if (state.experiencias.isEmpty) {
      //         return const Center(child: Text('No hay experiencias disponibles.'));
      //       }
      //       return ListView.builder(
      //         itemCount: state.experiencias.length,
      //         itemBuilder: (context, index) {
      //           final experiencia = state.experiencias[index];
      //           return Card(
      //             margin: const EdgeInsets.all(8.0),
      //             child: ListTile(
      //               leading: experiencia.fotos.isNotEmpty ? Image.network(experiencia.fotos.first.url, width: 100, fit: BoxFit.cover) : const SizedBox(width:100, child: Icon(Icons.photo_camera)),
      //               title: Text(experiencia.nombre),
      //               subtitle: Text('${experiencia.categoria.name}\n\$${experiencia.precioPorPersona.toStringAsFixed(2)} por persona'),
      //               isThreeLine: true,
      //               onTap: () {
      //                 // Navigator.of(context).push(MaterialPageRoute(builder: (_) => ExperienciaDetailScreen(experienciaId: experiencia.id)));
      //                 print('Tapped on ${experiencia.nombre}');
      //               },
      //             ),
      //           );
      //         },
      //       );
      //     } else if (state is ExperienciasError) {
      //       return Center(child: Text('Error: ${state.message}'));
      //     }
      //     return const Center(child: Text('Cargando experiencias...'));
      //   },
      // ),
      // Placeholder ListView:
      ListView.builder(
        itemCount: mockExperiencias.length,
        itemBuilder: (context, index) {
          final experiencia = mockExperiencias[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: InkWell(
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(builder: (_) => ExperienciaDetailScreen(experienciaId: experiencia['id']! as String)));
                print('Tapped on ${experiencia['nombre']} (ID: ${experiencia['id']})');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Navigate to details for ${experiencia['nombre']}')),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    child: Image.network(
                      experiencia['urlFoto']! as String,
                      height: 160,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 100),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(experiencia['categoria']! as String, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600])),
                        const SizedBox(height: 4),
                        Text(experiencia['nombre']! as String, style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 8),
                        Text('\$${(experiencia['precioPorPersona']! as double).toStringAsFixed(2)} PEN por persona', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            Text(' ${experiencia['calificacionPromedio'] ?? '-.-'}', style: Theme.of(context).textTheme.bodySmall),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      // FloatingActionButton( // Example to trigger load
      //   onPressed: () {
      //     // BlocProvider.of<ExperienciaBloc>(context).add(const LoadExperiencias());
      //   },
      //   child: const Icon(Icons.refresh),
      // ),
    );
  }
}
