import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../models/mensaje/chat_model.dart';
import '../../../models/mensaje/mensaje_model.dart';
import '../../../services/mensaje_service/mensaje_service.dart'; // Placeholder

part 'mensaje_event.dart';
part 'mensaje_state.dart';

class MensajeBloc extends Bloc<MensajeEvent, MensajeState> {
  final MensajeService _mensajeService;
  // StreamSubscription? _mensajesSubscription; // For real-time updates

  MensajeBloc(this._mensajeService) : super(MensajesInitial()) {
    on<LoadChats>(_onLoadChats);
    on<LoadMensajes>(_onLoadMensajes);
    on<SendMensaje>(_onSendMensaje);
    on<MarkMensajesAsLeido>(_onMarkMensajesAsLeido);
  }

  Future<void> _onLoadChats(LoadChats event, Emitter<MensajeState> emit) async {
    emit(const MensajesLoading(message: 'Cargando chats...'));
    try {
      // final chats = await _mensajeService.getChatsForUser(event.usuarioId);
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate
      final mockChats = _getMockChats(event.usuarioId);
      emit(ChatsLoaded(chats: mockChats));
    } catch (e) {
      emit(MensajesError(message: 'Error al cargar chats: ${e.toString()}'));
    }
  }

  Future<void> _onLoadMensajes(LoadMensajes event, Emitter<MensajeState> emit) async {
    emit(const MensajesLoading(message: 'Cargando mensajes...'));
    // _mensajesSubscription?.cancel(); // Cancel previous subscription if any
    try {
      // For real-time, you'd subscribe to a stream from the service:
      // _mensajesSubscription = _mensajeService.getMensajesStream(event.chatId).listen((mensajes) {
      //   add(_MensajesUpdated(chatId: event.chatId, mensajes: mensajes)); // Internal event
      // });
      // For placeholder, just load once:
      // final mensajes = await _mensajeService.getMensajesForChat(event.chatId);
      await Future.delayed(const Duration(milliseconds: 300)); // Simulate
      final mockMensajes = _getMockMensajes(event.chatId, event.currentUserId);
      emit(MensajesLoaded(chatId: event.chatId, mensajes: mockMensajes));
      // Mark messages as read after loading them
      add(MarkMensajesAsLeido(chatId: event.chatId, currentUserId: event.currentUserId));
    } catch (e) {
      emit(MensajesError(message: 'Error al cargar mensajes: ${e.toString()}'));
    }
  }

  // Internal event for real-time updates if used
  // void _onMensajesUpdated(_MensajesUpdated event, Emitter<MensajeState> emit) {
  //   emit(MensajesLoaded(chatId: event.chatId, mensajes: event.mensajes));
  // }

  Future<void> _onSendMensaje(SendMensaje event, Emitter<MensajeState> emit) async {
    emit(MensajeSending()); // Could also pass the optimistic message
    try {
      // final nuevoMensaje = await _mensajeService.sendMensaje(
      //   chatId: event.chatId, // Service might create chat if ID is null
      //   emisorId: event.emisorId,
      //   receptorId: event.receptorId,
      //   contenido: event.contenido,
      //   alojamientoId: event.alojamientoId,
      // );
      await Future.delayed(const Duration(milliseconds: 300)); // Simulate
      final nuevoMensaje = Mensaje(
        id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
        chatId: event.chatId.isNotEmpty ? event.chatId : 'new_chat_id_${event.receptorId}', // Simulate new chat ID
        emisorId: event.emisorId,
        receptorId: event.receptorId,
        contenido: event.contenido,
        timestamp: DateTime.now(),
      );
      emit(MensajeSentSuccess(mensaje: nuevoMensaje));
      // If using non-realtime, you might need to reload messages for the chat:
      // add(LoadMensajes(chatId: nuevoMensaje.chatId, currentUserId: event.emisorId));
    } catch (e) {
      emit(MensajeSentFailure(message: 'Error al enviar mensaje: ${e.toString()}'));
    }
  }

