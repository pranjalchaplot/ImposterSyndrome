import 'package:flutter/material.dart';

class AppConfigs {
  static const String imposterString = "IMPOSTER";
  static const String teamNameString = "CREWMATE";
  static LinearGradient gameBackgroundGradient = const LinearGradient(
    colors: [
      Color.fromARGB(255, 0, 0, 0), // Start color
      Color.fromARGB(217, 128, 0, 0), // End color
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static TextStyle selectionStageCardTextStyle = const TextStyle(
    fontFamily: 'ITCBenguiat',
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static Color cardColor = Colors.white;
  static Color selectedCardColor = const Color.fromARGB(255, 61, 101, 143);
  static Color eliminatedCardColor = const Color.fromARGB(255, 137, 137, 137);
  static Color imposterCardColor = Colors.red;

  static Duration popupDisplayDelay = const Duration(seconds: 1);

  static PreferredSize getAppBar(double statusBarHeight, bool showLogo) {
    return PreferredSize(
      preferredSize: Size.fromHeight(statusBarHeight + 100),
      child: AppBar(
        flexibleSpace: Container(
          padding: EdgeInsets.only(top: statusBarHeight),
          height: 300 + statusBarHeight,
          width: double.infinity,
          child: showLogo
              ? Image.asset(
                  'assets/images/game_logo_removed_bg.png',
                  fit: BoxFit.cover,
                )
              : null,
        ),
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        centerTitle: true,
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50),
          ),
        ),
      ),
    );
  }

  static int getRoundDuration(String roundLength) {
    switch (roundLength) {
      case '30 seconds':
        return 30;
      case '1 minute':
        return 60;
      case '2 minutes':
        return 120;
      default:
        return 30;
    }
  }
}
