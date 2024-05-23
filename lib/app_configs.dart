import 'package:flutter/material.dart';

class AppConfigs {
  static const String imposterString = "IMPOSTER";
  static LinearGradient gameBackgroundGradient = const LinearGradient(
    colors: [
      Color.fromARGB(255, 0, 0, 0), // Start color
      Color.fromARGB(217, 128, 0, 0), // End color
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

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
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
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
}
