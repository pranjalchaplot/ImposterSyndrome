class GameCard {
  final String value;
  final String playerName = "";
  late bool isEliminated = false;
  final bool isImposterCard;

  GameCard({
    required this.value,
    required this.isImposterCard,
  });
}
