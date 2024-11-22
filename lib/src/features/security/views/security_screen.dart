import 'package:chatremedy/src/features/security/views/update_email.dart';
import 'package:chatremedy/src/features/security/views/update_password.dart';
import 'package:chatremedy/src/features/security/widget/delete_account_dialog.dart';
import 'package:chatremedy/src/features/security/widget/security_tile.dart';
import 'package:chatremedy/src/features/wallet/widgets/card_tile.dart';
import 'package:chatremedy/src/utils/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/colors.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                    "Security",
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Manage your security settings",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SecurityTile(
                        svg: AppSvg.lock,
                        title: "Update Password",
                        svgColor: AppColors.primaryColor,
                        onTap: () => Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                const UpdatePassword(),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                          // MaterialPageRoute(
                          //     builder: (context) => const UpdatePassword())
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SecurityTile(
                        svg: AppSvg.emailAt,
                        title: "Update Email",
                        onTap: () => Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                const UpdateEmail(),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                          // MaterialPageRoute(
                          //     builder: (context) => const UpdateEmail())
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SecurityTile(
                        svg: AppSvg.delete,
                        title: "Delete Account",
                        textColor: Colors.red,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const DeleteAccountDialog();
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )))
        ],
      ),
    );
  }
}
