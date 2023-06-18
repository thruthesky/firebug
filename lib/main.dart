import 'package:firebug/screen/about/about.screen.dart';
import 'package:firebug/screen/login_with_email_password/login_with_email_password.screen.dart';
import 'package:firebug/screen/phone_signin/phone_signin.screen.dart';
import 'package:firebug/screen/register_with_email_password/register_with_email_password.screen.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:go_router/go_router.dart';

import 'package:firebug/screen/home/home.screen.dart';

// GoRouter configuration
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/about',
      builder: (context, state) => const AboutScreen(),
    ),
    GoRoute(
      path: RegisterWithEmailPasswordScreen.routeName,
      builder: (context, state) => const RegisterWithEmailPasswordScreen(),
    ),
    GoRoute(
      path: LoginWithEmailPasswordScreen.routeName,
      builder: (context, state) => const LoginWithEmailPasswordScreen(),
    ),
    GoRoute(
      path: PhoneSigninScreen.routeName,
      builder: (context, state) => const PhoneSigninScreen(),
    ),
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
