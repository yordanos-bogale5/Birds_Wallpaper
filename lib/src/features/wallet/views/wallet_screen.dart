import 'package:chatremedy/src/features/wallet/widgets/card_tile.dart';
import 'package:chatremedy/src/utils/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../model/card/card_model.dart';
import '../../../utils/colors.dart';

class WalletScreen extends StatelessWidget {
  WalletScreen({super.key});

  final List<CardModel> cards = [
    CardModel(
        id: "randomID",
        type: "Visa",
        number: "4242424242424242",
        expiry: DateTime(2028, 08, 25)),
    CardModel(
        id: "randomID",
        type: "Mastercard",
        number: "1234567890123456",
        expiry: DateTime(2028, 08, 25)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          SizedBox(height: 50,),
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            shape: BoxShape.circle),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        margin: const EdgeInsets.only(right: 20),
                        child: SvgPicture.asset(AppSvg.arrowBack)),
                  ),
                  const Text(
                    "Wallet",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              )),
          Expanded(
              child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20))),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Payment Cards",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                          itemCount: cards.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return CardTile(cardModel: cards[index]);
                          })
                    ],
                  )))
        ],
      ),
    );
  }
}
