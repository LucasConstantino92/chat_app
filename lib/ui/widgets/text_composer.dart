import 'package:flutter/material.dart';

class TextComposer extends StatefulWidget {
  const TextComposer(this.sendMessage, {super.key});

  final Function(String) sendMessage;

  @override
  State<TextComposer> createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  bool _isComposing = false;
  final TextEditingController _controller = TextEditingController();

  void _handleSubmitted(String text) {
    widget.sendMessage(text);
    _controller.clear();
    setState(() {
      _isComposing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.photo_camera_outlined),
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration:
                  InputDecoration.collapsed(hintText: 'Enviar uma mensagem'),
              onChanged: (text) => setState(() {
                _isComposing = text.isNotEmpty;
              }),
              onSubmitted: _handleSubmitted,
            ),
          ),
          IconButton(
            onPressed:
                _isComposing ? () => _handleSubmitted(_controller.text) : null,
            icon: Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
