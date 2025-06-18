import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../models/pago/pago_model.dart';
import '../../../services/pago_service/pago_service.dart'; // Placeholder

part 'pago_event.dart';
part 'pago_state.dart';

class PagoBloc extends Bloc<PagoEvent, PagoState> {
  final PagoService _pagoService;

  PagoBloc(this._pagoService) : super(PagoInitial()) {
    on<RecordPago>(_onRecordPago);
    on<LoadUserPagos>(_onLoadUserPagos);
  }

  Future<void> _onRecordPago(RecordPago event, Emitter<PagoState> emit) async {
    emit(const PagoProcessing(message: 'Procesando pago simulado...'));
    try {
      // final nuevoPago = await _pagoService.recordPago(
      //   reservaId: event.reservaId,
      //   tipoReserva: event.tipoReserva,
      //   usuarioId: event.usuarioId,
      //   monto: event.monto,
      //   metodoPagoSimulado: event.metodoPagoSimulado,
      // );
      await Future.delayed(const Duration(seconds: 2)); // Simulate payment processing
      final nuevoPago = Pago(
        id: 'pago_${DateTime.now().millisecondsSinceEpoch}',
        reservaId: event.reservaId,
        tipoReserva: event.tipoReserva,
        usuarioId: event.usuarioId,
        monto: event.monto,
        metodoPagoSimulado: event.metodoPagoSimulado,
        estado: EstadoPago.exitoso, // Assume success for mock
        fechaPago: DateTime.now(),
        transaccionIdSimulada: 'txn_mock_${DateTime.now().millisecondsSinceEpoch}',
      );
      emit(PagoSuccess(pago: nuevoPago));
      // After successful payment, you might want to update the Reserva state as well (e.g., to 'confirmada')
      // This would require inter-bloc communication or a higher-level coordinator.
    } catch (e) {
      emit(PagoFailure(message: 'Error al registrar pago: ${e.toString()}'));
    }
  }

  Future<void> _onLoadUserPagos(LoadUserPagos event, Emitter<PagoState> emit) async {
    emit(const PagoLoading(message: 'Cargando historial de pagos...'));
    try {
      // final pagos = await _pagoService.getUserPagos(event.usuarioId);
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate
      final mockPagos = _getMockUserPagos(event.usuarioId);
      emit(UserPagosLoaded(pagos: mockPagos));
    } catch (e) {
      emit(PagosError(message: 'Error al cargar pagos: ${e.toString()}'));
    }
  }

  List<Pago> _getMockUserPagos(String usuarioId) {
    return [
      Pago(id: 'pago1', reservaId: 'res1_alo', tipoReserva: TipoReservaPago.alojamiento, usuarioId: usuarioId, monto: 300.0, metodoPagoSimulado: 'Visa **** 1234', estado: EstadoPago.exitoso, fechaPago: DateTime.now().subtract(const Duration(days: 10)), transaccionIdSimulada: 'txn_mock_1'),
      Pago(id: 'pago2', reservaId: 'res2_exp', tipoReserva: TipoReservaPago.experiencia, usuarioId: usuarioId, monto: 160.0, metodoPagoSimulado: 'MasterCard **** 5678', estado: EstadoPago.exitoso, fechaPago: DateTime.now().subtract(const Duration(days: 2)), transaccionIdSimulada: 'txn_mock_2'),
      Pago(id: 'pago3', reservaId: 'res3_alo', tipoReserva: TipoReservaPago.alojamiento, usuarioId: usuarioId, monto: 250.0, metodoPagoSimulado: 'Visa **** 1234', estado: EstadoPago.fallido, fechaPago: DateTime.now().subtract(const Duration(days: 1)), transaccionIdSimulada: 'txn_mock_fail_3'),
    ];
  }
}
