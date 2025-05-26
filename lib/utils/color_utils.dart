import 'package:flutter/material.dart';

class ColorUtils {
  static const Color primaryColor = Color(0xFFF92772);
  static const Color backgroundNotice = Color(0xFFFFEAEF);
  static const Color lightBackgroundSM = Color(0xFFFFF8FB);
  static const Color blueColorSM = Color(0xFF2ABED8);

  static const MaterialColor backgroundSM = MaterialColor(
    0xFFF92772,
    <int, Color>{
      50: Color(0xFFFFE5ED),
      100: Color(0xFFFFB8CE),
      200: Color(0xFFFF8AB0),
      300: Color(0xFFFF5D91),
      400: Color(0xFFFF3F7E),
      500: Color(0xFFF92772), // primary
      600: Color(0xFFE02068),
      700: Color(0xFFCA1B5D),
      800: Color(0xFFB51652),
      900: Color(0xFF8D0E3F),
      950: Color(0xFF47051D),
    },
  );
  static const List<Color> gradientPrimaryColor = [
    Color(0xFFF92772),
    Colors.white,
  ];

  static const Color cameraBgColor = Color(0xFFFFF7F9);
  static const Color titleAppbarColor = Color(0xFF47051D);
  static const Color modeSkinHealth = Color(0xFFE9762E);
  static const Color borderTextField = Color(0xFFFFC7D5);
  static const Color hintTextField = Color(0xFFC0AAB4);

  static const Map<int, Color> neutral = {
    100: Color(0xFFF5F5F5),
    200: Color(0xFFE5E5E5),
    300: Color(0xFFD4D4D4),
    400: Color(0xFFA3A3A3),
    500: Color(0xFF737373),
    600: Color(0xFF525252),
    700: Color(0xFF404040),
    800: Color(0xFF262626),
    900: Color(0xFF171717),
    950: Color(0xFF0A0A0A),
  };
}
