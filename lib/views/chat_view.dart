import 'dart:io';

import 'package:chat_app_2/services/auth_service.dart';
import 'package:chat_app_2/services/chat_service.dart';
import 'package:chat_app_2/services/socket_service.dart';
import 'package:chat_app_2/widgets/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> with TickerProviderStateMixin {
  final messageController = TextEditingController();
  final focusNode = FocusNode();
  bool isWriting = false;

  late ChatService chatService;
  late SocketService socketService;
  late AuthService authService;

  List<MessageWidget> messagesToDisplay = [];

  void _sendMessage() {
    final message = messageController.text;
    final newMessage = MessageWidget(
      message: message,
      uuid: authService.user.uid,
      animationController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 400),
      ),
    );
    messageController.clear();
    focusNode.requestFocus();
    newMessage.animationController.forward();
    setState(() {
      messagesToDisplay.insert(0, newMessage);
      isWriting = false;
    });

    socketService.socket.emit('private-message', {
      'from': authService.user.uid,
      'to': chatService.receipient.uid,
      'message': message,
    });
  }

  void _receiveMessage(dynamic payload) {
    final receivedMessage = MessageWidget(
      message: payload['message'],
      uuid: payload['from'],
      animationController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 400),
      ),
    );
    setState(() {
      messagesToDisplay.insert(0, receivedMessage);
    });
    receivedMessage.animationController.forward();
  }

  void _loadMessages(String userId) async {
    final messages = await chatService.getChat(userId);

    final chatMessages = messages.map(
      (m) => MessageWidget(
        message: m.message,
        uuid: m.from,
        animationController: AnimationController(
          vsync: this,
          duration: Duration(milliseconds: 0),
        )..forward(),
      ),
    );

    setState(() {
      messagesToDisplay.insertAll(0, chatMessages);
    });
  }

  @override
  void initState() {
    super.initState();
    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);

    socketService.socket.on('private-message', _receiveMessage);

    _loadMessages(chatService.receipient.uid);
  }

  @override
  void dispose() {
    socketService.socket.off('private-message');
    messageController.dispose();
    for (MessageWidget message in messagesToDisplay) {
      message.animationController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              child: Text(chatService.receipient.name.substring(0, 2)),
            ),
            SizedBox(width: 8),
            Text(
              chatService.receipient.name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        elevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messagesToDisplay.length,
              itemBuilder: (context, index) => messagesToDisplay[index],
              reverse: true,
            ),
          ),
          Divider(height: 1),
          _inputTextBox(),
        ],
      ),
    );
  }

  Widget _inputTextBox() {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 4, bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              minLines: 1,
              maxLines: 4,
              controller: messageController,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message...',
              ),
              onTapOutside: (PointerDownEvent event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              onChanged: (text) {
                setState(() {
                  text.trim().isEmpty ? isWriting = false : isWriting = true;
                });
              },
              focusNode: focusNode,
            ),
          ),

          if (Platform.isAndroid)
            IconButton(
              color: Theme.of(context).colorScheme.primary,
              onPressed: isWriting ? _sendMessage : null,
              icon: Icon(Icons.send),
            ),

          CupertinoButton(
            onPressed: isWriting ? _sendMessage : null,
            child: Text('Send'),
          ),
        ],
      ),
    );
  }
}
