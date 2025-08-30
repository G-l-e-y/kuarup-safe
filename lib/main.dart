import 'package:flutter/material.dart';
import 'package:kuarup_safe/home_screen.dart'; // Caminho corrigido
import 'package:kuarup_safe/login_page.dart';
import 'package:kuarup_safe/register_page.dart';
import 'package:kuarup_safe/recover_password.dart';
import 'package:kuarup_safe/contacts.dart';
import 'package:kuarup_safe/codeword.dart';
import 'package:kuarup_safe/history.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    title: 'Kuarup Safe',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF0D0F36),
        scaffoldBackgroundColor: const Color(0xFF0D0F36),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0D0F36),
          elevation: 0,
        ),
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF294380),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF294380),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register_page': (context) => const RegisterPage(),
        '/recover_password': (context) => const RecoverPassword(),
        '/home': (context) => const HomeScreen(),
        '/contacts': (context) => const ContactsPage(),
        '/codeword': (context) => const CodewordPage(),
        '/history': (context) => const  HistoryPage(),
      },
    );
  }
}