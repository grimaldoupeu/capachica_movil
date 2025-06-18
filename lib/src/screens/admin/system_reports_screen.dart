import 'package:flutter/material.dart';

class SystemReportsScreen extends StatelessWidget {
  const SystemReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reportes del Sistema')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.construction, size: 60, color: Colors.grey),
              SizedBox(height: 20),
              Text(
                'Página de Reportes en Construcción',
                style: TextStyle(fontSize: 22, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Aquí se mostrarán estadísticas detalladas, gráficos y reportes sobre el rendimiento de la plataforma.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
