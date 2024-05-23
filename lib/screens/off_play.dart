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

  @override
  void initState() {
    super.initState();
    gameCards =
        GameLogic.getItemsForCategory(widget.category, widget.numberOfPlayers);
    currentGameStage = GameStageEnum.SelectionStage;
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
            ),
          ],
        ),
      ),
    );
  }
}
