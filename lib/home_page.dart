import 'package:flutter/material.dart';
import '../data/game_data.dart';
import '../helpers/helper.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Helper.getHomeScreenButton(
              () => GameDialogs.showOfflinePlayDialog(context),
              "Play Offline",
              Icons.downloading,
            ),
            Helper.getHomeScreenButton(
              () => GameDialogs.showHowToPlayDialog(context),
              "How To Play",
              Icons.question_mark_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
