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

  static LinearGradient cardGradientColor = const LinearGradient(
    colors: [
      Color.fromARGB(255, 255, 255, 255), // Start color
      Color.fromARGB(217, 239, 243, 239), // End color
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient viewCardGradientColor = const LinearGradient(
    colors: [
      Color.fromARGB(255, 167, 241, 83),
      Color.fromARGB(255, 96, 244, 55)
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient lockedCardGradientColor = const LinearGradient(
    colors: [
      Color.fromARGB(144, 0, 0, 0),
      Color.fromARGB(144, 30, 30, 30),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient imposterCardGradientColor = const LinearGradient(
    colors: [
      Colors.red,
      Color.fromARGB(255, 195, 118, 118),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient eliminatedCardGradientColor = const LinearGradient(
    colors: [
      Color.fromARGB(144, 46, 46, 46),
      Color.fromARGB(144, 81, 64, 64),
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
  static Color selectedCardColor = const Color.fromARGB(255, 99, 216, 105);
  static Color eliminatedCardColor = const Color.fromARGB(255, 137, 137, 137);
  static Color imposterCardColor = Colors.red;
  static Color viewStageCardColor = const Color.fromARGB(255, 108, 174, 206);
  static Color warningGreenSnackBarBG = Colors.green.shade400.withOpacity(0.6);
  static Duration popupDisplayDelay = const Duration(seconds: 1);

  static SnackBar flipSelfCardWarning() {
    return SnackBar(
      content: const Text(
        "Fold Your Card After Seeing🙏",
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: warningGreenSnackBarBG,
    );
  }

  static Text getBannerWidgetText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),
    );
  }

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
