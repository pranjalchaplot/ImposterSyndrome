import 'dart:async';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_configs.dart';
import '../models/enums/game_stage_enum.dart';
import '../models/game_card.dart';
import '../services/dialogs.dart';
import '../helpers/game_logic.dart';

import '../services/game_card_view_model.dart';

class GameProvider extends ChangeNotifier {
  GameStageEnum _currentGameStage = GameStageEnum.selectionStage;
  String selectedCategory = AppConfigs.selectedCategory;
  int lobbySize = AppConfigs.playerLobbyMinSize;
  Timer? _timer;
  int _secondsRemaining = 0;
  List<GameCard> _gameCards = [];
  String roundLength = "";
  String _answer = "";
  bool gameStarted = false;
  bool imposterWon = false;
  int _imposterCardIndex = 0;
  int selectedCards = 0;
  int eliminatedCards = 0;
  ConfettiController confettiController = ConfettiController();
  late SharedPreferences sharedPreferences;

  bool _lockCards = false;
  int _currentSelectedCardIndex = 0;

  GameStageEnum get currentGameStage => _currentGameStage;
  int get secondsRemaining => _secondsRemaining;
  int get imposterCardIndex => _imposterCardIndex;
  String get answer => _answer;
  List<GameCard> get gameCards => _gameCards;

  bool get lockCards => _lockCards;
  int get currentSelectedCardIndex => _currentSelectedCardIndex;

  void initializeGame(int numberOfPlayers, String category) {
    _gameCards = GameLogicHelper.getItemsForCategory(category, numberOfPlayers);
    _answer = _gameCards.firstWhere((item) {
      return !item.isImposterCard;
    }).value;

    _imposterCardIndex = _gameCards.indexWhere((item) {
      return item.isImposterCard;
    });

    _currentGameStage = GameStageEnum.selectionStage;
    notifyListeners();
  }

  void lockSelectionCards(int cardIndex) {
    _currentSelectedCardIndex = cardIndex;
    _lockCards = true;
    notifyListeners();
  }

  void unlockSelectionCards(int cardIndex) {
    _currentSelectedCardIndex = -1;
    _lockCards = false;
    notifyListeners();
  }

  bool handleCompleteCardSelection() {
    selectedCards++;
    if (selectedCards == gameCards.length) {
      return true;
    }
    return false;
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

  void _playConfetti() {
    confettiController.play();
    Timer(
      const Duration(seconds: 3),
      _stopConfetti,
    );
  }

  void _stopConfetti() {
    confettiController.stop();
  }

  void handleGameEnd(BuildContext context, int index, bool isImposter) {
    Future.delayed(const Duration(seconds: 1), () {
      if (!isImposter) {
        gameCards[imposterCardIndex].flipCardController.toggleCard();
      }
      _playConfetti();
    });

    imposterWon = !isImposter;

    GameDialogs.showGameEndDialog(
      context,
      imposterWon,
      answer,
      gameCards[imposterCardIndex].playerName,
    );
  }

  void handleRoundEnd(BuildContext context, int index, bool isImposter,
      Function(GameProvider) postElimination) {
    eliminatedCards++;
    if (eliminatedCards == gameCards.length - 2 || isImposter) {
      handleGameEnd(context, index, isImposter);
    } else {
      GameDialogs.showNextRoundDialog(context, startTimer, postElimination);
    }
  }

  // Future<void> shareGameResult() async {
  //   List<String> allPlayerNames =
  //       gameCards.map((item) => item.playerName).toList();

  //   String shareableText = Helper.getShareableText(
  //     imposterWon,
  //     imposterCardIndex,
  //     allPlayerNames,
  //   );

  //   final result = await Share.share(
  //     shareableText,
  //   );

  //   if (result.status == ShareResultStatus.success) {
  //     //print('Thank you for sharing my website!');
  //   }
  // }

  void handleGameCardVoting(
      BuildContext context, int index, Function(GameProvider) postElimination) {
    if (index < 0 || index >= _gameCards.length) {
      return;
    }
    stopTimer();
    bool isImposter = _gameCards[index].isImposterCard;
    handleRoundEnd(context, index, isImposter, postElimination);
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
        frontText = "?";
        backText = gameCards[index].value;
        break;
      case GameStageEnum.playStage:
        frontText = isEliminated
            ? "$playerName is Eliminated💀"
            : "Eliminate\n$playerName";
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
