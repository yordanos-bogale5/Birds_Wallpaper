import 'dart:developer';

import 'package:chatremedy/src/features/authorization/provider/user_provider.dart';
import 'package:chatremedy/src/features/profile/provider/logout.dart';
import 'package:chatremedy/src/features/security/providers/delete_account_provider.dart';
import 'package:chatremedy/src/utils/colors.dart';
import 'package:chatremedy/src/utils/show_loader_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteAccountDialog extends ConsumerWidget {
  const DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return AlertDialog(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      actionsPadding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      titlePadding: const EdgeInsets.only(left: 15, right: 15, top: 15),
      title: const Text(
        "Are you sure?",
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 10),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              final token = prefs.getString("token");
              showLoaderDialog(context);
              await deleteUser(token ?? "", '${user.user!.email}', context)
                  .then((val) {
                log("valll $val");

                if (val) {
                  logOut(context, ref);
                } else {
                  Navigator.pop(context);
                }
              });
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              child: const Text(
                "Delete Account",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
      actions: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.hintColor),
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            child: const Text(
              "Cancel",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
