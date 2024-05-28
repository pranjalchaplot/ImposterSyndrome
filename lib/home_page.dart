import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imposter_syndrome_game/data/game_data.dart';
import './app_configs.dart';
import './services/dialogs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override 
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await GameData.loadData();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppConfigs.getAppBar(statusBarHeight, true),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: AppConfigs.gameBackgroundGradient,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                GameDialogs.showOfflinePlayDialog(context);
              },
              style: const ButtonStyle(
                backgroundColor: WidgetStateColor.transparent,
              ),
              child: Text(
                "Play Offline",
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.italic,
                  color: Colors.redAccent,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
