import 'package:chatremedy/src/utils/colors.dart';
import 'package:chatremedy/src/utils/toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/images.dart';

class VerificationScreen extends ConsumerStatefulWidget {
  final String code;

  const VerificationScreen({super.key, required this.code});

  @override
  ConsumerState<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends ConsumerState<VerificationScreen> {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          const SizedBox(
            height: 150,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 100),
            child: Image(image: AssetImage(AppImages.logo)),
          ),
          const SizedBox(
            height: 70,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              width: double.infinity,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Colors.white),
              child: SingleChildScrollView(
                child: AutofillGroup(
                  child: Column(
                    children: [
                      const Text(
                        "Verify your email",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "A verification has been sent to your email, enter that code here to verify.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      OtpTextField(
                        numberOfFields: 6,
                        borderColor: const Color(0xFF512DA8),
                        keyboardType: TextInputType.number,
                        //set to true to show as box or false to show as dash
                        showFieldAsBox: true,
                        //runs when a code is typed in
                        onCodeChanged: (String code) {
                          //handle validation or checks here
                        },
                        //runs when every textfield is filled
                        onSubmit: (String verificationCode) {
                          if (widget.code != verificationCode) {
                            Navigator.pop(context, false);
                            CustomToast.errorToast(
                                context, "Error Occurred", "Invalid Code");
                          } else {
                            Navigator.pop(context, true);
                          }

                        }, // end onSubmit
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.primaryColor,
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "Verify",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
