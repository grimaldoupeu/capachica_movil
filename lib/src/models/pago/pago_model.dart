import 'package:equatable/equatable.dart';

enum TipoReservaPago {
  alojamiento,
  experiencia,
  otro
}

enum EstadoPago {
  pendiente,
  exitoso,
  fallido,
  reembolsado
}

class Pago extends Equatable {
  final String id; // Unique ID for the payment record
  final String reservaId; // ID of the ReservaAlojamiento or ReservaExperiencia
  final TipoReservaPago tipoReserva;
  final String usuarioId;
  final double monto;
  final String metodoPagoSimulado; // e.g., 'Tarjeta Visa **** 1234', 'PayPal Simulado'
  final EstadoPago estado;
  final DateTime fechaPago;
  final String? transaccionIdSimulada; // Mock transaction ID

  const Pago({
    required this.id,
    required this.reservaId,
    required this.tipoReserva,
    required this.usuarioId,
    required this.monto,
    required this.metodoPagoSimulado,
    required this.estado,
    required this.fechaPago,
    this.transaccionIdSimulada,
  });

  @override
  List<Object?> get props => [
        id,
        reservaId,
        tipoReserva,
        usuarioId,
        monto,
        metodoPagoSimulado,
        estado,
        fechaPago,
        transaccionIdSimulada,
      ];
}
