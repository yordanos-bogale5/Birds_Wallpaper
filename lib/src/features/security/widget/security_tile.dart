import 'package:chatremedy/src/utils/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SecurityTile extends StatelessWidget {
  final String svg;
  final String title;
  final Color? svgColor;
  final Color? textColor;
  final Function()? onTap;
  const SecurityTile(
      {super.key,
      required this.svg,
      required this.title,
      this.onTap,
      this.svgColor,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap??() {},
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1), shape: BoxShape.circle),
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              svg,
              color: svgColor,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
          )),
          SvgPicture.asset(AppSvg.arrowForward)
        ],
      ),
    );
  }
}
