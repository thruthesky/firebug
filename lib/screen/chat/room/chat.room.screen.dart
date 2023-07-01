import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key, required this.uid});
  static const routeName = '/chat-room';

  final String uid;

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final message = TextEditingController();

  String get chatRoomId {
    List<String> arr = [widget.uid, FirebaseAuth.instance.currentUser!.uid];
    arr.sort();
    return arr.join('-');
  }

  DocumentReference get roomDoc {
    return FirebaseFirestore.instance.collection('chat').doc(chatRoomId);
  }

  CollectionReference get messageCol => roomDoc.collection('messages');

  get messageQuery => messageCol.orderBy('createdAt', descending: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.uid),
      ),
      body: Column(
        children: [
          Expanded(
            child: FirestoreListView<Map<String, dynamic>>(
              reverse: true,
              query: messageQuery,
              itemBuilder: (context, snapshot) {
                Map<String, dynamic> messageDocData = snapshot.data();

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${messageDocData['message']}'),
                );
              },
            ),
          ),
          SafeArea(
            child: Row(
              children: [
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    autofocus: true,
                    controller: message,
                    decoration: const InputDecoration(
                      label: Text('Message'),
                    ),
                    onSubmitted: (value) => sendMessage(),
                  ),
                ),
                IconButton(
                  onPressed: sendMessage,
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  sendMessage() {
    roomDoc.set({
      'seenBy': [FirebaseAuth.instance.currentUser!.uid],
    }, SetOptions(merge: true));
    messageCol.add({
      'message': message.text,
      'sender': FirebaseAuth.instance.currentUser!.uid,
      'createdAt': FieldValue.serverTimestamp(),
    });
    message.clear();
  }
}
