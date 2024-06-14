import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/game_data.dart';
import '../helpers/helper.dart';
import './app_configs.dart';
import './services/dialogs.dart';
import 'providers/game_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GameProvider _gameProvider;

  @override
  void initState() {
    super.initState();
    _gameProvider = GameProvider();
    _initializeData();
    _getLocalGameSettings();
  }

  @override
  void dispose() {
    super.dispose();
    _gameProvider.dispose();
  }

  Future<void> _getLocalGameSettings() async {
    _gameProvider.sharedPreferences = await SharedPreferences.getInstance();

    var playerLobbyMinSize =
        _gameProvider.sharedPreferences.getInt('playerLobbyMinSize');
    var selectedCategory =
        _gameProvider.sharedPreferences.getString('selectedCategory');

    if (playerLobbyMinSize != null) {
      _gameProvider.lobbySize = playerLobbyMinSize;
    }

    if (selectedCategory != null) {
      _gameProvider.selectedCategory = selectedCategory;
    }
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
              () => GameDialogs.showOfflinePlayDialog(
                context,
                _gameProvider,
              ),
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
