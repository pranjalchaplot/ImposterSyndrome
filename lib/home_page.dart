import 'package:flutter/material.dart';
import 'package:imposter_syndrome_game/app_configs.dart';

import 'screens/off_play.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppConfigs.getAppBar(statusBarHeight, true),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: AppConfigs.gameBackgroundGradient,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _showOfflinePlayDialog(context);
              },
              child: const Text("Play Offline"),
            ),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                surfaceTintColor: Colors.black,
              ),
              child: const Text("Play Online"),
            ),
          ],
        ),
      ),
    );
  }

  void _showOfflinePlayDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int selectedPlayers = 4;
        String selectedCategory = 'Celebs';
        String selectedRoundLength = '30 seconds';

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Setup Game'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<int>(
                    value: selectedPlayers,
                    onChanged: (int? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedPlayers = newValue;
                        });
                      }
                    },
                    items: <int>[4, 5, 6, 7, 8, 9]
                        .map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text('$value Players'),
                      );
                    }).toList(),
                  ),
                  DropdownButton<String>(
                    value: selectedCategory,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedCategory = newValue;
                        });
                      }
                    },
                    items: <String>['Celebs', 'Cinema', 'Cities']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  DropdownButton<String>(
                    value: selectedRoundLength,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedRoundLength = newValue;
                        });
                      }
                    },
                    items: <String>['30 seconds', '1 minute', '2 minutes']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => OffPlay(
                          numberOfPlayers: selectedPlayers,
                          category: selectedCategory,
                          roundLength: selectedRoundLength,
                        ),
                      ),
                    );
                  },
                  child: const Text('Play'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
