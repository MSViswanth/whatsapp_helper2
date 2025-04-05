import 'package:flutter/material.dart';
import 'package:whatsapp_helper/screens/screens.dart';
import 'package:whatsapp_helper/screens/start_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp Helper',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          // brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const StartScreen(),
    );
  }
}
