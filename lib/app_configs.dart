import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppConfigs {
  static const String imposterString = "IMPOSTER";
  static const String teamNameString = "CREWMATE";

  static const int playerLobbyMinSize = 4;
  static const int playerLobbyMaxSize = 6;

  static const EdgeInsetsGeometry gridPadding = EdgeInsets.all(15.0);
  static const SliverGridDelegateWithFixedCrossAxisCount gridDelegate =
      SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 9.6,
    crossAxisSpacing: 9.6,
    childAspectRatio: 0.69,
  );

  static RadialGradient popUpDisplayGradient = const RadialGradient(
    colors: [
      Color.fromARGB(255, 52, 120, 54),
      Color.fromARGB(255, 69, 69, 69),
    ],
    // begin: Alignment.topLeft,
    // end: Alignment.bottomRight,
    focal: Alignment.center,
    tileMode: TileMode.decal,
    radius: 4,
  );

  static LinearGradient gameBackgroundGradient = const LinearGradient(
    colors: [
      Color.fromARGB(255, 0, 0, 0),
      Color.fromARGB(217, 128, 0, 0),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient cardGradientColor = const LinearGradient(
    colors: [
      Color.fromARGB(100, 76, 175, 79),
      Color.fromARGB(100, 101, 197, 104),
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
      Colors.redAccent,
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

  static TextStyle playStageCardFrontTextStyle = GoogleFonts.ubuntu(
      textStyle: const TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ));

  static TextStyle selectionStageFrontCardTextStyle = const TextStyle(
    fontFamily: 'ITCBenguiat',
    fontSize: 90,
    fontWeight: FontWeight.bold,
  );

  static Color cardColor = Colors.white;
  static Color selectedCardColor = const Color.fromARGB(255, 99, 216, 105);
  static Color eliminatedCardColor = const Color.fromARGB(255, 137, 137, 137);
  static Color imposterCardColor = Colors.red;
  static Color viewStageCardColor = const Color.fromARGB(255, 108, 174, 206);
  static Color warningSnackBarBG = Colors.black;
  static Duration popupDisplayDelay = const Duration(seconds: 1);

  static const TextStyle popUpDisplayButtonTS = TextStyle(
    color: Colors.greenAccent,
  );

  static const TextStyle popUpDisplayTitleTS = TextStyle(
    color: Colors.greenAccent,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
    fontSize: 22,
  );

  static const TextStyle popUpDisplayMenuTS = TextStyle(
    color: Colors.greenAccent,
    fontSize: 20,
  );

  static SnackBar flipSelfCardWarning() {
    return warningSnackBar("Fold Your Card After Seeing🙏");
  }

  static SnackBar flipEliminatedCardWarning() {
    return warningSnackBar("Vote Other Card");
  }

  static SnackBar flipSelectedCardWarning() {
    return warningSnackBar("Select Other Card");
  }

  static SnackBar warningSnackBar(String text) {
    return SnackBar(
      content: Text(
        text,
        style: GoogleFonts.pottaOne(
          textStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        textAlign: TextAlign.center,
      ),
      duration: const Duration(seconds: 1),
      backgroundColor: warningSnackBarBG,
    );
  }

  static Text getBannerWidgetText(String text) {
    return Text(text,
        style: GoogleFonts.archivo(
          textStyle: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 22.0,
            fontWeight: FontWeight.w900,
          ),
        ));
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
