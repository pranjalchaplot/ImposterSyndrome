import 'package:flutter/material.dart';
import 'package:imposter_syndrome_game/app_configs.dart';
import 'package:imposter_syndrome_game/models/enums/game_stage_enum.dart';
import 'package:provider/provider.dart';

import '../providers/game_provider.dart';

class FaceCard extends StatefulWidget {
  const FaceCard({
    super.key,
    required String faceText,
    required LinearGradient cardGradient,
    required bool isSelected,
    required bool isFrontFace,
    required cardIndex,
  })  : _faceText = faceText,
        _cardGradient = cardGradient,
        _isSelected = isSelected,
        _isFrontFace = isFrontFace,
        _cardIndex = cardIndex;

  final String _faceText;
  final LinearGradient _cardGradient;
  final bool _isSelected;
  final bool _isFrontFace;
  final int _cardIndex;

  @override
  State<FaceCard> createState() => _FaceCardState();
}

class _FaceCardState extends State<FaceCard> {
  Widget getMainWidget(
      String playerName, bool isImposter, GameStageEnum currentStage) {
    if (currentStage == GameStageEnum.selectionStage) {
      if (widget._isFrontFace) {
        if (widget._isSelected) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Transform.rotate(
                    angle: 0.4,
                    child: SizedBox(
                        child: Image.asset(
                            'assets/images/selected_removed_bg.png',
                            opacity: const AlwaysStoppedAnimation(.69),
                            fit: BoxFit.cover))),
                const SizedBox(
                  height: 2,
                ),
                Text(playerName,
                    style: const TextStyle(
                      color: Color.fromARGB(193, 255, 255, 255),
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ))
              ]);
        }

        return Container(
          margin: const EdgeInsets.only(top: 20),
          child: Text(
            widget._faceText,
            style: AppConfigs.selectionStageFrontCardTextStyle,
          ),
        );
      }

      if (isImposter) {
        return Text(
          widget._faceText,
          style: AppConfigs.selectionStageImposterCardTextStyle,
          textAlign: TextAlign.center,
        );
      }
      return Text(
        widget._faceText,
        style: AppConfigs.selectionStageCardBackTextStyle,
        textAlign: TextAlign.center,
      );
    } else if (currentStage == GameStageEnum.playStage) {
      if (widget._isFrontFace) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                child: Text(
                  "🎯",
                  style: TextStyle(fontSize: 69),
                ),
              ),
              Text(
                widget._faceText,
                style: AppConfigs.playStageCardFrontTextStyle,
                textAlign: TextAlign.center,
              )
            ]);
      } else if (isImposter) {
        return Text(
          widget._faceText,
          style: AppConfigs.playStageImposterCardTextStyle,
          textAlign: TextAlign.center,
        );
      } else {
        return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                child: Icon(
                  Icons.block_flipped,
                  color: Colors.red,
                  size: 69,
                ),
              ),
              Text(widget._faceText,
                  style: const TextStyle(
                    color: Color.fromARGB(193, 255, 255, 255),
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ))
            ]);
      }
    }

    return Text(
      widget._faceText,
      style: AppConfigs.selectionStageFrontCardTextStyle,
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = context.read<GameProvider>();
    return Container(
      margin: const EdgeInsets.all(3),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        gradient: widget._cardGradient,
        borderRadius: BorderRadius.circular(13.0),
      ),
      child: Center(
        child: getMainWidget(
          gameProvider.gameCards[widget._cardIndex].playerName,
          gameProvider.imposterCardIndex == widget._cardIndex,
          gameProvider.currentGameStage,
        ),
      ),
    );
  }
}
