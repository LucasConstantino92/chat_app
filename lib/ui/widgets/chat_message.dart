import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key, required this.data, required this.mine});

  final Map<String, dynamic> data;
  final bool mine;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: mine
          ? const EdgeInsets.only(left: 100)
          : const EdgeInsets.only(right: 100),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: mine ? CupertinoColors.lightBackgroundGray : Colors.cyan,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            !mine
                ? Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(data['senderPhotoUrl']),
                    ),
                  )
                : Container(),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  data['imgUrl'] != null
                      ? Image.network(
                          data['imgUrl'],
                          width: 250,
                        )
                      : Text(
                          data['senderName'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  Text(
                    data['text'],
                    style: TextStyle(
                        fontSize: 20,
                        color: mine ? Colors.black : Colors.white),
                    textAlign: mine ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
            mine
                ? Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(data['senderPhotoUrl']),
                    ),
                  )
                : Container(),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
