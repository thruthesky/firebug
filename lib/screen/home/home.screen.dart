import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebug/screen/login_with_email_password/login_with_email_password.screen.dart';
import 'package:firebug/screen/phone_signin/phone_signin.screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  @override
  build(context) => Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Text('Home'),
              const SizedBox(height: 16),
              StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    User? user = snapshot.data;
                    if (user == null) {
                      return const Text('Not logged in');
                    } else {
                      return Text('Logged in as ${user.email ?? user.phoneNumber}');
                    }
                  } else {
                    return const Text('Not logged in');
                  }
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
                child: const Text('Sign Out'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.push('/register-with-email-password');
                },
                child: const Text('Register with Email'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.push(LoginWithEmailPasswordScreen.routeName);
                },
                child: const Text('Login with Email'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.push(PhoneSigninScreen.routeName);
                },
                child: const Text('Phone Sign-in'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.push('/about');
                },
                child: const Text('About Screen'),
              ),
            ],
          ),
        ),
      );
}