  Future<void> _onMarkMensajesAsLeido(MarkMensajesAsLeido event, Emitter<MensajeState> emit) async {
    try {
      // await _mensajeService.markMessagesAsRead(event.chatId, event.currentUserId);
      await Future.delayed(const Duration(milliseconds:100)); // Simulate
      print('Mensajes marcados como leídos para chat ${event.chatId} por usuario ${event.currentUserId}');
      // No specific state change needed unless you want to confirm,
      // or if unread counts on Chat objects need to be updated and re-emitted.
      // If Chat objects are part of a state, you might need to update that state.
    } catch (e) {
       print('Error al marcar mensajes como leídos: ${e.toString()}');
      // Optionally emit an error state if this is critical feedback
    }
  }

  // @override
  // Future<void> close() {
  //   _mensajesSubscription?.cancel();
  //   return super.close();
  // }

  // Mock data helpers
  List<Chat> _getMockChats(String usuarioId) {
    return [
      Chat(id: 'chat1_con_host123', participanteIds: [usuarioId, 'host123'], alojamientoId: 'alo1', ultimoMensaje: '¡Hola! ¿Está disponible para esas fechas?', timestampUltimoMensaje: DateTime.now().subtract(const Duration(minutes: 5)), nombreOtroParticipante: 'Juan (Anfitrión Cabaña Sol)', avatarOtroParticipanteUrl: 'https://via.placeholder.com/50?text=JH', mensajesNoLeidosCount: 1),
      Chat(id: 'chat2_con_turista456', participanteIds: [usuarioId, 'turista456'], experienciaId: 'exp2', ultimoMensaje: 'Perfecto, nos vemos en el taller.', timestampUltimoMensaje: DateTime.now().subtract(const Duration(hours: 1)), nombreOtroParticipante: 'Ana (Turista Taller)', avatarOtroParticipanteUrl: 'https://via.placeholder.com/50?text=AT'),
      Chat(id: 'chat3_con_host789', participanteIds: [usuarioId, 'host789'], ultimoMensaje: 'Gracias por tu hospitalidad.', timestampUltimoMensaje: DateTime.now().subtract(const Duration(days: 1)), nombreOtroParticipante: 'Pedro (Anfitrión Casa Lago)', avatarOtroParticipanteUrl: 'https://via.placeholder.com/50?text=PH'),
    ];
  }

  List<Mensaje> _getMockMensajes(String chatId, String currentUserId) {
    // Determine other participant for mock messages
    String otherParticipantId = 'otherUser';
    if (chatId == 'chat1_con_host123') otherParticipantId = 'host123';
    if (chatId == 'chat2_con_turista456') otherParticipantId = 'turista456';

    return [
      Mensaje(id: 'm1', chatId: chatId, emisorId: otherParticipantId, receptorId: currentUserId, contenido: 'Hola, ¿cómo estás?', timestamp: DateTime.now().subtract(const Duration(minutes: 10))),
      Mensaje(id: 'm2', chatId: chatId, emisorId: currentUserId, receptorId: otherParticipantId, contenido: '¡Hola! Todo bien por aquí. Quería consultarte sobre la cabaña...', timestamp: DateTime.now().subtract(const Duration(minutes: 8))),
      Mensaje(id: 'm3', chatId: chatId, emisorId: otherParticipantId, receptorId: currentUserId, contenido: 'Claro, dime.', timestamp: DateTime.now().subtract(const Duration(minutes: 6)), leido: true),
      Mensaje(id: 'm4', chatId: chatId, emisorId: currentUserId, receptorId: otherParticipantId, contenido: '¿Está disponible del 15 al 20 del próximo mes?', timestamp: DateTime.now().subtract(const Duration(minutes: 5))),
      Mensaje(id: 'm5', chatId: chatId, emisorId: otherParticipantId, receptorId: currentUserId, contenido: 'Sí, justo esas fechas están libres. ¿Para cuántas personas sería?', timestamp: DateTime.now().subtract(const Duration(minutes: 2))),
    ];
  }
}

// Internal event for real-time updates, if implemented
// class _MensajesUpdated extends MensajeEvent {
//   final String chatId;
//   final List<Mensaje> mensajes;
//   const _MensajesUpdated({required this.chatId, required this.mensajes});
//   @override
//   List<Object> get props => [chatId, mensajes];
// }
