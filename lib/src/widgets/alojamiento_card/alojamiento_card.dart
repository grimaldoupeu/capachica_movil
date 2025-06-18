import 'package:flutter/material.dart';
// import '../../models/alojamiento/alojamiento_model.dart'; // If using the actual model
// import '../../screens/alojamientos/alojamiento_detail_screen.dart'; // For navigation

class AlojamientoCard extends StatelessWidget {
  // final Alojamiento alojamiento; // In a real app
  final Map<String, dynamic> alojamientoData; // Using Map for placeholder

  const AlojamientoCard({super.key, required this.alojamientoData});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          // Navigator.of(context).push(MaterialPageRoute(
          //   builder: (_) => AlojamientoDetailScreen(alojamientoId: alojamiento.id),
          // ));
          print('Tapped on card: ${alojamientoData['nombre']} (ID: ${alojamientoData['id']})');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Navigate to details for ${alojamientoData['nombre']}')),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Image.network(
                alojamientoData['urlFoto'] ?? 'https://via.placeholder.com/300x180.png?text=Alojamiento',
                height: 180,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 180,
                  color: Colors.grey[200],
                  child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(alojamientoData['nombre'] ?? 'Nombre no disponible', style: textTheme.titleLarge),
                  const SizedBox(height: 4),
                  Text(
                    '\$${(alojamientoData['precioPorNoche'] ?? 0.0).toStringAsFixed(2)} por noche',
                    style: textTheme.titleMedium?.copyWith(color: Theme.of(context).primaryColor),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_pin, color: Colors.grey[600], size: 16),
                      const SizedBox(width: 4),
                      Text(alojamientoData['ciudad'] ?? 'Ciudad no disponible', style: textTheme.bodySmall),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${alojamientoData['calificacionPromedio'] ?? '-.-'} (${alojamientoData['numeroDeResenas'] ?? 0} reseñas)',
                        style: textTheme.bodySmall,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
