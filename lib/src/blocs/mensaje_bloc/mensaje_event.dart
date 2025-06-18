part of 'mensaje_bloc.dart';

abstract class MensajeEvent extends Equatable {
  const MensajeEvent();
  @override
  List<Object?> get props => [];
}

class LoadChats extends MensajeEvent {
  final String usuarioId; // Current user ID
  const LoadChats({required this.usuarioId});
  @override
  List<Object> get props => [usuarioId];
}

class LoadMensajes extends MensajeEvent {
  final String chatId;
  final String currentUserId; // To determine which messages are outgoing
  const LoadMensajes({required this.chatId, required this.currentUserId});
  @override
  List<Object> get props => [chatId, currentUserId];
}

class SendMensaje extends MensajeEvent {
  final String chatId; // Can be null if starting a new chat
  final String emisorId;
  final String receptorId; // ID of the other participant
  final String contenido;
  final String? alojamientoId; // Optional context: if starting chat from an alojamiento
  final String? experienciaId; // Optional context

  const SendMensaje({
    required this.chatId,
    required this.emisorId,
    required this.receptorId,
    required this.contenido,
    this.alojamientoId,
    this.experienciaId,
  });
  @override
  List<Object?> get props => [chatId, emisorId, receptorId, contenido, alojamientoId, experienciaId];
}

class MarkMensajesAsLeido extends MensajeEvent {
  final String chatId;
  final String currentUserId; // User who has read the messages
  const MarkMensajesAsLeido({required this.chatId, required this.currentUserId});
   @override
  List<Object> get props => [chatId, currentUserId];
}

// May not be needed if SendMensaje handles new chat creation via service
// class CreateChat extends MensajeEvent {
//   final String usuarioId1;
//   final String usuarioId2;
//   final String? alojamientoId;
//   const CreateChat({required this.usuarioId1, required this.usuarioId2, this.alojamientoId});
// }
