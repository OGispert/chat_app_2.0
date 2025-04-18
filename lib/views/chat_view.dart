import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key, required this.userName});

  final String userName;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final messageController = TextEditingController();
  final focusNode = FocusNode();
  bool isWriting = false;

  void _sendMessage() {
    messageController.clear();
    focusNode.requestFocus();
    setState(() {
      isWriting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(child: Text(widget.userName.substring(0, 2))),
            SizedBox(width: 8),
            Text(
              widget.userName,
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
              itemBuilder: (context, index) => Text('message'),
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
      padding: EdgeInsets.only(left: 16, right: 4, bottom: 32),
      child: Row(
        children: [
          Expanded(
            child: TextField(
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
