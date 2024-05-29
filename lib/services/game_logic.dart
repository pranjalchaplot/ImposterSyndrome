import 'dart:math';

import 'package:collection/collection.dart';
import 'package:imposter_syndrome_game/app_configs.dart';
import 'package:imposter_syndrome_game/data/game_data.dart';
import 'package:imposter_syndrome_game/models/game_card.dart';

class GameLogic {
  static List<GameCard> getItemsForCategory(String categoryName, int playerCount) {
    final categoryData = GameData.categoriesData.category.firstWhereOrNull(
      (category) => category.name == categoryName,
    );

    // If the category is not found, return an empty list
    if (categoryData == null) {
      return [];
    }

    final baseItems = categoryData.data;
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
