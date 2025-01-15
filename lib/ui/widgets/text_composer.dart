import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TextComposer extends StatefulWidget {
  const TextComposer(this.sendMessage, {super.key});

  final Function({String text, File? imgFile}) sendMessage;

  @override
  State<TextComposer> createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  bool _isComposing = false;
  final TextEditingController _controller = TextEditingController();

  void _handleSubmitted(String text) {
    widget.sendMessage(text: text);
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
            onPressed: () async {
              final XFile? imgFile = await ImagePicker.platform
                  .getImageFromSource(source: ImageSource.camera);
              if (imgFile == null) return;
              final File file = File(imgFile.path);
              widget.sendMessage(imgFile: file);
            },
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
