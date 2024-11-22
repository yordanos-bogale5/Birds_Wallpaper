import 'package:chatremedy/src/model/card/card_model.dart';
import 'package:chatremedy/src/utils/svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../utils/colors.dart';

class CardTile extends StatelessWidget {
  final CardModel cardModel;
  const CardTile({super.key, required this.cardModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.formFieldColor,
          borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset(
                AppSvg.wallet,
                width: 24,
              )),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${cardModel.type} **** ${getLast4Digits(cardModel.number.toString())}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  DateFormat("MM/yyyy").format(cardModel.expiry!),
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.hintColor),
                ),
              ],
            ),
          ),
          SvgPicture.asset(AppSvg.delete)
        ],
      ),
    );
  }

  String getLast4Digits(String cardNumber) {
    if (cardNumber.length >= 4) {
      return cardNumber.substring(cardNumber.length - 4);
    } else {
      return cardNumber; // If the card number is shorter than 4 digits, return it as it is
    }
  }
}
