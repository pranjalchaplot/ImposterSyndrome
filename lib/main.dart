import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imposter_syndrome_game/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'IMPOSTER SYNDROME : THE GAME',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
