part of 'pago_bloc.dart';

abstract class PagoEvent extends Equatable {
  const PagoEvent();
  @override
  List<Object?> get props => [];
}

class RecordPago extends PagoEvent {
  final String reservaId;
  final TipoReservaPago tipoReserva;
  final String usuarioId;
  final double monto;
  final String metodoPagoSimulado;
  // final String tokenGateway; // In a real scenario

  const RecordPago({
    required this.reservaId,
    required this.tipoReserva,
    required this.usuarioId,
    required this.monto,
    required this.metodoPagoSimulado,
    // required this.tokenGateway,
  });

  @override
  List<Object> get props => [reservaId, tipoReserva, usuarioId, monto, metodoPagoSimulado];
}

class LoadUserPagos extends PagoEvent {
  final String usuarioId;
  const LoadUserPagos({required this.usuarioId});
  @override
  List<Object> get props => [usuarioId];
}
