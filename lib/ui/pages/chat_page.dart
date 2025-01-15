import 'dart:io';

import 'package:chat_app/ui/widgets/text_composer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('messages')
                    .snapshots(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(
                        child: const CircularProgressIndicator(),
                      );
                    default:
                      List<DocumentSnapshot> documents =
                          snapshot.data!.docs.reversed.toList();

                      return ListView.builder(
                          itemCount: documents.length,
                          reverse: false,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(documents[index]['text']),
                            );
                          });
                  }
                }),
          ),
          TextComposer(_sendMessage),
        ],
      ),
    );
  }

  void _sendMessage({String? text, File? imgFile}) async {
    Map<String, dynamic> data = {};

    if (imgFile != null) {
      UploadTask task = FirebaseStorage.instance
          .ref()
          .child('files')
          .child(DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(
            File(imgFile.path),
          );

      TaskSnapshot taskSnapshot =
          await task.whenComplete(() => task.snapshot.ref.getDownloadURL());
      data['imgUrl'] = await taskSnapshot.ref.getDownloadURL();
    }

    if (text != null) data['text'] = text;

    FirebaseFirestore.instance.collection('messages').add({
      'text': text,
    });
  }
}
