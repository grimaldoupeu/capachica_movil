import 'package:equatable/equatable.dart';

class Chat extends Equatable {
  final String id; // Unique ID for the conversation
  final List<String> participanteIds; // IDs of users in the chat (usually 2)
  final String? alojamientoId; // Optional: if chat is related to a specific Alojamiento
  final String? experienciaId; // Optional: if chat is related to a specific Experiencia
  final String ultimoMensaje; // Preview of the last message
  final DateTime timestampUltimoMensaje;
  final String nombreOtroParticipante; // Denormalized for display
  final String? avatarOtroParticipanteUrl; // Denormalized for display
  final int mensajesNoLeidosCount; // For the current user

  const Chat({
    required this.id,
    required this.participanteIds,
    this.alojamientoId,
    this.experienciaId,
    required this.ultimoMensaje,
    required this.timestampUltimoMensaje,
    required this.nombreOtroParticipante,
    this.avatarOtroParticipanteUrl,
    this.mensajesNoLeidosCount = 0,
  });

  @override
  List<Object?> get props => [
        id,
        participanteIds,
        alojamientoId,
        experienciaId,
        ultimoMensaje,
        timestampUltimoMensaje,
        nombreOtroParticipante,
        avatarOtroParticipanteUrl,
        mensajesNoLeidosCount,
      ];
}
