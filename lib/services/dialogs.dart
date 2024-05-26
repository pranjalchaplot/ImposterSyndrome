import 'package:flutter/material.dart';
import 'package:imposter_syndrome_game/app_configs.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../screens/off_play.dart';

class GameDialogs {
  static void showGameEndDialog(BuildContext context, bool imposterWon,
      String answer, String imposterPlayerName) {
    Future.delayed(AppConfigs.popupDisplayDelay, () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: imposterWon
                    ? const Color.fromARGB(255, 171, 114, 95)
                    : const Color.fromARGB(255, 0, 255, 4),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "The Word: $answer",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    imposterWon
                        ? '$imposterPlayerName Fooled The Lobby'
                        : '${AppConfigs.teamNameString} Won Against $imposterPlayerName',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop(); // Go back to main screen
                    },
                    child: const Text('Play Again'),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  static void showNextRoundDialog(BuildContext context, VoidCallback startTimer,
      Function(GameProvider) postElimination) {
    final gameProvider = context.read<GameProvider>();
    Future.delayed(AppConfigs.popupDisplayDelay, () {
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
                  startTimer();
                  postElimination(gameProvider);
                },
                child: const Text('Start Next Round'),
              ),
            ],
          );
        },
      );
    });
  }

  static void showGameStartDialog(
    BuildContext context,
    String category,
    int totalPlayers,
    String roundLength,
    VoidCallback startTimer,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 18, 207, 22), // Start color
                  Color.fromARGB(255, 31, 191, 124), // End color
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              // color: const Color.fromARGB(255, 210, 209, 209).withOpacity(0.6),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Find The ${AppConfigs.imposterString} 🕵️',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Category: $category\nRound Length: $roundLength\nTotal Players: $totalPlayers',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    startTimer();
                  },
                  child: const Text('Let\'s Begin the Game!'),
                ),
              ],
            ),
          ),
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

  static Future<String?> showUserNameDialog(BuildContext context) async {
    final TextEditingController controller = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Enter Username',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            // Handle the valid username
                            String username = controller.text;
                            Navigator.of(context).pop(username);
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
