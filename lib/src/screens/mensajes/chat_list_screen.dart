import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../blocs/mensaje_bloc/mensaje_bloc.dart';
// import '../../models/mensaje/chat_model.dart';
// import './chat_detail_screen.dart'; // For navigation
// import 'package:intl/intl.dart'; // For date formatting

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    super.initState();
    // final userId = context.read<AuthBloc>().state.user?.id; // Example
    // if (userId != null) {
    //   BlocProvider.of<MensajeBloc>(context).add(LoadChats(usuarioId: userId));
    // }
    print('ChatListScreen: InitState - Placeholder for loading user chats.');
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final dateOfTimestamp = DateTime(timestamp.year, timestamp.month, timestamp.day);

    if (dateOfTimestamp == today) {
      return TimeOfDay.fromDateTime(timestamp).format(context); // Using context for localization if available e.g. DateFormat.jm().format(timestamp)
    } else if (dateOfTimestamp == yesterday) {
      return 'Ayer';
    } else {
      // return DateFormat.yMd().format(timestamp); // Example using intl
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Mock data for user's chats
    final mockChats = [
      {'id': 'chat1', 'nombreOtroParticipante': 'Juan (Anfitrión Cabaña Sol)', 'avatarUrl': 'https://via.placeholder.com/50?text=JH', 'ultimoMensaje': 'Sí, justo esas fechas están libres.', 'timestamp': DateTime.now().subtract(const Duration(minutes: 2)), 'noLeidos': 1, 'alojamientoId': 'alo1'},
      {'id': 'chat2', 'nombreOtroParticipante': 'Ana (Turista Taller Textil)', 'avatarUrl': 'https://via.placeholder.com/50?text=AT', 'ultimoMensaje': '¡Genial! Nos vemos el sábado entonces.', 'timestamp': DateTime.now().subtract(const Duration(hours: 3)), 'noLeidos': 0, 'experienciaId': 'exp2'},
      {'id': 'chat3', 'nombreOtroParticipante': 'Pedro (Guía Tour Montaña)', 'avatarUrl': 'https://via.placeholder.com/50?text=PG', 'ultimoMensaje': 'Recuerda llevar agua y snacks.', 'timestamp': DateTime.now().subtract(const Duration(days: 1)), 'noLeidos': 0},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Mis Mensajes')),
      // body: BlocBuilder<MensajeBloc, MensajeState>(
      //   builder: (context, state) {
      //     if (state is MensajesLoading && state.message == 'Cargando chats...') { // Be more specific with loading states
      //       return const Center(child: CircularProgressIndicator());
      //     } else if (state is ChatsLoaded) {
      //       if (state.chats.isEmpty) {
      //         return const Center(child: Text('No tienes conversaciones activas.'));
      //       }
      //       return ListView.separated(
      //         itemCount: state.chats.length,
      //         separatorBuilder: (context, index) => const Divider(height: 0, indent: 70),
      //         itemBuilder: (context, index) {
      //           final chat = state.chats[index];
      //           return ListTile(
      //             leading: CircleAvatar(
      //               backgroundImage: chat.avatarOtroParticipanteUrl != null ? NetworkImage(chat.avatarOtroParticipanteUrl!) : null,
      //               child: chat.avatarOtroParticipanteUrl == null ? Text(chat.nombreOtroParticipante.substring(0,1).toUpperCase()) : null,
      //             ),
      //             title: Text(chat.nombreOtroParticipante, style: TextStyle(fontWeight: chat.mensajesNoLeidosCount > 0 ? FontWeight.bold : FontWeight.normal)),
      //             subtitle: Text(chat.ultimoMensaje, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: chat.mensajesNoLeidosCount > 0 ? FontWeight.bold : FontWeight.normal)),
      //             trailing: Column(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               crossAxisAlignment: CrossAxisAlignment.end,
      //               children: [
      //                 Text(_formatTimestamp(chat.timestampUltimoMensaje), style: Theme.of(context).textTheme.bodySmall),
      //                 if (chat.mensajesNoLeidosCount > 0) ...[
      //                   const SizedBox(height: 4),
      //                   CircleAvatar(radius: 10, backgroundColor: Theme.of(context).primaryColor, child: Text(chat.mensajesNoLeidosCount.toString(), style: const TextStyle(color: Colors.white, fontSize: 12))),
      //                 ]
      //               ],
      //             ),
      //             onTap: () {
      //               // Navigator.of(context).push(MaterialPageRoute(builder: (_) => ChatDetailScreen(chatId: chat.id, chatTitle: chat.nombreOtroParticipante)));
      //               print('Tapped on chat with ${chat.nombreOtroParticipante}');
      //             },
      //           );
      //         },
      //       );
      //     } else if (state is MensajesError) {
      //       return Center(child: Text('Error al cargar chats: ${state.message}'));
      //     }
      //     return const Center(child: Text('Cargando tus chats...'));
      //   },
      // ),
      body: mockChats.isEmpty
          ? const Center(child: Text('No tienes conversaciones activas.'))
          : ListView.separated(
              itemCount: mockChats.length,
              separatorBuilder: (context, index) => const Divider(height: 0, indent: 70),
              itemBuilder: (context, index) {
                final chat = mockChats[index];
                bool hasUnread = (chat['noLeidos'] as int? ?? 0) > 0;
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: (chat['avatarUrl'] as String?) != null ? NetworkImage(chat['avatarUrl'] as String) : null,
                    child: (chat['avatarUrl'] as String?) == null ? Text((chat['nombreOtroParticipante'] as String).substring(0,1).toUpperCase()) : null,
                  ),
                  title: Text(chat['nombreOtroParticipante'] as String, style: TextStyle(fontWeight: hasUnread ? FontWeight.bold : FontWeight.normal)),
                  subtitle: Text(chat['ultimoMensaje'] as String, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: hasUnread ? FontWeight.bold : FontWeight.normal, color: hasUnread ? Theme.of(context).colorScheme.primary : null)),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(_formatTimestamp(chat['timestamp'] as DateTime), style: Theme.of(context).textTheme.bodySmall),
                      if (hasUnread) ...[
                        const SizedBox(height: 4),
                        CircleAvatar(radius: 10, backgroundColor: Theme.of(context).primaryColor, child: Text((chat['noLeidos'] as int).toString(), style: const TextStyle(color: Colors.white, fontSize: 12))),
                      ]
                    ],
                  ),
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(builder: (_) => ChatDetailScreen(chatId: chat['id']! as String, chatTitle: chat['nombreOtroParticipante']! as String)));
                    print('Tapped on chat with ${chat['nombreOtroParticipante']} (ID: ${chat['id']})');
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Navigate to chat: ${chat['nombreOtroParticipante']}')));
                  },
                );
              },
            ),
    );
  }
}
