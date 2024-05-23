class GameCard {
  final String value;
  final String playerName = "";
  final bool isLocked = false;
  final bool isImposterCard;

  GameCard({
    required this.value,
    required this.isImposterCard,
  });
}
