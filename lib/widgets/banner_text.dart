import 'package:flutter/material.dart';
import 'package:imposter_syndrome_game/app_configs.dart';
import 'package:provider/provider.dart';
import 'package:imposter_syndrome_game/providers/game_provider.dart';

import '../models/enums/game_stage_enum.dart';

class BannerText extends StatelessWidget {
  const BannerText({super.key});

  @override
  Widget build(BuildContext context) {
    final gameProvider = context.watch<GameProvider>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AppConfigs.getBannerWidgetText(getBannerText(gameProvider)),
    );
  }

  String getBannerText(GameProvider gameProvider) {
    if (gameProvider.currentGameStage == GameStageEnum.selectionStage) {
      if (gameProvider.lockCards) {
        return "Fold Your Card After Seeing!";
      }
      return "Select Your Card";
    } else if (gameProvider.currentGameStage == GameStageEnum.playStage) {
      return 'Vote The Imposter ${(gameProvider.secondsRemaining > 0 ? "in ${gameProvider.secondsRemaining} seconds" : "Now")}';
    }

    return "Focus On Your Card";
  }
}
