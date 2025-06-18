// Placeholder for MensajeService
import '../../models/mensaje/chat_model.dart';
import '../../models/mensaje/mensaje_model.dart';

class MensajeService {
  // Mock in-memory store
  final List<Chat> _mockChatsDb = [
    Chat(id: 'chat1_con_host123', participanteIds: ['currentUser_mock_id', 'host123'], alojamientoId: 'alo1', ultimoMensaje: '¡Hola! ¿Está disponible para esas fechas?', timestampUltimoMensaje: DateTime.now().subtract(const Duration(minutes: 5)), nombreOtroParticipante: 'Juan (Anfitrión Cabaña Sol)', avatarOtroParticipanteUrl: 'https://via.placeholder.com/50?text=JH', mensajesNoLeidosCount: 1),
    Chat(id: 'chat2_con_turista456', participanteIds: ['currentUser_mock_id', 'turista456'], experienciaId: 'exp2', ultimoMensaje: 'Perfecto, nos vemos en el taller.', timestampUltimoMensaje: DateTime.now().subtract(const Duration(hours: 1)), nombreOtroParticipante: 'Ana (Turista Taller)', avatarOtroParticipanteUrl: 'https://via.placeholder.com/50?text=AT'),
  ];
  final Map<String, List<Mensaje>> _mockMensajesDb = {
    'chat1_con_host123': [
      Mensaje(id: 'm1', chatId: 'chat1_con_host123', emisorId: 'host123', receptorId: 'currentUser_mock_id', contenido: 'Hola, ¿cómo estás?', timestamp: DateTime.now().subtract(const Duration(minutes: 10))),
      Mensaje(id: 'm2', chatId: 'chat1_con_host123', emisorId: 'currentUser_mock_id', receptorId: 'host123', contenido: '¡Hola! Todo bien por aquí.', timestamp: DateTime.now().subtract(const Duration(minutes: 8))),
    ],
    'chat2_con_turista456': [
       Mensaje(id: 'm_exp1', chatId: 'chat2_con_turista456', emisorId: 'turista456', receptorId: 'currentUser_mock_id', contenido: '¿Confirmamos el taller para el sábado?', timestamp: DateTime.now().subtract(const Duration(hours:2))),
    ],
  };

  Future<List<Chat>> getChatsForUser(String usuarioId) async {
    print('MensajeService (Placeholder): Fetching chats for user $usuarioId');
    await Future.delayed(const Duration(milliseconds: 200));
    // In real app, filter by participanteIds containing usuarioId
    return _mockChatsDb.where((chat) => chat.participanteIds.contains(usuarioId) || chat.participanteIds.contains('currentUser_mock_id')).toList();
  }

  Future<List<Mensaje>> getMensajesForChat(String chatId) async {
    print('MensajeService (Placeholder): Fetching mensajes for chat $chatId');
    await Future.delayed(const Duration(milliseconds: 100));
    return _mockMensajesDb[chatId] ?? [];
  }

  // Stream<List<Mensaje>> getMensajesStream(String chatId) {
  //   // Placeholder for real-time stream (e.g., from Firebase Firestore)
  //   return Stream.periodic(const Duration(seconds: 5), (count) {
  //     print('MensajeService (Stream): Emitting mock mensajes for chat $chatId');
  //     final currentMessages = _mockMensajesDb[chatId] ?? [];
  //     // Add a new mock message periodically for testing
  //     final newMessage = Mensaje(
  //         id: 'stream_msg_$count',
  //         chatId: chatId,
  //         emisorId: 'otherUser_stream',
  //         receptorId: 'currentUser_mock_id',
  //         contenido: 'Mensaje de stream #$count - ${DateTime.now()}',
  //         timestamp: DateTime.now());
  //     _mockMensajesDb.putIfAbsent(chatId, () => []).add(newMessage);
  //     return List.from(_mockMensajesDb[chatId]!); // Return a copy
  //   }).asBroadcastStream(); // Use asBroadcastStream if multiple listeners
  // }


