import 'dart:async';
import 'package:flutter/material.dart';
import 'package:imposter_syndrome_game/app_configs.dart';
import 'package:imposter_syndrome_game/models/enums/game_stage_enum.dart';
import 'package:imposter_syndrome_game/models/game_card.dart';
import 'package:imposter_syndrome_game/services/dialogs.dart';
import 'package:imposter_syndrome_game/services/game_logic.dart';

import '../services/game_cards.dart';

class GameProvider extends ChangeNotifier {
  GameStageEnum _currentGameStage = GameStageEnum.selectionStage;
  Timer? _timer;
  int _secondsRemaining = 0;
  List<GameCard> _gameCards = [];
  String roundLength = "";
  String _answer = "";
  bool gameStarted = false;
  int _imposterCardIndex = 0;
  int selectedCards = 0;
  int eliminatedCards = 0;

  GameStageEnum get currentGameStage => _currentGameStage;
  int get secondsRemaining => _secondsRemaining;
  int get imposterCardIndex => _imposterCardIndex;
  String get answer => _answer;
  List<GameCard> get gameCards => _gameCards;

  void initializeGame(int numberOfPlayers, String category) {
    _gameCards = GameLogic.getItemsForCategory(category, numberOfPlayers);
    _answer = _gameCards.firstWhere((item) {
      return !item.isImposterCard;
    }).value;

    _imposterCardIndex = _gameCards.indexWhere((item) {
      return item.isImposterCard;
    });

    _currentGameStage = GameStageEnum.selectionStage;
    notifyListeners();
  }

  void handleCompleteCardSelection() {
    selectedCards++;
    if (selectedCards == gameCards.length) {
      handleGameStageChange(GameStageEnum.playStage);
    }
  }

  void startTimer() {
    _secondsRemaining = AppConfigs.getRoundDuration(roundLength);
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      _secondsRemaining--;
      if (_secondsRemaining == 0) {
        t.cancel();
        // Handle timer expiration logic here
      }
      notifyListeners();
    });
  }

  void stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null; // Set _timer to null after cancelling it
      notifyListeners(); // Notify listeners to update UI if necessary
    }
  }

  void handleGameStageChange(GameStageEnum nextGameStage) {
    _currentGameStage = nextGameStage;
    notifyListeners();
  }

  void handleGameEnd(BuildContext context, int index, bool isImposter) {
    if (!isImposter) {
      Future.delayed(const Duration(seconds: 1), () {
        gameCards[imposterCardIndex].flipCardController.toggleCard();
      });
    }
    GameDialogs.showGameEndDialog(
        context, !isImposter, answer, gameCards[imposterCardIndex].playerName);
  }

  void handleRoundEnd(BuildContext context, int index, bool isImposter) {
    eliminatedCards++;
    if (eliminatedCards == gameCards.length - 2 || isImposter) {
      handleGameEnd(context, index, isImposter);
    } else {
      GameDialogs.showNextRoundDialog(context, startTimer);
    }
  }

  void handleGameCardVoting(BuildContext context, int index) {
    if (index < 0 || index >= _gameCards.length) {
      return;
    }
    stopTimer();
    bool isImposter = _gameCards[index].isImposterCard;
    handleRoundEnd(context, index, isImposter);
    notifyListeners();
  }

  GameCardVM getGameCard(
    BuildContext context,
    int index,
    VoidCallback startRound,
  ) {
    GameCardVM gameCardVM;

    String frontText = "";
    String backText = "";

    GameCard currentPlayer = gameCards[index];

    bool isEliminated = currentPlayer.isEliminated;
    bool isImposterCard = currentPlayer.isImposterCard;
    String playerName = currentPlayer.playerName;

    switch (currentGameStage) {
      case GameStageEnum.selectionStage:
        frontText = "Select A Card!!👆";
        backText = gameCards[index].value;
        break;
      case GameStageEnum.playStage:
        frontText = isEliminated
            ? "$playerName is Eliminated💀"
            : "Eliminate $playerName🎯";
        backText = isImposterCard
            ? "$playerName is The ${AppConfigs.imposterString}"
            : "$playerName is Not The ${AppConfigs.imposterString}";
        break;
      case GameStageEnum.endStage:
      default:
        break;
    }
    gameCardVM = GameCardVM(
      cardIndex: index,
      frontText: frontText,
      backText: backText,
      isEliminated: isEliminated,
      isImposterCard: isImposterCard,
      handleCompleteCardSelection: handleCompleteCardSelection,
      startRound: startRound,
    );

    return gameCardVM;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
