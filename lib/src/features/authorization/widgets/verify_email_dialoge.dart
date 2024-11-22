import 'package:flutter/material.dart';

class VerifyEmailDialog extends StatelessWidget {
  final String email;
  const VerifyEmailDialog({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      actionsPadding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      titlePadding: const EdgeInsets.only(left: 15, right: 15, top: 15),
      title: const Text(
        "Verify your email",
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 50),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Please verify your email address by clicking the link sent to $email",
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
