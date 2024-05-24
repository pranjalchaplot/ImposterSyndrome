import 'package:flutter/material.dart';
import 'package:imposter_syndrome_game/app_configs.dart';
import 'package:imposter_syndrome_game/services/game_cards.dart';

import '../models/game_card.dart';
import '../models/enums/game_stage_enum.dart';

class DisplayCards extends StatefulWidget {
  final List<GameCard> gameCards;
  final GameStageEnum currentGameStage;
  final Function(GameStageEnum) handleGameStageChange;
  final Function(int) handleGameCardVoting;

  const DisplayCards({
    super.key,
    required this.gameCards,
    required this.currentGameStage,
    required this.handleGameStageChange,
    required this.handleGameCardVoting,
  });

  @override
  State<DisplayCards> createState() => _DisplayCardsState();
}

class _DisplayCardsState extends State<DisplayCards> {
  late int selectedCards;
  late int eliminatedCards;

  void handleCompleteCardSelection() {
    selectedCards++;
    if (selectedCards == widget.gameCards.length) {
      widget.handleGameStageChange(GameStageEnum.playStage);
    }
  }

  @override
  void initState() {
    selectedCards = 0;
    eliminatedCards = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Flexible(
            child: GridView.builder(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 6.9,
                crossAxisSpacing: 6.9,
                childAspectRatio: 0.69,
              ),
              itemCount: widget.gameCards.length,
              itemBuilder: (BuildContext context, int index) {
                // return GameCardVM(
                //   cardIndex: index,
                //   frontText: "Flip Me",
                //   backText: widget.gameCards[index].value,
                //   isEliminated: widget.gameCards[index].isEliminated,
                //   isImposterCard: widget.gameCards[index].isImposterCard,
                //   currentGameStage: widget.currentGameStage,
                //   handleCompleteCardSelection: handleCompleteCardSelection,
                //   handleGameCardVoting: widget.handleGameCardVoting,
                // );
                return getGameCard(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  GameCardVM getGameCard(int index) {
    GameCardVM gameCardVM;

    String frontText = "";
    String backText = "";

    bool isEliminated = widget.gameCards[index].isEliminated;
    bool isImposterCard = widget.gameCards[index].isImposterCard;
    switch (widget.currentGameStage) {
      case GameStageEnum.selectionStage:
        frontText = "Flip Me";
        backText = widget.gameCards[index].value;
        break;
      case GameStageEnum.playStage:
        frontText = isEliminated
            ? "Card is Eliminated🚫"
            : "Choose a Card to Eliminate🤔";
        backText = isImposterCard ? AppConfigs.imposterString : "";
        break;
      case GameStageEnum.endStage:
      default:
        break;
    }

    gameCardVM = GameCardVM(
      cardIndex: index,
      frontText: frontText,
      backText: backText,
      isEliminated: widget.gameCards[index].isEliminated,
      isImposterCard: isImposterCard,
      currentGameStage: widget.currentGameStage,
      handleCompleteCardSelection: handleCompleteCardSelection,
      handleGameCardVoting: widget.handleGameCardVoting,
    );

    return gameCardVM;
  }
}
