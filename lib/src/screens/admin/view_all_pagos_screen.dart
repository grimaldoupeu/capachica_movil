import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../blocs/pago_bloc/pago_bloc.dart'; // Or a specific AdminPagosBloc
// import '../../models/pago/pago_model.dart';

class ViewAllPagosScreen extends StatelessWidget {
  const ViewAllPagosScreen({super.key});
  // TODO: Load all pagos using PagoBloc or a dedicated AdminPagosBloc

  @override
  Widget build(BuildContext context) {
    final mockPagos = [
      {'id': 'pago1', 'reservaId': 'res1', 'monto': 300.0, 'usuarioEmail': 'turista1@example.com', 'fecha': '2024-03-10', 'estado': 'Exitoso'},
      {'id': 'pago2', 'reservaId': 'res2', 'monto': 80.0, 'usuarioEmail': 'turista2@example.com', 'fecha': '2024-04-05', 'estado': 'Exitoso'},
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Todos los Pagos')),
      body: ListView.builder(
        itemCount: mockPagos.length,
        itemBuilder: (context, index) {
          final pago = mockPagos[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text('Pago ID: ${pago['id']} por ${pago['monto']} PEN'),
              subtitle: Text('Reserva ID: ${pago['reservaId']}\nUsuario: ${pago['usuarioEmail']}\nFecha: ${pago['fecha']} - Estado: ${pago['estado']}'),
              isThreeLine: true,
              // onTap: () { /* Navigate to Pago Detail for Admin */ },
            ),
          );
        },
      ),
    );
  }
}