  Future<Mensaje> sendMensaje({
    required String chatId, // If empty, service should create a new chat
    required String emisorId,
    required String receptorId,
    required String contenido,
    String? alojamientoId,
    String? experienciaId,
  }) async {
    print('MensajeService (Placeholder): Sending mensaje...');
    await Future.delayed(const Duration(milliseconds: 150));

    String currentChatId = chatId;
    if (currentChatId.isEmpty) {
      // Create a new chat if chatId is empty
      currentChatId = 'chat_${DateTime.now().millisecondsSinceEpoch}_${receptorId}';
      final newChat = Chat(
        id: currentChatId,
        participanteIds: [emisorId, receptorId],
        alojamientoId: alojamientoId,
        experienciaId: experienciaId,
        ultimoMensaje: contenido,
        timestampUltimoMensaje: DateTime.now(),
        nombreOtroParticipante: 'Usuario $receptorId', // Needs real name
        avatarOtroParticipanteUrl: 'https://via.placeholder.com/50?text=${receptorId.substring(0,1).toUpperCase()}',
        mensajesNoLeidosCount: 0, // For the creator initially
      );
      _mockChatsDb.add(newChat);
      _mockMensajesDb[currentChatId] = []; // Initialize message list for new chat
      print('MensajeService (Placeholder): Created new chat ID $currentChatId');
    }

    final nuevoMensaje = Mensaje(
      id: 'msg_srv_${DateTime.now().millisecondsSinceEpoch}',
      chatId: currentChatId,
      emisorId: emisorId,
      receptorId: receptorId,
      contenido: contenido,
      timestamp: DateTime.now(),
    );
    _mockMensajesDb.putIfAbsent(currentChatId, () => []).add(nuevoMensaje);

    // Update last message in Chat object
    final chatIndex = _mockChatsDb.indexWhere((c) => c.id == currentChatId);
    if (chatIndex != -1) {
        _mockChatsDb[chatIndex] = _mockChatsDb[chatIndex].copyWith(
            ultimoMensaje: contenido,
            timestampUltimoMensaje: nuevoMensaje.timestamp
        );
    }

    return nuevoMensaje;
  }

  Future<void> markMessagesAsRead(String chatId, String userId) async {
    print('MensajeService (Placeholder): Marking messages in chat $chatId as read by user $userId');
    await Future.delayed(const Duration(milliseconds:50));
    final messagesInChat = _mockMensajesDb[chatId];
    if (messagesInChat != null) {
      for (int i = 0; i < messagesInChat.length; i++) {
        if (messagesInChat[i].receptorId == userId && !messagesInChat[i].leido) {
          // In a real DB, you'd update the 'leido' field.
          // For mock, we might replace the object, but it's tricky without proper IDs.
          // For simplicity, just print. A real implementation needs care.
           _mockMensajesDb[chatId]![i] = messagesInChat[i].copyWith(leido: true);
        }
      }
    }
     // Update unread count on chat object
    final chatIndex = _mockChatsDb.indexWhere((c) => c.id == chatId);
    if (chatIndex != -1) {
        // Only update if the 'userId' is one of the participants and is NOT the one who sent the last message (simplification)
        if (_mockChatsDb[chatIndex].participanteIds.contains(userId) && _mockChatsDb[chatIndex].ultimoMensaje.isNotEmpty /* and last message not by userId */) {
             _mockChatsDb[chatIndex] = _mockChatsDb[chatIndex].copyWith(mensajesNoLeidosCount: 0);
        }
    }
  }
}

// Helper extension for Chat model
extension ChatCopyWith on Chat {
  Chat copyWith({
    String? id,
    List<String>? participanteIds,
    String? alojamientoId,
    String? experienciaId,
    String? ultimoMensaje,
    DateTime? timestampUltimoMensaje,
    String? nombreOtroParticipante,
    String? avatarOtroParticipanteUrl,
    int? mensajesNoLeidosCount,
  }) {
    return Chat(
      id: id ?? this.id,
      participanteIds: participanteIds ?? this.participanteIds,
      alojamientoId: alojamientoId ?? this.alojamientoId,
      experienciaId: experienciaId ?? this.experienciaId,
      ultimoMensaje: ultimoMensaje ?? this.ultimoMensaje,
      timestampUltimoMensaje: timestampUltimoMensaje ?? this.timestampUltimoMensaje,
      nombreOtroParticipante: nombreOtroParticipante ?? this.nombreOtroParticipante,
      avatarOtroParticipanteUrl: avatarOtroParticipanteUrl ?? this.avatarOtroParticipanteUrl,
      mensajesNoLeidosCount: mensajesNoLeidosCount ?? this.mensajesNoLeidosCount,
    );
  }
}

// Helper extension for Mensaje model
extension MensajeCopyWith on Mensaje {
  Mensaje copyWith({
    String? id,
    String? chatId,
    String? emisorId,
    String? receptorId,
    String? contenido,
    DateTime? timestamp,
    bool? leido,
  }) {
    return Mensaje(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      emisorId: emisorId ?? this.emisorId,
      receptorId: receptorId ?? this.receptorId,
      contenido: contenido ?? this.contenido,
      timestamp: timestamp ?? this.timestamp,
      leido: leido ?? this.leido,
    );
  }
}
