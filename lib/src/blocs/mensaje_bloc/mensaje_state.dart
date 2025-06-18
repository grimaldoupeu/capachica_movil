part of 'mensaje_bloc.dart';

abstract class MensajeState extends Equatable {
  const MensajeState();
  @override
  List<Object?> get props => [];
}

class MensajesInitial extends MensajeState {}

class MensajesLoading extends MensajeState { // General loading
  final String? message;
  const MensajesLoading({this.message});
  @override
  List<Object?> get props => [message];
}

class ChatsLoaded extends MensajeState {
  final List<Chat> chats;
  const ChatsLoaded({required this.chats});
  @override
  List<Object> get props => [chats];
}

class MensajesLoaded extends MensajeState {
  final String chatId;
  final List<Mensaje> mensajes;
  const MensajesLoaded({required this.chatId, required this.mensajes});
  @override
  List<Object> get props => [chatId, mensajes];
}

class MensajeSending extends MensajeState {}

class MensajeSentSuccess extends MensajeState {
  final Mensaje mensaje; // The sent message
  const MensajeSentSuccess({required this.mensaje});
   @override
  List<Object> get props => [mensaje];
}

class MensajeSentFailure extends MensajeState {
  final String message;
  final String? tempMessageId; // If you want to mark a specific optimistic message as failed
  const MensajeSentFailure({required this.message, this.tempMessageId});
   @override
  List<Object?> get props => [message, tempMessageId];
}


class MensajesError extends MensajeState { // General error for loading etc.
  final String message;
  const MensajesError({required this.message});
  @override
  List<Object> get props => [message];
}
