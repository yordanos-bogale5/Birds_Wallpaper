import 'package:chatremedy/src/features/authorization/widgets/text_form_field.dart';
import 'package:chatremedy/src/features/security/providers/update_password_provider.dart';
import 'package:chatremedy/src/utils/show_loader_dialog.dart';
import 'package:chatremedy/src/utils/svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/colors.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final password = TextEditingController();
  final newPassword = TextEditingController();
  final confirmNewPassword = TextEditingController();

  bool obscurePassword = true;
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                      "Update Password",
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
                        CustomTextFormField(
                          backgroundColor: AppColors.formFieldColor,
                          SVG: AppSvg.lock,
                          hintText: "Current Password",
                          controller: password,
                          obscureText: obscurePassword,
                          autofillHints: const [AutofillHints.password],
                          suffixWidget: InkWell(
                            onTap: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                            child: Icon(
                              obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey.withOpacity(0.8),
                            ),
                          ),
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              return "Enter Current Password";
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
                          hintText: "New Password",
                          controller: newPassword,
                          obscureText: obscureNewPassword,
                          autofillHints: const [AutofillHints.newPassword],
                          suffixWidget: InkWell(
                            onTap: () {
                              setState(() {
                                obscureNewPassword = !obscureNewPassword;
                              });
                            },
                            child: Icon(
                              obscureNewPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey.withOpacity(0.8),
                            ),
                          ),
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              return "Enter New Password";
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
                          hintText: "Confirm New Password",
                          autofillHints: const [AutofillHints.newPassword],
                          obscureText: obscureConfirmPassword,
                          controller: confirmNewPassword,
                          suffixWidget: InkWell(
                            onTap: () {
                              setState(() {
                                obscureConfirmPassword =
                                    !obscureConfirmPassword;
                              });
                            },
                            child: Icon(
                              obscureConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey.withOpacity(0.8),
                            ),
                          ),
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              return "Enter New Password";
                            } else if (val != newPassword.text) {
                              return "Password doesn't match with new password";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              updatePassword();
                            }
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
                              "Update Password",
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

  updatePassword() {
    showLoaderDialog(context);
    updatePasswordProvider(password.text, newPassword.text, context)
        .then((value) {
      password.clear();
      newPassword.clear();
      confirmNewPassword.clear();
      Navigator.pop(context);
      Navigator.pop(context);
    });
  }
}
