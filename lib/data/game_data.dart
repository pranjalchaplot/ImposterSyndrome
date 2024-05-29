import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:imposter_syndrome_game/app_configs.dart';
import 'package:imposter_syndrome_game/models/game_data_vm.dart';

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
    final jsonData = await rootBundle.loadString('lib/data/game_data.json');
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

  static List<String> roundLengthOptions() {
    return _roundLengthOptions;
  }

  static GameDataVM get categoriesData => _categoriesData;
}