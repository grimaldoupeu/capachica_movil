import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../blocs/reserva_bloc/reserva_bloc.dart'; // Or a specific AdminReservasBloc
// import '../../models/reserva/reserva_model.dart';

class ViewAllReservasScreen extends StatelessWidget {
  const ViewAllReservasScreen({super.key});
  // TODO: Load all reservas using ReservaBloc or a dedicated AdminReservasBloc

  @override
  Widget build(BuildContext context) {
     final mockReservas = [
      {'id': 'res1', 'alojamientoNombre': 'Cabaña del Sol', 'usuarioEmail': 'turista1@example.com', 'fechaInicio': '2024-03-10', 'estado': 'Completada'},
      {'id': 'res2', 'experienciaNombre': 'Tour Kayak', 'usuarioEmail': 'turista2@example.com', 'fechaInicio': '2024-04-05', 'estado': 'Confirmada'},
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Todas las Reservas')),
      body: ListView.builder(
        itemCount: mockReservas.length,
        itemBuilder: (context, index) {
          final reserva = mockReservas[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text('Reserva ID: ${reserva['id']} para ${reserva['alojamientoNombre'] ?? reserva['experienciaNombre']}'),
              subtitle: Text('Usuario: ${reserva['usuarioEmail']}\nFecha: ${reserva['fechaInicio']} - Estado: ${reserva['estado']}'),
              isThreeLine: true,
              // onTap: () { /* Navigate to Reserva Detail for Admin */ },
            ),
          );
        },
      ),
    );
  }
}
