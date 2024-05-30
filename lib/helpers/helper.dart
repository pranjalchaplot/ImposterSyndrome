import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Helper {
  static ElevatedButton getHomeScreenButton(
      VoidCallback onPressed, String buttonText, IconData icon) {
    return ElevatedButton(
      onPressed: onPressed,
      style: const ButtonStyle(
        backgroundColor: WidgetStateColor.transparent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            buttonText,
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(
              fontWeight: FontWeight.w800,
              fontStyle: FontStyle.italic,
              color: Colors.redAccent,
            )),
          ),
          const SizedBox(
            width: 10,
          ),
          Icon(
            icon,
            color: Colors.redAccent,
          ),
        ],
      ),
    );
  }
}
