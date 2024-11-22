import 'package:chatremedy/src/features/authorization/provider/verify_email.dart';
import 'package:chatremedy/src/features/authorization/views/selection_screen.dart';
import 'package:chatremedy/src/features/authorization/views/verification_screen.dart';
import 'package:chatremedy/src/features/authorization/widgets/text_form_field.dart';
import 'package:chatremedy/src/features/terms_and_conditions/privacy_policy.dart';
import 'package:chatremedy/src/features/terms_and_conditions/terms_and_conditions.dart';
import 'package:chatremedy/src/utils/colors.dart';
import 'package:chatremedy/src/utils/show_loader_dialog.dart';
import 'package:chatremedy/src/utils/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/generated/l10n.dart';
import '../../../notification_service/notification_service.dart';
import '../../../utils/email_validator.dart';
import '../../../utils/images.dart';
import '../../../utils/toast_widget.dart';
import '../provider/signup_provider.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final usernameController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool username = false;
  bool email = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
                onTap: () => Navigator.pop(context),
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.35,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
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
                height: MediaQuery.sizeOf(context).height * 0.65,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                width: double.infinity,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Colors.white),
                child: Column(
                  children: [
                    const Text(
                      "Sign up",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      backgroundColor: AppColors.formFieldColor,
                      SVG: AppSvg.user,
                      hintText: "Username",
                      controller: usernameController,
                      autofillHints: const [AutofillHints.newUsername],
                      onChanged: (String? val) {
                        setState(() {
                          username = false;
                        });
                      },
                      validator: (String? val) {
                        if (val!.isEmpty) {
                          return "Enter Username";
                        } else if (username) {
                          return "This username isn't available";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      backgroundColor: AppColors.formFieldColor,
                      SVG: AppSvg.email,
                      hintText: "Email",
                      controller: emailController,
                      autofillHints: const [AutofillHints.email],
                      onChanged: (String? v) {
                        setState(() {
                          email = false;
                        });
                      },
                      validator: (String? val) {
                        if (val!.isEmpty) {
                          return "Enter email";
                        } else if (email) {
                          return "Someone already registered this email address!";
                        } else if (isEmailValid(val)) {
                          return null;
                        } else {
                          return "Not a valid email";
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      backgroundColor: AppColors.formFieldColor,
                      SVG: AppSvg.lock,
                      hintText: "Password",
                      controller: passwordController,
                      obscureText: obscurePassword,
                      autofillHints: const [AutofillHints.newPassword],
                      validator: (String? val) {
                        if (val!.isEmpty) {
                          return "Enter password";
                        } else if (val.length < 8) {
                          return "Password should be at least 8 characters";
                        }
                        return null;
                      },
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
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      backgroundColor: AppColors.formFieldColor,
                      SVG: AppSvg.lock,
                      hintText: "Confirm Password",
                      controller: confirmPasswordController,
                      obscureText: obscureConfirmPassword,
                      autofillHints: const [AutofillHints.newPassword],
                      validator: (String? val) {
                        if (val!.isEmpty) {
                          return "Enter Password";
                        } else if (val != passwordController.text) {
                          return "Password does not match";
                        } else {
                          return null;
                        }
                      },
                      suffixWidget: InkWell(
                        onTap: () {
                          setState(() {
                            obscureConfirmPassword = !obscureConfirmPassword;
                          });
                        },
                        child: Icon(
                          obscureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey.withOpacity(0.8),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        signUp();
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
                          "Sign Up",
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
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        TermsAndConditions(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                              // MaterialPageRoute(
                              //     builder: (context) =>
                              //         const TermsAndConditions())
                            );
                          },
                          child: Text("Terms of Service",
                              style: tStyle(FontWeight.bold)),
                        ),
                        Text(" & ", style: tStyle(null)),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        const PrivacyPolicies(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                              // MaterialPageRoute(
                              //     builder: (context) =>
                              //         const PrivacyPolicies())
                            );
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
            ],
          ),
        ),
      ),
    );
  }

  TextStyle tStyle(FontWeight? fontWeight) {
    return TextStyle(fontSize: 9, fontWeight: fontWeight ?? FontWeight.normal);
  }

  Future<void> signUp() async {
    if (formKey.currentState!.validate()) {
      showLoaderDialog(context);
      signupProvider(usernameController.text, emailController.text,
              passwordController.text, context)
          .then((value) async {
        if (value == null) {
          Navigator.pop(context);
        } else if (value['status'] == "username") {
          setState(() {
            username = true;
          });
          Navigator.pop(context);
        } else if (value['status'] == "email") {
          setState(() {
            email = true;
          });
          Navigator.pop(context);
        } else {
          if (value['status'] == "Success") {
            CustomToast.success(context, "Account Created",
                "Verify your email to login into the app");
            NotificationService().cancelNotifications();
            final val = await Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                    VerificationScreen(code: (value['token'].toString())),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
              // MaterialPageRoute(
              //     builder: (context) =>
              //         VerificationScreen(code: (value['token'].toString())))
            );

            if (val == true) {
              verifyEmail(
                      value['token'].toString(), emailController.text, context)
                  .then((val) {
                if (val == null) {
                } else if (val['status'] == 'success') {
                  CustomToast.success(context, "Account Verified",
                      "Account verified successfully, you can login now");
                }
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        SelectionScreen(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                  // MaterialPageRoute(builder: (context) => SelectionScreen())
                );
              });
            } else {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      SelectionScreen(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
                // MaterialPageRoute(builder: (context) => SelectionScreen())
              );
            }
          }
        }
      });
    }
  }
}
