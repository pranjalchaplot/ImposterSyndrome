import 'package:flip_card/flip_card_controller.dart';

class GameCard {
  final String value;
  String playerName = "";
  late bool isEliminated = false;
  FlipCardController flipCardController = FlipCardController();
  final bool isImposterCard;

  GameCard({
    required this.value,
    required this.isImposterCard,
  });
}
