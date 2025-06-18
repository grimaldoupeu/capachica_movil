import 'package:equatable/equatable.dart';

class Mensaje extends Equatable {
  final String id;
  final String chatId; // ID of the Chat/Conversacion it belongs to
  final String emisorId; // Sender's User ID
  final String receptorId; // Receiver's User ID (denormalized for push notifications or specific queries)
  final String contenido;
  final DateTime timestamp;
  final bool leido; // By the receptor

  const Mensaje({
    required this.id,
    required this.chatId,
    required this.emisorId,
    required this.receptorId,
    required this.contenido,
    required this.timestamp,
    this.leido = false,
  });

  @override
  List<Object?> get props => [id, chatId, emisorId, receptorId, contenido, timestamp, leido];
}
