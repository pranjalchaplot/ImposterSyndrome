import 'package:flutter/material.dart';
import 'package:imposter_syndrome_game/models/enums/game_stage_enum.dart';
import 'package:imposter_syndrome_game/services/dialogs.dart';
import 'package:imposter_syndrome_game/widgets/display_game_cards.dart';
import 'package:imposter_syndrome_game/widgets/display_selection_cards.dart';
import 'package:provider/provider.dart';

import '../app_configs.dart';
import '../providers/game_provider.dart';
import '../widgets/time_display.dart';

class OffPlay extends StatefulWidget {
  final int numberOfPlayers;
  final String category;
  final String roundLength;

  const OffPlay({
    super.key,
    required this.numberOfPlayers,
    required this.category,
    required this.roundLength,
  });

  @override
  State<OffPlay> createState() => _OffPlayState();
}

class _OffPlayState extends State<OffPlay> {
  late GameProvider _gameProvider;

  @override
  void initState() {
    super.initState();
    _gameProvider = GameProvider();
    _gameProvider.initializeGame(widget.numberOfPlayers, widget.category);
    _gameProvider.roundLength = widget.roundLength;
  }

  @override
  void dispose() {
    _gameProvider.dispose();
    super.dispose();
  }

  void startRound() {
    setState(() {
      _gameProvider.gameStarted = true;
    });
    GameDialogs.showGameStartDialog(
      context,
      widget.category,
      widget.numberOfPlayers,
      widget.roundLength,
      _gameProvider.startTimer,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return ChangeNotifierProvider.value(
      value: _gameProvider,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppConfigs.getAppBar(statusBarHeight, true),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: AppConfigs.gameBackgroundGradient,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: statusBarHeight + 150,
              ),
              ...getDisplayWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getBottomBannerWidget() {
    return const TimeRemainingDisplay();
  }

  List<Widget> getDisplayWidget() {
    List<Widget> displayWidgets = List.empty(growable: true);

    if (_gameProvider.currentGameStage == GameStageEnum.selectionStage) {
      displayWidgets.add(DisplaySelectionCards(
        gameProvider: _gameProvider,
        startRound: startRound,
      ));
    } else if (_gameProvider.currentGameStage == GameStageEnum.playStage) {
      displayWidgets.add(
        DisplayGameCards(gameProvider: _gameProvider),
      );
      displayWidgets.add(getBottomBannerWidget());
    } else {
      displayWidgets.add(const Text("something went wrong"));
    }

    return displayWidgets;
  }
}
