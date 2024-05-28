import 'package:flutter/material.dart';
import 'package:imposter_syndrome_game/providers/game_provider.dart';

import '../app_configs.dart';

class DisplayGameCards extends StatefulWidget {
  final GameProvider gameProvider;

  const DisplayGameCards({super.key, required this.gameProvider});

  @override
  State<DisplayGameCards> createState() => _DisplayGameCardsState();
}

class _DisplayGameCardsState extends State<DisplayGameCards> {
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
                  () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
