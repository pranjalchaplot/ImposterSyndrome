import 'package:flutter/material.dart';
import 'package:imposter_syndrome_game/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'IMPOSTER SYNDROME : THE GAME',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
