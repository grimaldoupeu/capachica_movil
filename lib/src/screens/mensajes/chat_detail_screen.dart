import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../blocs/mensaje_bloc/mensaje_bloc.dart';
// import '../../models/mensaje/mensaje_model.dart';
// import 'package:intl/intl.dart'; // For date formatting

class ChatDetailScreen extends StatefulWidget {
  final String chatId;
  final String chatTitle; // Name of the other participant or group name
  // final String currentUserId; // Passed in or from AuthBloc

  const ChatDetailScreen({
    super.key,
    required this.chatId,
    required this.chatTitle,
    // required this.currentUserId,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  final String _currentUserId = 'currentUser_mock_id'; // Placeholder

  @override
  void initState() {
    super.initState();
    // BlocProvider.of<MensajeBloc>(context).add(LoadMensajes(chatId: widget.chatId, currentUserId: _currentUserId));
    print('ChatDetailScreen: InitState - Loading messages for chat ID ${widget.chatId}');
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    // final mensajeBloc = BlocProvider.of<MensajeBloc>(context);
    // Need receptorId. This might be part of the ChatModel or derived.
    // For this placeholder, assume we know the other participant's ID.
    String receptorId = 'other_participant_mock_id';
    if (widget.chatId == 'chat1_con_host123') receptorId = 'host123';


    // mensajeBloc.add(SendMensaje(
    //   chatId: widget.chatId,
    //   emisorId: _currentUserId,
    //   receptorId: receptorId, // This needs to be determined based on the chat
    //   contenido: _messageController.text.trim(),
    // ));
    print('Send Mensaje: ChatID: ${widget.chatId}, Emisor: $_currentUserId, Receptor: $receptorId, Contenido: ${_messageController.text.trim()}');
    _messageController.clear();
    _scrollToBottom();

    // Placeholder for optimistic update or waiting for MensajeSentSuccess
    // For now, just clear and maybe show a temp message
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Mensaje enviado (placeholder)')));

  }

  void _scrollToBottom() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (_scrollController.hasClients) {
    //     _scrollController.animateTo(
    //       _scrollController.position.maxScrollExtent,
    //       duration: const Duration(milliseconds: 300),
    //       curve: Curves.easeOut,
    //     );
    //   }
    // });
    print('Scroll to bottom requested.');
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Mock data for messages in a chat
    final mockMensajes = [
      {'id': 'm1', 'emisorId': 'other_participant_mock_id', 'contenido': 'Hola, ¿cómo estás?', 'timestamp': DateTime.now().subtract(const Duration(minutes: 10))},
      {'id': 'm2', 'emisorId': _currentUserId, 'contenido': '¡Hola! Todo bien por aquí. Quería consultarte sobre la cabaña...', 'timestamp': DateTime.now().subtract(const Duration(minutes: 8))},
      {'id': 'm3', 'emisorId': 'other_participant_mock_id', 'contenido': 'Claro, dime.', 'timestamp': DateTime.now().subtract(const Duration(minutes: 6))},
      {'id': 'm4', 'emisorId': _currentUserId, 'contenido': '¿Está disponible del 15 al 20 del próximo mes?', 'timestamp': DateTime.now().subtract(const Duration(minutes: 5))},
      {'id': 'm5', 'emisorId': 'other_participant_mock_id', 'contenido': 'Sí, justo esas fechas están libres. ¿Para cuántas personas sería?', 'timestamp': DateTime.now().subtract(const Duration(minutes: 2))},
    ];

    return Scaffold(
      appBar: AppBar(title: Text(widget.chatTitle)),
      body: Column(
        children: [
          Expanded(
            // child: BlocConsumer<MensajeBloc, MensajeState>(
            //   listener: (context, state) {
            //     if (state is MensajeSentSuccess && state.mensaje.chatId == widget.chatId) {
            //        _scrollToBottom(); // Scroll when new message is confirmed
            //     } else if (state is MensajesLoaded && state.chatId == widget.chatId) {
            //        _scrollToBottom(); // Scroll when messages are loaded
            //     }
            //   },
            //   builder: (context, state) {
            //     if (state is MensajesLoading && state.message == 'Cargando mensajes...') {
            //       return const Center(child: CircularProgressIndicator());
            //     } else if (state is MensajesLoaded && state.chatId == widget.chatId) {
            //       if (state.mensajes.isEmpty) {
            //         return const Center(child: Text('No hay mensajes en este chat. Envía el primero!'));
            //       }
            //       return ListView.builder(
            //         controller: _scrollController,
            //         padding: const EdgeInsets.all(8.0),
            //         itemCount: state.mensajes.length,
            //         itemBuilder: (context, index) {
            //           final mensaje = state.mensajes[index];
            //           final esEmisor = mensaje.emisorId == _currentUserId;
            //           return _buildMessageBubble(mensaje, esEmisor, context);
            //         },
            //       );
            //     } else if (state is MensajesError) {
            //       return Center(child: Text('Error: ${state.message}'));
            //     }
            //     // Could be MensajesInitial or loading chats for another screen
            //     return const Center(child: Text('Cargando mensajes...'));
            //   },
            // ),
            // Placeholder ListView:
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(10.0),
              itemCount: mockMensajes.length,
              itemBuilder: (context, index) {
                final mensaje = mockMensajes[index];
                final esEmisor = mensaje['emisorId'] == _currentUserId;
                // return _buildMessageBubble(mensaje as Mensaje, esEmisor, context); // If using Mensaje model directly
                return _buildMessageBubbleFromMap(mensaje, esEmisor, context);
              },
            ),
          ),
          _buildMessageInputField(),
        ],
      ),
    );
  }

  Widget _buildMessageBubbleFromMap(Map<String, dynamic> mensaje, bool esEmisor, BuildContext context) {
    final timestamp = mensaje['timestamp'] as DateTime;
    // final formattedTime = DateFormat.Hm().format(timestamp); // Using intl
    final formattedTime = '${timestamp.hour.toString().padLeft(2,'0')}:${timestamp.minute.toString().padLeft(2,'0')}';


    return Align(
      alignment: esEmisor ? Alignment.centerRight : Alignment.centerLeft,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: esEmisor ? const Radius.circular(12) : const Radius.circular(0),
            bottomRight: esEmisor ? const Radius.circular(0) : const Radius.circular(12),
          ),
        ),
        color: esEmisor ? Theme.of(context).primaryColor.withAlpha(200) : Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: esEmisor ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                mensaje['contenido'] as String,
                style: TextStyle(color: esEmisor ? Colors.white : Colors.black87),
              ),
              const SizedBox(height: 4),
              Text(
                formattedTime,
                style: TextStyle(
                  color: esEmisor ? Colors.white70 : Colors.black54,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildMessageBubble(Mensaje mensaje, bool esEmisor, BuildContext context) { /* ... similar to above ... */ }


  Widget _buildMessageInputField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -1),
            blurRadius: 1,
            color: Colors.grey.withOpacity(0.1),
          ),
        ],
      ),
      child: Row(
        children: [
          // IconButton(icon: Icon(Icons.add_photo_alternate_outlined), onPressed: () { /* TODO: Attach image */ }),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: 'Escribe un mensaje...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10)
              ),
              textCapitalization: TextCapitalization.sentences,
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Theme.of(context).primaryColor),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
