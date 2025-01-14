import 'package:chat_app/ui/widgets/text_composer.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Chat',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      body: TextComposer(),
    );
  }
}
