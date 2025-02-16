import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart'; // Import the path_provider package
import '../app_configs.dart';
import '../models/game_data_vm.dart';

class GameData {
  static final List<int> _playerLobbyStrength = List<int>.generate(
    AppConfigs.playerLobbyMaxSize - AppConfigs.playerLobbyMinSize + 1,
    (int index) {
      return index + AppConfigs.playerLobbyMinSize;
    },
  );

  static List<String> _categories = List.empty();
  static List<String> _roundLengthOptions = List.empty();
  static late GameDataVM _defaultCategoriesData;
  static late GameDataVM _categoriesData;

  static Future<void> loadCategories() async{
    _categories = _categoriesData.category.map((category) => category.name).toList();
  }

  static Future<void> fetchRoundLengthOptions() async{
    _roundLengthOptions = _categoriesData.roundsLengthOption;
  }

  static Future<void> fetchDefaultGameDataFromJSON() async{
    final jsonData = await rootBundle.loadString(AppConfigs.gameDataPath);
    final jsonMap = jsonDecode(jsonData);
    _defaultCategoriesData = GameDataVM.fromJson(jsonMap);
  }

  static Future<void> setGameDataToDefault() async{
    _categoriesData = _defaultCategoriesData;
    await _saveDataToCache();
  }

  static Future<void> loadData() async {

    await fetchDefaultGameDataFromJSON();
    final cacheFile = await _getCacheFile();

    if (!(await cacheFile.exists())){
      await setGameDataToDefault();
    }

    final jsonData = await cacheFile.readAsString();
    
    if (jsonData.isEmpty) {
      await setGameDataToDefault();
    }
    else {
      try {
        final jsonMap = jsonDecode(jsonData);
        _categoriesData = GameDataVM.fromJson(jsonMap);
      } catch (e) {
        await setGameDataToDefault();
      }
    }
    
    loadCategories();
    fetchRoundLengthOptions();
    
    await _saveDataToCache();
  }

  static Future<File> _getCacheFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/game_data_cache.json');
  }

  static Future<void> saveDataToCache() async {
    _saveDataToCache();
  }

  static Future<void> _saveDataToCache() async {
    final cacheFile = await _getCacheFile();
    final jsonData = jsonEncode(_categoriesData.toJson());
    await cacheFile.writeAsString(jsonData);
  }

  static List<int> getPlayerLobbySize() {
    return _playerLobbyStrength;
  }

  static List<String> getCategories() {
    loadCategories();
    return _categories;
  }

  static void addCategory(String categoryName) {
    if (_categories.contains(categoryName)) {
      return;
    }
    _categories.add(categoryName);
    _categoriesData.category.add(Category(name: categoryName, data: []));
    _saveDataToCache();
  }

  static void addData(String categoryName, String dataItem) {
    final category = _categoriesData.category.firstWhere(
      (item) => item.name == categoryName,
      orElse: () {
        _categories.add(categoryName);
        return Category(name: categoryName, data: []);
      },
    );
    if (!category.data.contains(dataItem)) {
      category.data.add(dataItem);
    }
    _saveDataToCache();
  }

  static List<String> getRoundLengthOptions() {
    fetchRoundLengthOptions();
    return _roundLengthOptions;
  }

  static List<String> getItemsListByCategory(String gameCategory) {
    return _categoriesData.category
        .firstWhere((item) => item.name == gameCategory)
        .data;
  }
}
