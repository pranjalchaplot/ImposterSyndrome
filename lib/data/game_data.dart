import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../app_configs.dart';
import '../models/game_data_vm.dart';

class GameData {
  static final List<int> _playerLobbyStrength = List<int>.generate(
    AppConfigs.playerLobbyMaxSize - AppConfigs.playerLobbyMinSize,
    (int index) {
      return index + AppConfigs.playerLobbyMinSize;
    },
  );

  static List<String> _categories = List.empty();
  static List<String> _roundLengthOptions = List.empty();
  static late GameDataVM _categoriesData;

  static Future<void> loadData() async {
    final jsonData = await rootBundle.loadString(AppConfigs.gameDataPath);
    final jsonMap = jsonDecode(jsonData);
    _categoriesData = GameDataVM.fromJson(jsonMap);
    _categories =
        _categoriesData.category.map((category) => category.name).toList();
    _roundLengthOptions = _categoriesData.roundsLengthOption;
  }

  static List<int> getPlayerLobbySize() {
    return _playerLobbyStrength;
  }

  static List<String> getCategories() {
    return _categories;
  }

  static List<String> getRoundLengthOptions() {
    return _roundLengthOptions;
  }

  static List<String> getItemsListByCategory(String gameCategory) {
    return _categoriesData.category
        .firstWhere((item) => item.name == gameCategory)
        .data;
  }
}
