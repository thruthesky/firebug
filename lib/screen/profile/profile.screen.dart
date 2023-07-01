import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final displayName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Loading...');
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              final DocumentSnapshot? documentSnapshot = snapshot.data;
              if (!documentSnapshot!.exists) {
              } else {
                final data = Map<String, dynamic>.from((snapshot.data!.data() ?? {}) as Map<String, dynamic>);
                displayName.text = data['displayName'] ?? '';
              }

              return Column(
                children: [
                  const Text('Profile update'),
                  const SizedBox(height: 24),
                  TextField(
                    controller: displayName,
                    decoration: const InputDecoration(border: OutlineInputBorder(), label: Text('Display name')),
                  ),
                  const SizedBox(height: 24),
                  const SizedBox(height: 24),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: const Text('Back'),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () async {
                          final db = FirebaseFirestore.instance;
                          final user = FirebaseAuth.instance.currentUser;
                          await db
                              .collection('users')
                              .doc(user!.uid)
                              .set({'displayName': displayName.text}, SetOptions(merge: true));

                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Profile updated'),
                              ),
                            );
                          }
                        },
                        child: const Text('Update'),
                      ),
                    ],
                  ),
                ],
              );
            }),
      ),
    );
  }
}
