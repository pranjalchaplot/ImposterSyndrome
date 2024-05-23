import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class GameCardVM extends StatelessWidget {
  final String frontText;
  final String backText;
  final bool isEnabled;

  const GameCardVM({
    super.key,
    required this.frontText,
    required this.backText,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      flipOnTouch: isEnabled,
      fill: Fill.fillBack,
      direction: FlipDirection.HORIZONTAL,
      side: CardSide.FRONT,
      front: Card(
        elevation: 4.0,
        child: Center(
          child: Text(
            frontText,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      back: Card(
        elevation: 4.0,
        child: Center(
          child: Text(
            backText,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
