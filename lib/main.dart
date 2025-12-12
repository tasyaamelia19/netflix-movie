import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Import semua screen
import 'screens/splash_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/login_code_screen.dart';
import 'screens/register_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/home_screen.dart';
import 'screens/my_list_screen.dart';
import 'screens/download_screen.dart';

void main() {
  runApp(const ProviderScope(child: NetflixCloneIntroApp()));
}

// ================= GO ROUTER ===================

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/loginCode',
      builder: (context, state) => const CodeLoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/payment',
      builder: (context, state) => const PaymentScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/myList',
      builder: (context, state) => MyListScreen(),
    ),
    GoRoute(
      path: '/download',
      builder: (context, state) => DownloadScreen(),
    ),
  ],
);

// ================================================

class NetflixCloneIntroApp extends StatelessWidget {
  const NetflixCloneIntroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Netflix Clone',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,
      ),

      routerConfig: _router,
    );
  }
}
