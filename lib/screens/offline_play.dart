// import 'package:flutter/material.dart';
// import 'package:imposter_syndrome_game/widgets/fippable_card.dart';
// import '../services/game_logic.dart';
// import '../services/dialogs.dart';

// class OfflinePlay extends StatefulWidget {
//   final int numberOfPlayers;
//   final String category;
//   final String roundLength;

//   const OfflinePlay({
//     super.key,
//     required this.numberOfPlayers,
//     required this.category,
//     required this.roundLength,
//   });

//   @override
//   State<OfflinePlay> createState() {
//     return _OfflinePlayState();
//   }
// }

// class _OfflinePlayState extends State<OfflinePlay> {
//   late List<String> items;
//   bool _roundActive = false;
//   int _round = 1;
//   bool _gameOver = false;
//   late GameLogic gameLogic;
//   late GameDialogs gameDialogs;
//   Duration roundDuration = const Duration(seconds: 30);
//   List<bool> lockedCards = [];

//   @override
//   void initState() {
//     super.initState();
//     gameLogic = GameLogic();
//     gameDialogs = GameDialogs();
//     items =
//         gameLogic.getItemsForCategory(widget.category, widget.numberOfPlayers);
//     roundDuration = _getRoundDuration(widget.roundLength);
//     lockedCards = List.generate(widget.numberOfPlayers, (index) => false);
//   }

//   void _startRound() {
//     setState(() {
//       _roundActive = true;
//     });
//     _startTimer();
//   }

//   void _startTimer() {
//     Future.delayed(roundDuration, () {
//       if (_roundActive) {
//         setState(() {
//           _roundActive = false;
//           _gameOver = true;
//         });
//         gameDialogs.showImposterWinsDialog(context);
//       }
//     });
//   }

//   void _onFlip(int index) {
//     setState(() {
//       lockedCards[index] = true;
//     });
//   }

//   void _onImposterSelected() {
//     setState(() {
//       _gameOver = true;
//     });
//     gameDialogs.showYouWinDialog(context);
//   }

//   void _onNextRound() {
//     setState(() {
//       _round++;
//       _roundActive = false;
//       items.removeWhere((item) => item == 'Not Imposter');
//       if (items.length <= 2) {
//         _gameOver = true;
//         gameDialogs.showImposterWinsDialog(context);
//       }
//     });
//   }

//   Duration _getRoundDuration(String roundLength) {
//     switch (roundLength) {
//       case '30 seconds':
//         return const Duration(seconds: 30);
//       case '1 minute':
//         return const Duration(minutes: 1);
//       case '2 minutes':
//         return const Duration(minutes: 2);
//       default:
//         return const Duration(seconds: 30);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Offline Play'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: GridView.builder(
//               padding: const EdgeInsets.all(10.0),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 10,
//                 crossAxisSpacing: 10,
//                 childAspectRatio: 1.0,
//               ),
//               itemCount: widget.numberOfPlayers,
//               itemBuilder: (BuildContext context, int index) {
//                 return FlipableCard(
//                   text: items[index],
//                   isImposter: items[index] == 'IMPOSTER',
//                   onFlip: () => _onFlip(index),
//                   onImposterSelected: _onImposterSelected,
//                   isLocked: lockedCards[index],
//                   isEliminated: _gameOver,
//                   isRoundActive: _roundActive,
//                 );
//               },
//             ),
//           ),
//           if (!_roundActive && !_gameOver)
//             ElevatedButton(
//               onPressed: _startRound,
//               child: const Text('Start Round'),
//             ),
//           if (_roundActive)
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   _roundActive = false;
//                 });
//               },
//               child: const Text('Vote Now'),
//             ),
//         ],
//       ),
//     );
//   }
// }
