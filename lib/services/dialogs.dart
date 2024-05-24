import 'package:flutter/material.dart';

import '../screens/off_play.dart';

class GameDialogs {
  static void showYouWinDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('You Won!'),
          content: const Text('Congratulations, you found the imposter!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Go back to main screen
              },
              child: const Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  static void showImposterWinsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Imposter Wins'),
          content: const Text('The imposter was not found in time.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Go back to main screen
              },
              child: const Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  static void showNextRoundDialog(
      BuildContext context, VoidCallback onNextRound) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Imposter is still among us'),
          content: const Text('Proceed to the next round.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onNextRound();
              },
              child: const Text('Start Next Round'),
            ),
          ],
        );
      },
    );
  }

  static void showOfflinePlayDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        //Set this defaults in app configs
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
