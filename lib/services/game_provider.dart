import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:imposter_syndrome_game/app_configs.dart';
import 'package:imposter_syndrome_game/models/enums/game_stage_enum.dart';
import 'package:imposter_syndrome_game/models/game_card.dart';
import 'package:imposter_syndrome_game/services/game_logic.dart';

class GameProvider extends ChangeNotifier {
  GameStageEnum _currentGameStage = GameStageEnum.selectionStage;
  Timer? _timer;
  int _secondsRemaining = 0;
  List<GameCard> _gameCards = [];

  GameStageEnum get currentGameStage => _currentGameStage;
  int get secondsRemaining => _secondsRemaining;
  List<GameCard> get gameCards => _gameCards;

  void initializeGame(int numberOfPlayers, String category) {
    _gameCards = GameLogic.getItemsForCategory(category, numberOfPlayers);
    _currentGameStage = GameStageEnum.selectionStage;
    notifyListeners();
  }

  void startTimer(String roundLength) {
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

  void handleGameStageChange(GameStageEnum nextGameStage, String roundLength) {
    _currentGameStage = nextGameStage;
    if (_currentGameStage == GameStageEnum.playStage) {
      startTimer(roundLength);
    }
    notifyListeners();
  }

  void handleRoundEnd(bool isImposter) {
    if (isImposter) {
      // handle playersWon
    } else {
      // next round/ imposter won.
    }
  }

  void handleGameCardVoting(int index) {
    if (index < 0 || index >= _gameCards.length) {
      return;
    }
    bool isImposter = _gameCards[index].isImposterCard;
    handleRoundEnd(isImposter);
    _gameCards[index].isEliminated = true;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
