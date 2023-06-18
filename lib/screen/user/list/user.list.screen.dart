import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:firebug/screen/chat/room/chat.room.screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});
  static const routeName = '/userList';

  @override
  Widget build(BuildContext context) {
    final usersQuery = FirebaseFirestore.instance.collection('users').orderBy('nickname');
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: FirestoreListView<Map<String, dynamic>>(
        query: usersQuery,
        itemBuilder: (context, snapshot) {
          Map<String, dynamic> user = snapshot.data();
          String uid = snapshot.id;

          return ListTile(
            title: Text('User name is ${user['nickname']}', style: Theme.of(context).textTheme.bodyLarge),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.pushNamed(
              ChatRoomScreen.routeName,
              queryParameters: {
                'uid': uid,
              },
            ),
          );
        },
      ),
    );
  }
}
