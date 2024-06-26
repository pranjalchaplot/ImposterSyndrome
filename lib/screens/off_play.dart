import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:imposter_syndrome_game/models/enums/game_stage_enum.dart';
import 'package:imposter_syndrome_game/services/dialogs.dart';
import 'package:imposter_syndrome_game/widgets/display_game_cards.dart';
import 'package:imposter_syndrome_game/widgets/display_selection_cards.dart';
import 'package:provider/provider.dart';

import '../app_configs.dart';
import '../providers/game_provider.dart';
import '../widgets/banner_text.dart';

class OffPlay extends StatefulWidget {
  final int numberOfPlayers;
  final String category;
  final String roundLength;
  final GameProvider gameProvider;

  const OffPlay({
    super.key,
    required this.numberOfPlayers,
    required this.category,
    required this.roundLength,
    required this.gameProvider,
  });

  @override
  State<OffPlay> createState() => _OffPlayState();
}

class _OffPlayState extends State<OffPlay> {
  late GameProvider _gameProvider;
  final confettiController = ConfettiController();

  @override
  void initState() {
    super.initState();
    _gameProvider = widget.gameProvider;
    _gameProvider.initializeGame(widget.numberOfPlayers, widget.category);
    _gameProvider.roundLength = widget.roundLength;
    _gameProvider.confettiController = confettiController;
    _storeLocalGameSettings();
  }

  void _storeLocalGameSettings() {
    _gameProvider.sharedPreferences
        .setInt('playerLobbyMinSize', widget.numberOfPlayers);
    _gameProvider.sharedPreferences
        .setString('selectedCategory', widget.category);

    _gameProvider.lobbySize = widget.numberOfPlayers;
    _gameProvider.selectedCategory = widget.category;
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  void startRound() {
    setState(() {
      _gameProvider.gameStarted = true;
    });
    GameDialogs.showGameStartDialog(
      context,
      widget.category,
      widget.numberOfPlayers,
      widget.roundLength,
      _gameProvider.startTimer,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return ChangeNotifierProvider.value(
      value: _gameProvider,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Scaffold(
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
                  SizedBox(
                    height: statusBarHeight + 150,
                  ),
                  getDisplayWidget(),
                ],
              ),
            ),
          ),
          ConfettiWidget(
            confettiController: confettiController,
            blastDirection: pi / 2,
            blastDirectionality: BlastDirectionality.explosive,
            numberOfParticles: 20,
            emissionFrequency: 0.069,
          )
        ],
      ),
    );
  }

  Widget getBottomBannerWidget() {
    return const BannerText();
  }

  Widget getDisplayWidget() {
    if (_gameProvider.currentGameStage == GameStageEnum.selectionStage) {
      return DisplaySelectionCards(
        gameProvider: _gameProvider,
        startRound: startRound,
      );
    } else if (_gameProvider.currentGameStage == GameStageEnum.playStage) {
      return DisplayGameCards(gameProvider: _gameProvider);
    }

    return const Text("something went wrong");
  }
}
