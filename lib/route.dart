// GoRouter configuration
import 'package:firebug/screen/chat/room/chat.room.screen.dart';
import 'package:firebug/screen/profile/profile.screen.dart';
import 'package:firebug/screen/user/list/user.list.screen.dart';
import 'package:go_router/go_router.dart';
import 'package:firebug/screen/about/about.screen.dart';
import 'package:firebug/screen/login_with_email_password/login_with_email_password.screen.dart';
import 'package:firebug/screen/phone_signin/phone_signin.screen.dart';
import 'package:firebug/screen/register_with_email_password/register_with_email_password.screen.dart';

import 'package:firebug/screen/home/home.screen.dart';

final router = GoRouter(
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
    GoRoute(
      path: ProfileScreen.routeName,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: UserList.routeName,
      builder: (context, state) => const UserList(),
    ),
    GoRoute(
      path: ChatRoomScreen.routeName,
      name: ChatRoomScreen.routeName,
      builder: (context, state) => ChatRoomScreen(uid: state.queryParameters['uid']!),
    ),
  ],
);
