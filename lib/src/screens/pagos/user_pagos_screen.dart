import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../blocs/pago_bloc/pago_bloc.dart';
// import '../../models/pago/pago_model.dart';
// import 'package:intl/intl.dart'; // For date formatting

class UserPagosScreen extends StatefulWidget {
  const UserPagosScreen({super.key});

  @override
  State<UserPagosScreen> createState() => _UserPagosScreenState();
}

class _UserPagosScreenState extends State<UserPagosScreen> {
  @override
  void initState() {
    super.initState();
    // final userId = context.read<AuthBloc>().state.user?.id; // Example
    // if (userId != null) {
    //   BlocProvider.of<PagoBloc>(context).add(LoadUserPagos(usuarioId: userId));
    // }
    print('UserPagosScreen: InitState - Placeholder for loading user payments.');
  }

  String _formatFecha(DateTime fecha) {
    // return DateFormat('dd/MM/yyyy HH:mm').format(fecha);
    return '${fecha.day.toString().padLeft(2,'0')}/${fecha.month.toString().padLeft(2,'0')}/${fecha.year} ${fecha.hour.toString().padLeft(2,'0')}:${fecha.minute.toString().padLeft(2,'0')}';
  }

  IconData _getIconForTipoReserva(String tipoReservaStr) {
    // Assuming tipoReservaStr matches enum names like 'alojamiento', 'experiencia'
    if (tipoReservaStr == 'alojamiento') return Icons.hotel;
    if (tipoReservaStr == 'experiencia') return Icons.celebration;
    return Icons.receipt_long;
  }

  Color _getColorForEstadoPago(String estadoPagoStr) {
    if (estadoPagoStr == 'exitoso') return Colors.green;
    if (estadoPagoStr == 'fallido') return Colors.red;
    if (estadoPagoStr == 'pendiente') return Colors.orange;
    if (estadoPagoStr == 'reembolsado') return Colors.blueGrey;
    return Colors.grey;
  }


  @override
  Widget build(BuildContext context) {
    // Mock data for user's pagos
    final mockUserPagos = [
      {'id': 'pago1', 'reservaId': 'res1_alo', 'tipoReserva': 'alojamiento', 'monto': 300.0, 'metodoPagoSimulado': 'Visa **** 1234', 'estado': 'exitoso', 'fechaPago': DateTime.now().subtract(const Duration(days: 10, hours: 2))},
      {'id': 'pago2', 'reservaId': 'res2_exp', 'tipoReserva': 'experiencia', 'monto': 160.0, 'metodoPagoSimulado': 'MasterCard **** 5678', 'estado': 'exitoso', 'fechaPago': DateTime.now().subtract(const Duration(days: 2, hours: 5))},
      {'id': 'pago3', 'reservaId': 'res3_alo', 'tipoReserva': 'alojamiento', 'monto': 250.0, 'metodoPagoSimulado': 'Visa **** 1234', 'estado': 'fallido', 'fechaPago': DateTime.now().subtract(const Duration(days: 1, hours: 1))},
      {'id': 'pago4', 'reservaId': 'res4_alo', 'tipoReserva': 'alojamiento', 'monto': 120.0, 'metodoPagoSimulado': 'PayPal', 'estado': 'pendiente', 'fechaPago': DateTime.now().subtract(const Duration(hours: 3))},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Historial de Pagos')),
      // body: BlocBuilder<PagoBloc, PagoState>(
      //   builder: (context, state) {
      //     if (state is PagoLoading && state.message == 'Cargando historial de pagos...') {
      //       return const Center(child: CircularProgressIndicator());
      //     } else if (state is UserPagosLoaded) {
      //       if (state.pagos.isEmpty) {
      //         return const Center(child: Text('No tienes pagos registrados.'));
      //       }
      //       return ListView.builder(
      //         itemCount: state.pagos.length,
      //         itemBuilder: (context, index) {
      //           final pago = state.pagos[index];
      //           return Card(
      //             margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      //             child: ListTile(
      //               leading: Icon(_getIconForTipoReserva(pago.tipoReserva.name), size: 30),
      //               title: Text('Pago por ${pago.tipoReserva.name} (${pago.reservaId})'),
      //               subtitle: Text('Monto: \$${pago.monto.toStringAsFixed(2)} PEN\nMétodo: ${pago.metodoPagoSimulado}\nFecha: ${_formatFecha(pago.fechaPago)}'),
      //               trailing: Text(pago.estado.name.toUpperCase(), style: TextStyle(color: _getColorForEstadoPago(pago.estado.name), fontWeight: FontWeight.bold)),
      //               isThreeLine: true,
      //               onTap: () { /* Maybe show more details or receipt */ }
      //             ),
      //           );
      //         },
      //       );
      //     } else if (state is PagosError) {
      //       return Center(child: Text('Error al cargar historial: ${state.message}'));
      //     }
      //     return const Center(child: Text('Cargando historial de pagos...'));
      //   },
      // ),
      body: mockUserPagos.isEmpty
        ? const Center(child: Text('No tienes pagos registrados.'))
        : ListView.separated(
            padding: const EdgeInsets.all(8.0),
            itemCount: mockUserPagos.length,
            separatorBuilder: (context, index) => const SizedBox(height: 4),
            itemBuilder: (context, index) {
              final pago = mockUserPagos[index];
              final tipoReservaStr = pago['tipoReserva'] as String? ?? 'otro';
              final estadoPagoStr = pago['estado'] as String? ?? 'desconocido';

              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Icon(_getIconForTipoReserva(tipoReservaStr), size: 36, color: Theme.of(context).primaryColor),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Reserva de ${tipoReservaStr.replaceFirst(tipoReservaStr[0], tipoReservaStr[0].toUpperCase())}',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text('ID Reserva: ${pago['reservaId']}', style: Theme.of(context).textTheme.bodySmall),
                            const SizedBox(height: 4),
                            Text('Monto: \$${(pago['monto'] as double).toStringAsFixed(2)} PEN', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                            Text('Método: ${pago['metodoPagoSimulado']}', style: Theme.of(context).textTheme.bodySmall),
                            Text('Fecha: ${_formatFecha(pago['fechaPago'] as DateTime)}', style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getColorForEstadoPago(estadoPagoStr).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          estadoPagoStr.toUpperCase(),
                          style: TextStyle(
                            color: _getColorForEstadoPago(estadoPagoStr),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }
}
