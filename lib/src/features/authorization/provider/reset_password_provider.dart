import 'dart:convert';
import 'dart:developer';
import 'package:chatremedy/src/utils/base_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../utils/toast_widget.dart';

Future<void> resetPassword(String email, String password,
    String passwordConfirm, String token, BuildContext context) async {
  const String apiUrl = '${baseUrl}resetPassword';

  // Body of the request
  Map<String, dynamic> requestBody = {
    "email": email,
    "password": password,
    "passwordConfirm": passwordConfirm,
    "token": token,
  };

  // Encoding the request body as JSON
  String jsonBody = jsonEncode(requestBody);

  try {
    // Making the POST request
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonBody,
    );

    // Checking response status
    if (response.statusCode == 200) {
      CustomToast.success(
          context, "Password Updated", "Password updated successfully");
    } else {
      // Password reset failed
      log('Failed to reset password. Status code: ${response.statusCode}');
      log('Response body: ${response.body}');
      CustomToast.errorToast(context, "Failed to reset password",
          "Error: ${jsonDecode(response.body)['message']}");
    }
  } catch (e) {
    // Error occurred
    log('Error occurred: $e');
  }
}
