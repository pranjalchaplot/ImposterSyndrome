import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:imposter_syndrome_game/app_configs.dart';
import 'package:imposter_syndrome_game/models/enums/game_stage_enum.dart';
import 'package:imposter_syndrome_game/providers/game_provider.dart';
import 'package:imposter_syndrome_game/services/dialogs.dart';
import 'package:provider/provider.dart';

import '../widgets/face_card.dart';

class GameCardVM extends StatefulWidget {
  final String frontText;
  final String backText;
  final int cardIndex;
  final bool isEliminated;
  final bool isImposterCard;
  final VoidCallback startRound;

  const GameCardVM({
    super.key,
    required this.frontText,
    required this.backText,
    required this.isEliminated,
    required this.isImposterCard,
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
              if (gameProvider.gameCards[widget.cardIndex].isEliminated) {
                showSnackBar(AppConfigs.flipEliminatedCardWarning());
              } else if (enableFlipping) {
                await handleOnTap(context);
              }
            },
            child: FlipCard(
              controller: _controller,
              flipOnTouch: false,
              fill: Fill.fillBack,
              direction: FlipDirection.HORIZONTAL,
              side: _cardSide,
              front: FaceCard(
                faceText: _frontText,
                cardGradient: getCardFaceBG(true),
                isSelected: _isCardSelected,
                isFrontFace: true,
                cardIndex: widget.cardIndex,
              ),
              back: FaceCard(
                faceText: _backText,
                cardGradient: getCardFaceBG(false),
                isSelected: _isCardSelected,
                isFrontFace: false,
                cardIndex: widget.cardIndex,
              ),
            ),
          );
        });
  }

  LinearGradient getCardFaceBG(bool isFrontFace) {
    final gameProvider = context.read<GameProvider>();
    if (gameProvider.currentGameStage == GameStageEnum.selectionStage) {
      if (isFrontFace) {
        if (_isCardSelected) {
          return AppConfigs.lockedCardGradientColor;
        }
      } else {
        if (widget.isImposterCard) {
          return AppConfigs.imposterCardGradientColor;
        }
        if (flipCount >= 1) {
          return AppConfigs.viewCardGradientColor;
        }
      }
    } else if (gameProvider.currentGameStage == GameStageEnum.playStage) {
      if (isFrontFace) {
        if (_isCardSelected) {
          return AppConfigs.lockedCardGradientColor;
        }
      } else {
        if (widget.isImposterCard) {
          return AppConfigs.imposterCardGradientColor;
        }

        if (gameProvider.gameCards[widget.cardIndex].isEliminated) {
          return AppConfigs.eliminatedCardGradientColor;
        }
      }
    }

    return AppConfigs.cardGradientColor;
  }

  void showSnackBar(SnackBar snackBar) {
    ScaffoldMessenger.of(context).showSnackBar(
      snackBar,
    );
  }

  Future<void> handleOnTap(BuildContext context) async {
    final gameProvider = context.read<GameProvider>();

    if (gameProvider.lockCards &&
        gameProvider.currentSelectedCardIndex != widget.cardIndex) {
      showSnackBar(
        AppConfigs.flipSelfCardWarning(),
      );
      return;
    }

    if (gameProvider.currentGameStage == GameStageEnum.selectionStage) {
      if (flipCount == 0 &&
          gameProvider.gameCards[widget.cardIndex].playerName.isEmpty) {
        String? username = await enterPlayName(context);
        if (username == null) {
          return;
        } else {
          gameProvider.gameCards[widget.cardIndex].playerName = username;
          gameProvider.lockSelectionCards(widget.cardIndex);
        }
      }

      flipCount++;
      if (flipCount >= 2) {
        enableFlipping.value = false;
        _frontText =
            "${gameProvider.gameCards[widget.cardIndex].playerName} has Selected This Card🔒";
        _isCardSelected = true;
        gameProvider.unlockSelectionCards(widget.cardIndex);
        bool changeStage = gameProvider.handleCompleteCardSelection();
        if (changeStage) {
          Future.delayed(const Duration(milliseconds: 690), () {
            gameProvider.handleGameStageChange(GameStageEnum.playStage);
            widget.startRound();
          });
        }
      }
    } else if (gameProvider.currentGameStage == GameStageEnum.playStage) {
      gameProvider.handleGameCardVoting(
          context, widget.cardIndex, postElimination);
      setState(() {
        gameProvider.gameCards[widget.cardIndex].isEliminated = true;
      });
    }

    _controller.toggleCard();
  }

  void postElimination(GameProvider gameProvider) {
    setState(() {
      _backText =
          "${gameProvider.gameCards[widget.cardIndex].playerName} ELIMINATED!";
    });
  }

  Future<String?> enterPlayName(BuildContext context) async {
    String? username = await GameDialogs.showUserNameDialog(context);
    return username;
  }
}
