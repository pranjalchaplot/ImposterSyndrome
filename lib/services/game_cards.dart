import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:imposter_syndrome_game/app_configs.dart';
import 'package:imposter_syndrome_game/models/enums/game_stage_enum.dart';
import 'package:imposter_syndrome_game/providers/game_provider.dart';
import 'package:imposter_syndrome_game/services/dialogs.dart';
import 'package:provider/provider.dart';

class GameCardVM extends StatefulWidget {
  final String frontText;
  final String backText;
  final int cardIndex;
  final bool isEliminated;
  final bool isImposterCard;
  final VoidCallback handleCompleteCardSelection;
  final VoidCallback startRound;

  const GameCardVM({
    super.key,
    required this.frontText,
    required this.backText,
    required this.isEliminated,
    required this.isImposterCard,
    required this.handleCompleteCardSelection,
    required this.cardIndex,
    required this.startRound,
  });

  @override
  State<GameCardVM> createState() => _GameCardVMState();
}

class _GameCardVMState extends State<GameCardVM> {
  int flipCount = 0;
  String _frontText = "";
  String _backText = "";
  final _cardSide = CardSide.FRONT;
  bool _isCardSelected = false;
  ValueNotifier<bool> enableFlipping;

  _GameCardVMState() : enableFlipping = ValueNotifier(true);
  late FlipCardController _controller;

  @override
  void initState() {
    super.initState();
    flipCount = 0;
    _controller = FlipCardController();
    enableFlipping.value = !widget.isEliminated;
    _frontText = widget.frontText;
    _backText = widget.backText;
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = context.read<GameProvider>();
    gameProvider.gameCards[widget.cardIndex].flipCardController = _controller;
    return ValueListenableBuilder<bool>(
        valueListenable: enableFlipping,
        builder: (context, enableFlipping, child) {
          return GestureDetector(
            onTap: () async {
              if (enableFlipping &&
                  !gameProvider.gameCards[widget.cardIndex].isEliminated) {
                await handleOnTap(context);
              }
            },
            child: FlipCard(
              controller: _controller,
              flipOnTouch: false,
              fill: Fill.fillBack,
              direction: FlipDirection.HORIZONTAL,
              side: _cardSide,
              front: Card(
                color: getCardColor(true),
                elevation: 4.0,
                child: Center(
                  child: Text(
                    _frontText,
                    style: AppConfigs.selectionStageCardTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              back: Card(
                color: getCardColor(false),
                elevation: 4.0,
                child: Center(
                  child: Text(
                    _backText,
                    style: AppConfigs.selectionStageCardTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          );
        });
  }

  Color getCardColor(bool isFrontFace) {
    if (isFrontFace) {
      if (_isCardSelected) {
        return AppConfigs.selectedCardColor;
      }
    } else if (widget.isImposterCard) {
      return AppConfigs.imposterCardColor;
    }

    return AppConfigs.cardColor;
  }

  Future<void> handleOnTap(BuildContext context) async {
    final gameProvider = context.read<GameProvider>();

    if (gameProvider.currentGameStage == GameStageEnum.selectionStage) {
      if (flipCount == 0 &&
          gameProvider.gameCards[widget.cardIndex].playerName.isEmpty) {
        String? username = await enterPlayName(context);
        if (username == null) {
          return;
        } else {
          gameProvider.gameCards[widget.cardIndex].playerName = username;
        }
      }

      flipCount++;
      if (flipCount >= 2) {
        enableFlipping.value = false;
        _frontText =
            "${gameProvider.gameCards[widget.cardIndex].playerName} has Selected This Card🔒";
        _isCardSelected = true;
        widget.handleCompleteCardSelection();
        if (gameProvider.currentGameStage == GameStageEnum.playStage) {
          widget.startRound();
        }
      }
    } else if (gameProvider.currentGameStage == GameStageEnum.playStage) {
      gameProvider.handleGameCardVoting(context, widget.cardIndex);
      setState(() {
        gameProvider.gameCards[widget.cardIndex].isEliminated = true;
      });
    }

    _controller.toggleCard();
  }

  Future<String?> enterPlayName(BuildContext context) async {
    String? username = await GameDialogs.showUserNameDialog(context);
    return username;
  }
}
