import 'dart:developer';

import 'package:chatremedy/src/features/authorization/provider/login_provider.dart';
import 'package:chatremedy/src/features/authorization/provider/user_provider.dart';
import 'package:chatremedy/src/features/authorization/views/forgot_password_screen.dart';
import 'package:chatremedy/src/features/authorization/widgets/text_form_field.dart';
import 'package:chatremedy/src/features/splash_screen/view/welcome_screen.dart';
import 'package:chatremedy/src/features/terms_and_conditions/terms_and_conditions.dart';
import 'package:chatremedy/src/notification_service/notification_service.dart';
import 'package:chatremedy/src/utils/colors.dart';
import 'package:chatremedy/src/utils/email_validator.dart';
import 'package:chatremedy/src/utils/show_loader_dialog.dart';
import 'package:chatremedy/src/utils/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../l10n/generated/l10n.dart';
import '../../../model/user_data/user_data.dart';
import '../../../utils/images.dart';
import '../../terms_and_conditions/privacy_policy.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;

  bool email = false, password = false;

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
                  height: MediaQuery.sizeOf(context).height * 0.48,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                width: double.infinity,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Colors.white),
                child: AutofillGroup(
                  child: Column(
                    children: [
                      const Text(
                        "Login",
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
                        onChanged: (String? v) {
                          setState(() {
                            email = false;
                          });
                        },
                        controller: emailController,
                        textInputType: TextInputType.emailAddress,
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return "Enter email";
                          } else if (email) {
                            return "No user registered with this email.";
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
                        autofillHints: const [AutofillHints.password],
                        obscureText: obscurePassword,
                        controller: passwordController,
                        onChanged: (String? v) {
                          setState(() {
                            password = false;
                          });
                        },
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return "Enter password";
                          } else if (password) {
                            return "Invalid Password";
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          const ForgotPasswordScreen(),
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
                                ),
                                // MaterialPageRoute(
                                //     builder: (context) =>
                                //         const ForgotPasswordScreen())
                              );
                            },
                            child: const Text(
                              "Forgot Password",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      GestureDetector(
                        onTap: () {
                          TextInput.finishAutofillContext(shouldSave: true);
                          login();
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
                            "Login",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                                          const TermsAndConditions(),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle tStyle(FontWeight? fontWeight) {
    return TextStyle(fontSize: 8, fontWeight: fontWeight ?? FontWeight.normal);
  }

  Future<void> login() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (formKey.currentState!.validate()) {
      showLoaderDialog(context);
      loginProvider(emailController.text, passwordController.text, context)
          .then((value) {
        if (value == null) {
        } else {
          log("Login Result $value");
          if (value['status'] == "Success") {
            final user = UserData.fromJson(value['data']);
            Navigator.pop(context);
            prefs.setBool("loggedIn", true);
            prefs.setString("token", user.token ?? "");

            ref.read(userProvider.notifier).change(user);
            NotificationService().cancelNotifications();
            Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const WelcomeScreen(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
                // MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                (route) => false);
          } else if (value['status'] == 'email') {
            setState(() {
              email = true;
            });
          } else if (value['status'] == 'password') {
            setState(() {
              password = true;
            });
          } else if (value['status'] == "locked") {
            showLockedAccountDialog(context);
          }
        }
      });
    }
  }

  void showLockedAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Account Locked'),
          content: const Text(
              'This Account is currently Locked. To Unlock please email support team.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
