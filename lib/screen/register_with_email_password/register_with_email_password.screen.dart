import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class RegisterWithEmailPasswordScreen extends StatefulWidget {
  const RegisterWithEmailPasswordScreen({super.key});
  static const routeName = '/register-with-email-password';

  @override
  State<RegisterWithEmailPasswordScreen> createState() => _RegisterWithEmailPasswordScreenState();
}

class _RegisterWithEmailPasswordScreenState extends State<RegisterWithEmailPasswordScreen> {
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
            TextField(controller: password, decoration: const InputDecoration(label: Text('Password'))),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () async {
                  try {
                    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: email.text,
                      password: password.text,
                    );
                    print(credential.user);
                    context.pop();
                  } catch (e) {
                    print(e);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.toString()),
                      ),
                    );
                  }
                },
                child: const Text('Register')),
          ],
        ),
      ));
}
