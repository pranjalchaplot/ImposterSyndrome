import 'dart:math';

import '../app_configs.dart';
import '../data/game_data.dart';
import '../models/game_card.dart';

class GameLogicHelper {
  static List<GameCard> getItemsForCategory(String category, int playerCount) {
    List<String> baseItems;

    baseItems = GameData.getItemsListByCategory(category);

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
