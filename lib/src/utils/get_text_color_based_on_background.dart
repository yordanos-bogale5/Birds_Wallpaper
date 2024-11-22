import 'package:flutter/material.dart';

Color getTextColorBasedOnBackground(Color backgroundColor) {
  // Determine the brightness of the background color
  Brightness brightness = ThemeData.estimateBrightnessForColor(backgroundColor);

  // Choose the text color based on brightness
  Color textColor = brightness == Brightness.dark ? Colors.white : Colors.black;

  return textColor;
}