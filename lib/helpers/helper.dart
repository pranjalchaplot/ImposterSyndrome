import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imposter_syndrome_game/app_configs.dart';

class Helper {
  static ElevatedButton getHomeScreenButton(
      VoidCallback onPressed, String buttonText, IconData icon) {
    return ElevatedButton.icon(
      icon: Icon(
        icon,
        color: Colors.redAccent,
      ),
      onPressed: onPressed,
      style: const ButtonStyle(
        backgroundColor: WidgetStateColor.transparent,
      ),
      label: Text(
        buttonText,
        style: GoogleFonts.poppins(
            textStyle: const TextStyle(
          fontWeight: FontWeight.w800,
          fontStyle: FontStyle.italic,
          color: Colors.redAccent,
        )),
      ),
    );
  }

  static String getShareableText(
      bool isImposterWin, int imposterIndex, List<String> allPlayerNames) {
    String imposterPlayerName = allPlayerNames[imposterIndex];
    allPlayerNames.removeAt(imposterIndex);

    String allPlayerNamesStr = allPlayerNames.join(", ");
    if (isImposterWin) {
      return "$imposterPlayerName (${AppConfigs.imposterString}) defeated $allPlayerNamesStr (${AppConfigs.teamNameString})";
    }

    return "$allPlayerNamesStr (${AppConfigs.teamNameString}) defated $imposterPlayerName (${AppConfigs.imposterString})";
  }
}
