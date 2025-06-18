// Placeholder for PagoService
import '../../models/pago/pago_model.dart';

class PagoService {
  // Mock in-memory store for payments
  final List<Pago> _mockPagosDb = [
      Pago(id: 'srv_pago1', reservaId: 'res1_alo', tipoReserva: TipoReservaPago.alojamiento, usuarioId: 'currentUser_mock_id', monto: 300.0, metodoPagoSimulado: 'Visa **** 1234', estado: EstadoPago.exitoso, fechaPago: DateTime.now().subtract(const Duration(days: 10)), transaccionIdSimulada: 'txn_mock_srv_1'),
      Pago(id: 'srv_pago2', reservaId: 'res2_exp', tipoReserva: TipoReservaPago.experiencia, usuarioId: 'currentUser_mock_id', monto: 160.0, metodoPagoSimulado: 'MasterCard **** 5678', estado: EstadoPago.exitoso, fechaPago: DateTime.now().subtract(const Duration(days: 2)), transaccionIdSimulada: 'txn_mock_srv_2'),
  ];

  Future<Pago> recordPago({
    required String reservaId,
    required TipoReservaPago tipoReserva,
    required String usuarioId,
    required double monto,
    required String metodoPagoSimulado,
    // String tokenGateway, // Real parameter
  }) async {
    print('PagoService (Placeholder): Recording payment...');
    await Future.delayed(const Duration(seconds: 1)); // Simulate gateway interaction

    // Simulate success/failure based on some condition for mock
    bool mockPaymentSuccess = monto < 5000; // Fail if amount is too high for mock

    final nuevoPago = Pago(
      id: 'pago_srv_${DateTime.now().millisecondsSinceEpoch}',
      reservaId: reservaId,
      tipoReserva: tipoReserva,
      usuarioId: usuarioId,
      monto: monto,
      metodoPagoSimulado: metodoPagoSimulado,
      estado: mockPaymentSuccess ? EstadoPago.exitoso : EstadoPago.fallido,
      fechaPago: DateTime.now(),
      transaccionIdSimulada: mockPaymentSuccess ? 'txn_mock_srv_${DateTime.now().millisecondsSinceEpoch}' : null,
    );

    if (mockPaymentSuccess) {
      _mockPagosDb.add(nuevoPago);
      return nuevoPago;
    } else {
      // Even if payment fails, we might still record an attempt.
      // Or just throw an exception.
      // _mockPagosDb.add(nuevoPago); // Optionally record failed attempts too
      throw Exception('Simulación de pago fallido por el gateway.');
    }
  }

  Future<List<Pago>> getUserPagos(String usuarioId) async {
    print('PagoService (Placeholder): Fetching pagos for user $usuarioId');
    await Future.delayed(const Duration(milliseconds: 200));
    return _mockPagosDb.where((p) => p.usuarioId == usuarioId || p.usuarioId == 'currentUser_mock_id').toList();
  }
}
