import 'package:flutter/material.dart';

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0))),
    content: Row(
      children: [
        const CircularProgressIndicator(),
        Container(
            margin: const EdgeInsets.only(left: 7),
            child: const Text("Loading...")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
