import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/colors.dart';
import '../../../utils/svg.dart';

class ProfileTile extends StatelessWidget {
  final String svg;
  final String title;
  final Function()? onTap;
  const ProfileTile(
      {super.key, required this.svg, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.circle),
            padding: const EdgeInsets.all(12),
            height: 40,
            width: 40,
            child: SvgPicture.asset(
              svg,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
                if (title == "Support")
                  const Text(
                    "Contact US  for supoort",
                    style: TextStyle(
                        fontSize: 12,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500),
                  ),
              ],
            ),
          ),
          SvgPicture.asset(
            AppSvg.arrowForward,
            width: 16,
            height: 16,
          )
        ],
      ),
    );
  }
}
