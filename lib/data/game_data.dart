import 'package:imposter_syndrome_game/app_configs.dart';

class GameData {
  static final List<int> _playerLobbyStrength = List<int>.generate(
    AppConfigs.playerLobbyMaxSize - AppConfigs.playerLobbyMinSize,
    (int index) {
      return index + AppConfigs.playerLobbyMinSize;
    },
  );

  static final List<String> _categories = [
    'Celebs',
    'Cinema',
    'Cities',
  ];

  static final List<String> _roundLengthOptions = [
    '30 seconds',
    '1 minute',
    '2 minutes'
  ];

  static List<int> getPlayerLobbySize() {
    return _playerLobbyStrength;
  }

  static List<String> getCategories() {
    return _categories;
  }

  static List<String> roundLengthOptions() {
    return _roundLengthOptions;
  }
}
