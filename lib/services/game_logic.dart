import 'dart:math';

import 'package:imposter_syndrome_game/app_configs.dart';
import 'package:imposter_syndrome_game/data/game_data.dart';
import 'package:imposter_syndrome_game/models/game_card.dart';

class GameLogic {
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
