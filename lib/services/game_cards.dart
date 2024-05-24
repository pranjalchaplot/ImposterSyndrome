import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:imposter_syndrome_game/app_configs.dart';
import 'package:imposter_syndrome_game/models/enums/game_stage_enum.dart';

class GameCardVM extends StatefulWidget {
  final String frontText;
  final String backText;
  final int cardIndex;
  final bool isEliminated;
  final bool isImposterCard;
  final GameStageEnum currentGameStage;
  final VoidCallback handleCompleteCardSelection;
  final Function(int) handleGameCardVoting;

  const GameCardVM({
    super.key,
    required this.frontText,
    required this.backText,
    required this.isEliminated,
    required this.isImposterCard,
    required this.currentGameStage,
    required this.handleCompleteCardSelection,
    required this.handleGameCardVoting,
    required this.cardIndex,
  });

  @override
  State<GameCardVM> createState() => _GameCardVMState();
}

class _GameCardVMState extends State<GameCardVM> {
  int flipCount = 0;
  bool enableFlipping = true;
  String _frontText = "";
  String _backText = "";

  @override
  void initState() {
    super.initState();
    flipCount = 0;
    enableFlipping = !widget.isEliminated;
    _frontText = widget.frontText;
    _backText = widget.backText;
  }

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      flipOnTouch: enableFlipping,
      fill: Fill.fillBack,
      onFlip: () {
        handleOnFlip();
      },
      direction: FlipDirection.HORIZONTAL,
      side: CardSide.FRONT,
      front: Card(
        color: AppConfigs.cardColor,
        elevation: 4.0,
        child: Center(
          child: Text(
            _frontText,
            style: AppConfigs.textStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      back: Card(
        color: widget.isImposterCard
            ? AppConfigs.imposterCardColor
            : AppConfigs.cardColor,
        elevation: 4.0,
        child: Center(
          child: Text(
            _backText,
            style: AppConfigs.textStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  void handleOnFlip() {
    if (widget.currentGameStage == GameStageEnum.selectionStage) {
      setState(() {
        flipCount++;
        if (flipCount >= 2) {
          enableFlipping = false;
          _frontText = "Card Has Been Selected🔒";
          widget.handleCompleteCardSelection();
          if (widget.currentGameStage == GameStageEnum.playStage) {
            flipCount = 0;
            enableFlipping = true;
          }
        }
      });
    } else if (widget.currentGameStage == GameStageEnum.playStage) {
      widget.handleGameCardVoting(widget.cardIndex);
    }
  }
}
