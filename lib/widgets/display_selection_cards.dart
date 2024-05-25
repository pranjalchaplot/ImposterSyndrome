import 'package:flutter/material.dart';
import 'package:imposter_syndrome_game/providers/game_provider.dart';

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
              padding: const EdgeInsets.all(10.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 6.9,
                crossAxisSpacing: 6.9,
                childAspectRatio: 0.69,
              ),
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
