import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebug/screen/about/about.screen.dart';
import 'package:firebug/screen/login_with_email_password/login_with_email_password.screen.dart';
import 'package:firebug/screen/phone_signin/phone_signin.screen.dart';
import 'package:firebug/screen/profile/profile.screen.dart';
import 'package:firebug/screen/register_with_email_password/register_with_email_password.screen.dart';
import 'package:firebug/screen/user/list/user.list.screen.dart';
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
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text('Loading...');
                  }
                  User? user = snapshot.data;
                  if (user == null) {
                    return Column(
                      children: [
                        const Text('Not logged in'),
                        ElevatedButton(
                          onPressed: () {
                            context.push(RegisterWithEmailPasswordScreen.routeName);
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
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        Text('Logged in as ${user.email ?? user.phoneNumber}'),
                        ElevatedButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                          },
                          child: const Text('Sign Out'),
                        ),
                        ElevatedButton(
                          onPressed: () => context.push(ProfileScreen.routeName),
                          child: const Text('Profile'),
                        ),
                      ],
                    );
                  }
                },
              ),
              ElevatedButton(
                onPressed: () {
                  context.push(UserList.routeName);
                },
                child: const Text('User List'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.push(AboutScreen.routeName);
                },
                child: const Text('About Screen'),
              ),
            ],
          ),
        ),
      );
}
