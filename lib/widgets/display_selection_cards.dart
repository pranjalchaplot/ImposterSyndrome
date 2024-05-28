import 'package:flutter/material.dart';
import 'package:imposter_syndrome_game/providers/game_provider.dart';

import '../app_configs.dart';

class DisplaySelectionCards extends StatefulWidget {
  final GameProvider gameProvider;
  final VoidCallback startRound;

  const DisplaySelectionCards({
    super.key,
    required this.gameProvider,
    required this.startRound,
  });

  @override
  State<DisplaySelectionCards> createState() => _DisplaySelectionCardsState();
}

class _DisplaySelectionCardsState extends State<DisplaySelectionCards> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Flexible(
            child: GridView.builder(
              padding: AppConfigs.gridPadding,
              gridDelegate: AppConfigs.gridDelegate,
              itemCount: widget.gameProvider.gameCards.length,
              itemBuilder: (BuildContext context, int index) {
                return widget.gameProvider.getGameCard(
                  context,
                  index,
                  widget.startRound,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
