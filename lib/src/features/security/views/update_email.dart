import 'dart:developer';

import 'package:chatremedy/src/features/authorization/provider/user_provider.dart';
import 'package:chatremedy/src/features/authorization/widgets/text_form_field.dart';
import 'package:chatremedy/src/features/security/providers/reset_email.dart';
import 'package:chatremedy/src/features/security/providers/update_email_provider.dart';
import 'package:chatremedy/src/utils/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/colors.dart';
import '../../../utils/show_loader_dialog.dart';
import '../../authorization/views/verification_screen.dart';

class UpdateEmail extends ConsumerStatefulWidget {
  const UpdateEmail({super.key});

  @override
  ConsumerState<UpdateEmail> createState() => _UpdateEmailState();
}

class _UpdateEmailState extends ConsumerState<UpdateEmail> {
  final confirmEmail = TextEditingController();
  final newEmail = TextEditingController();

  bool obscurePassword = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
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
                      "Update Email",
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text("Current Email: ${user.user!.email}"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          backgroundColor: AppColors.formFieldColor,
                          SVG: AppSvg.email,
                          hintText: "New Email",
                          controller: newEmail,
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              return "Enter new email";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                            backgroundColor: AppColors.formFieldColor,
                            SVG: AppSvg.lock,
                            hintText: "Confirm Email",
                            autofillHints: const [AutofillHints.email],
                            validator: (String? val) {
                              if (val!.isEmpty) {
                                return "Enter Email";
                              } else if (val != newEmail.text) {
                                return "Email doesn't match with new email";
                              }
                              return null;
                            },
                            controller: confirmEmail),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            updateEmail();
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
                              "Update Email",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )))
          ],
        ),
      ),
    );
  }

  updateEmail() async {
    final user = ref.watch(userProvider);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    showLoaderDialog(context);
    log("update Email ${newEmail.text} $token");
    updateEmailProvider(
      user.user!.email!,
      newEmail.text,
      token ?? "",
      context,
    ).then((value) async {
      if (value != null) {
        final val = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    VerificationScreen(code: (value['token'].toString()))));

        if (val == true) {
          resetEmail(user.user!.email!, newEmail.text,
                  value['token'].toString(), token ?? "", context)
              .then((response) {
            ref.read(userProvider.notifier).updateEmail(newEmail.text);
            Navigator.pop(context);
            Navigator.pop(context);
          });
        } else {
          Navigator.pop(context);
        }
      } else {
        Navigator.pop(context);
      }
    });
  }
}
