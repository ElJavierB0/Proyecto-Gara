import 'package:flutter/material.dart';
import 'Login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gara',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Colors.indigoAccent.shade700),
        useMaterial3: true,
      ),
      home: const LoginPage(title: 'G-T'),
    );
  }
}
