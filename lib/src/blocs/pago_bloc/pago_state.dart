part of 'pago_bloc.dart';

abstract class PagoState extends Equatable {
  const PagoState();
  @override
  List<Object?> get props => [];
}

class PagoInitial extends PagoState {}

class PagoLoading extends PagoState { // For loading list
    final String? message;
    const PagoLoading({this.message});
    @override
    List<Object?> get props => [message];
}

class PagoProcessing extends PagoState { // For processing a payment
    final String? message;
    const PagoProcessing({this.message});
    @override
    List<Object?> get props => [message];
}


class PagoSuccess extends PagoState { // Generic success for operations like recording
  final Pago pago; // Return the recorded Pago object
  const PagoSuccess({required this.pago});
  @override
  List<Object> get props => [pago];
}

class PagoFailure extends PagoState { // Generic failure for operations
  final String message;
  const PagoFailure({required this.message});
  @override
  List<Object> get props => [message];
}

class UserPagosLoaded extends PagoState {
  final List<Pago> pagos;
  const UserPagosLoaded({required this.pagos});
  @override
  List<Object> get props => [pagos];
}

class PagosError extends PagoState { // For errors during loading lists
  final String message;
  const PagosError({required this.message});
  @override
  List<Object> get props => [message];
}
