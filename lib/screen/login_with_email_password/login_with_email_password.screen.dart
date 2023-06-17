import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class LoginWithEmailPasswordScreen extends StatefulWidget {
  const LoginWithEmailPasswordScreen({super.key});

  static const String routeName = '/login-with-email-password';

  @override
  State<LoginWithEmailPasswordScreen> createState() =>
      _LoginWithEmailPasswordScreenState();
}

class _LoginWithEmailPasswordScreenState
    extends State<LoginWithEmailPasswordScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  @override
  build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Email Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: email,
              decoration: const InputDecoration(label: Text('Email')),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: password,
              decoration: const InputDecoration(label: Text('Password')),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () async {
                  try {
                    final credential =
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
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
                child: const Text('Login')),
          ],
        ),
      ));
}
