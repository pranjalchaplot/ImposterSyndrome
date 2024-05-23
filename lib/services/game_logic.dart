import 'dart:math';

import 'package:imposter_syndrome_game/app_configs.dart';
import 'package:imposter_syndrome_game/models/game_card.dart';

class GameLogic {
  static List<GameCard> getItemsForCategory(String category, int playerCount) {
    List<String> baseItems;
    switch (category) {
      case 'Celebs':
        baseItems = ['Virat Kohli', 'PRANJAL', 'MS Dhoni', 'SRK', 'Steve Jobs'];
        break;
      case 'Cinema':
        baseItems = ['3 Idiots', 'Drishyam', 'Dhoom', 'Jab We Met', 'Shaitaan'];
        break;
      case 'Cities':
        baseItems = ['Udaipur', 'Chennai', 'Bangaluru', 'Mumbai', 'Pune'];
        break;
      default:
        baseItems = [];
    }

    final random = Random();
    String commonItem = baseItems[random.nextInt(baseItems.length)];

    List<GameCard> items = List.generate(
      playerCount - 1,
      (index) => GameCard(
        value: commonItem,
        isImposterCard: false,
      ),
    );

    items.add(
      GameCard(
        value: AppConfigs.imposterString,
        isImposterCard: true,
      ),
    );
    items.shuffle();

    return items;
  }
}
