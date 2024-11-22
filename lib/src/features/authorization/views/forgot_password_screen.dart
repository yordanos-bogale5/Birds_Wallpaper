import 'dart:developer';

import 'package:chatremedy/src/features/authorization/provider/forgot_password_provider.dart';
import 'package:chatremedy/src/features/authorization/views/reset_password_screen.dart';
import 'package:chatremedy/src/features/authorization/views/verification_screen.dart';
import 'package:chatremedy/src/features/authorization/widgets/text_form_field.dart';
import 'package:chatremedy/src/features/terms_and_conditions/privacy_policy.dart';
import 'package:chatremedy/src/features/terms_and_conditions/terms_and_conditions.dart';
import 'package:chatremedy/src/utils/colors.dart';
import 'package:chatremedy/src/utils/email_validator.dart';
import 'package:chatremedy/src/utils/show_loader_dialog.dart';
import 'package:chatremedy/src/utils/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/generated/l10n.dart';
import '../../../utils/images.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final emailController = TextEditingController();

  bool email = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              onTap: () => Navigator.pop(context),
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.48,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 120),
                      child: Image(image: AssetImage(AppImages.logo)),
                    ),
                    Text(
                      Lt.of(context).title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.sizeOf(context).height * 0.52,
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
                        "Forgot Password",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        backgroundColor: AppColors.formFieldColor,
                        SVG: AppSvg.email,
                        hintText: "Email",
                        autofillHints: const [
                          AutofillHints.email,
                          AutofillHints.username
                        ],
                        controller: emailController,
                        textInputType: TextInputType.emailAddress,
                        onChanged: (String? val) {
                          setState(() {
                            email = false;
                          });
                        },
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return "Enter email";
                          } else if (email) {
                            return "User account doesn't exist!";
                          } else if (isEmailValid(val)) {
                            return null;
                          } else {
                            return "Not a valid email";
                          }
                        },
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      GestureDetector(
                        onTap: () {
                          submit();
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.primaryColor,
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "Submit",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Text(
                            "By using chatremedy, you agree to the ",
                            style: tStyle(null),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const TermsAndConditions()));
                            },
                            child: Text("Terms of Service",
                                style: tStyle(FontWeight.bold)),
                          ),
                          Text(" & ", style: tStyle(null)),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PrivacyPolicies()));
                            },
                            child: Text("Privacy Policy",
                                style: tStyle(FontWeight.bold)),
                          ),
                        ],
                      ),
                      Text("Powered by Chatremedy.com", style: tStyle(null)),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  TextStyle tStyle(FontWeight? fontWeight) {
    return TextStyle(fontSize: 9, fontWeight: fontWeight ?? FontWeight.normal);
  }

  Future<void> submit() async {
    showLoaderDialog(context);
    forgotPasswordProvider(
      context,
      emailController.text,
    ).then((value) async {
      Navigator.pop(context);
      if (value != null) {
        if (value['status'] == 'email') {
          setState(() {
            email = true;
          });
        } else {
          final val = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      VerificationScreen(code: (value['token'].toString()))));

          if (val == true) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ResetPassword(
                        email: emailController.text,
                        token: value['token'].toString())));
          }
        }
      }
    });
  }
}
