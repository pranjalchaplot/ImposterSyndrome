import 'package:flutter/material.dart';
import 'package:imposter_syndrome_game/services/game_cards.dart';

import '../models/game_card.dart';
import '../models/enums/game_stage_enum.dart';

class DisplayCards extends StatelessWidget {
  final List<GameCard> gameCards;
  final GameStageEnum currentGameStage;

  const DisplayCards({
    super.key,
    required this.gameCards,
    required this.currentGameStage,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.0,
        ),
        itemCount: gameCards.length,
        itemBuilder: (BuildContext context, int index) {
          return getGameCard(
            currentGameStage,
            "Flip Me",
            gameCards[index].value,
            !gameCards[index].isLocked,
          );
        },
      ),
    );
  }

  GameCardVM getGameCard(GameStageEnum currentGameStage, String frontText,
      String backText, bool isEnabled) {
    GameCardVM gameCardVM;

    switch (currentGameStage) {
      case GameStageEnum.SelectionStage:
      case GameStageEnum.PlayStage:
      case GameStageEnum.EndStage:
      default:
        gameCardVM = GameCardVM(
          frontText: frontText,
          backText: backText,
          isEnabled: isEnabled,
        );
    }

    return gameCardVM;
  }
}
