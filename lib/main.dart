import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

class NetflixCloneIntroApp extends StatelessWidget {
  const NetflixCloneIntroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Netflix Clone',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,
      ),

      initialRoute: '/',

      routes: {
        '/': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/loginCode': (context) => const CodeLoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/payment': (context) => const PaymentScreen(),
        '/home': (context) => const HomeScreen(),
        '/myList': (context) => MyListScreen(),
        '/download': (context) => DownloadScreen(),
      },
    );
  }
}
