import 'package:flutter/material.dart';
import 'screens/qbot_screen.dart';

void main() {
  runApp(const QBotApp());
}

class QBotApp extends StatelessWidget {
  const QBotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Q-bot 2.0',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0E27),
        primaryColor: const Color(0xFF00D9FF),
        fontFamily: 'Roboto',
      ),
      home: const QBotScreen(),
    );
  }
}
