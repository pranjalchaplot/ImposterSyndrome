import 'package:flutter/material.dart';

class GameDialogs {
  void showYouWinDialog(BuildContext context) {
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

  void showImposterWinsDialog(BuildContext context) {
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

  void showNextRoundDialog(BuildContext context, VoidCallback onNextRound) {
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
}
