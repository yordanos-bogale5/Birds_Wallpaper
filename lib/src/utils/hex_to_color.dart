import 'package:flutter/material.dart';

Color hexToColor(String hex) {
  try {
    // Remove the leading '#' if present
    hex = hex.replaceAll('#', '');

    // If the hex code is 6 characters long, add 'FF' for full opacity
    if (hex.length == 6) {
      hex = 'FF$hex';
    }

    // Parse the hex code to integer and create a Color object
    return Color(int.parse(hex, radix: 16));
  } catch (e) {
    // Handle any exceptions and return a default color
    print('Invalid hex color: $e');
    return Colors.white;
  }
}