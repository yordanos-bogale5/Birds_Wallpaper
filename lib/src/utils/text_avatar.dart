import 'package:chatremedy/src/utils/get_text_color_based_on_background.dart';
import 'package:flutter/material.dart';

String getInitials(String fullName) {
  try {
    // Split the name by spaces and filter out any empty parts
    List<String> nameParts = fullName.trim().split(' ').where((part) => part.isNotEmpty).toList();

    // Extract initials from the first two words only, if available
    String initials = nameParts.take(2).map((part) => part[0].toUpperCase()).join();

    return initials;
  } catch (e) {
    // Handle any exceptions gracefully
    print('Error extracting initials: $e');
    return '';
  }
}

class TextAvatar extends StatelessWidget {
  final double size;
  final BoxShape shape;
  final String text;
  final double fontSize;
  final Color color;
  const TextAvatar(
      {super.key,
      required this.shape,
      required this.size,
      required this.text,
      required this.fontSize,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(shape: shape, color: color),
      child: Text(
        getInitials(text),
        style: TextStyle(fontSize: fontSize, color: getTextColorBasedOnBackground(color)),
      ),
    );
  }
}
