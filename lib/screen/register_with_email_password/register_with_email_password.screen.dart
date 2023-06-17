import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class RegisterWithEmailPasswordScreen extends StatefulWidget {
  const RegisterWithEmailPasswordScreen({super.key});

  @override
  State<RegisterWithEmailPasswordScreen> createState() =>
      _RegisterWithEmailPasswordScreenState();
}

class _RegisterWithEmailPasswordScreenState
    extends State<RegisterWithEmailPasswordScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  @override
  build(context) => Scaffold(
      appBar: AppBar(
        title: const Text('Password Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: email,
              decoration: const InputDecoration(
                label: Text('Email'),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
                controller: password,
                decoration: const InputDecoration(label: Text('Password'))),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () async {
                  try {
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email.text,
                      password: password.text,
                    );
                    print(credential.user);
                    context.pop();
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                    } else {
                      print(e);
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: const Text('Register')),
          ],
        ),
      ));
}
