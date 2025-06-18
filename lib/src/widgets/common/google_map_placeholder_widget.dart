import 'package:flutter/material.dart';

class GoogleMapPlaceholderWidget extends StatelessWidget {
  final double? latitud;
  final double? longitud;
  final String? markerId;
  final String? markerLabel;

  const GoogleMapPlaceholderWidget({
    super.key,
    this.latitud,
    this.longitud,
    this.markerId,
    this.markerLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200, // Default height
      decoration: BoxDecoration(
        color: Colors.grey[300],
        border: Border.all(color: Colors.grey[400]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.map_outlined, size: 48, color: Colors.grey[700]),
            const SizedBox(height: 8),
            Text(
              'Google Maps Placeholder',
              style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold),
            ),
            if (latitud != null && longitud != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Lat: $latitud, Lng: $longitud\nMarker: ${markerLabel ?? markerId ?? 'Punto'}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ),
            const SizedBox(height: 4),
            Text(
              '(Integración de Google Maps pendiente)',
              style: TextStyle(fontSize: 10, color: Colors.grey[500]),
            )
          ],
        ),
      ),
    );
  }
}
