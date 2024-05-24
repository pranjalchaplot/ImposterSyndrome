import 'dart:async';

import 'package:flutter/material.dart';
import 'package:imposter_syndrome_game/models/game_card.dart';
import 'package:imposter_syndrome_game/services/game_logic.dart';

import '../app_configs.dart';
import '../models/enums/game_stage_enum.dart';
import '../widgets/cards_view.dart';

class OffPlay extends StatefulWidget {
  final int numberOfPlayers;
  final String category;
  final String roundLength;

  const OffPlay({
    super.key,
    required this.numberOfPlayers,
    required this.category,
    required this.roundLength,
  });

  @override
  State<OffPlay> createState() => _OffPlayState();
}

class _OffPlayState extends State<OffPlay> {
  late List<GameCard> gameCards;
  late GameStageEnum currentGameStage;
  late int secondsRemaining = 0;
  late Timer? timer;

  @override
  void initState() {
    super.initState();
    gameCards =
        GameLogic.getItemsForCategory(widget.category, widget.numberOfPlayers);
    currentGameStage = GameStageEnum.selectionStage;
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer(int seconds) {
    secondsRemaining = seconds;
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        secondsRemaining--;
        if (secondsRemaining == 0) {
          t.cancel();
          // Handle timer expiration logic here
        }
      });
    });
  }

  void handleGameStageChange(GameStageEnum nextGameStage) {
    setState(() {
      currentGameStage = nextGameStage;
    });

    if (currentGameStage == GameStageEnum.playStage) {
      startTimer(AppConfigs.getRoundDuration(widget.roundLength));
    }
  }

  void handleRoundEnd(bool isImposter) {
    if (isImposter) {
      //handle playersWon
    } else {
      //next round/ imposter won.
    }
  }

  void handleGameCardVoting(int index) {
    if (index < 0 || index > gameCards.length - 1) {
      return;
    }

    bool isImposter = gameCards[index].isImposterCard;
    handleRoundEnd(isImposter);

    setState(() {
      gameCards[index].isEliminated = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      extendBodyBehindAppBar: true,
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
            DisplayCards(
              gameCards: gameCards,
              currentGameStage: currentGameStage,
              handleGameStageChange: handleGameStageChange,
              handleGameCardVoting: handleGameCardVoting,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Time Remaining: $secondsRemaining seconds',
                style: const TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
