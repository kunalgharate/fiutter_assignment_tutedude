import 'package:flutter/material.dart';

class GenderTheme {
  static const maleTheme = {
    'activeCard': Color(0xFF4AE1DD), // Teal from male icon
    'inactiveCard': Color(0xFF2A4A4D), // Darker teal
    'accent': Color(0xFF4AE1DD),
    'button': Color(0xFF4AE1DD),
    'background': Color(0xFF1A3A3D), // Dark teal background
  };

  static const femaleTheme = {
    'activeCard': Color(0xFFFE719E), // Pink from female icon
    'inactiveCard': Color(0xFF4D2A3A), // Darker pink
    'accent': Color(0xFFFE719E),
    'button': Color(0xFFFE719E),
    'background': Color(0xFF3D1A2A), // Dark pink background
  };

  static const defaultTheme = {
    'activeCard': Color(0xFF1D1E33),
    'inactiveCard': Color(0xFF111328),
    'accent': Color(0xFFEB1555),
    'button': Color(0xFFEB1555),
    'background': Color(0xFF0A0E21),
  };

  static Map<String, Color> getTheme(String? gender) {
    switch (gender) {
      case 'male':
        return maleTheme;
      case 'female':
        return femaleTheme;
      default:
        return defaultTheme;
    }
  }
}
