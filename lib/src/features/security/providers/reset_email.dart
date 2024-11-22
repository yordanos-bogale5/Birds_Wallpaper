import 'dart:convert';
import 'dart:developer';
import 'package:chatremedy/src/utils/base_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../utils/toast_widget.dart';

Future<void> resetEmail(
    String email, String newEmail, String token, String jwtToken, BuildContext context) async {
  const String apiUrl = '${baseUrl}resetEmail';

  // Body of the request
  Map<String, dynamic> requestBody = {
    "email": email,
    "newEmail": newEmail,
    "token": token
  };

  // Encoding the request body as JSON
  String jsonBody = jsonEncode(requestBody);

  try {
    // Making the POST request
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Authorization': 'Bearer $jwtToken',
        'Content-Type': 'application/json',
      },
      body: jsonBody,
    );
    log('Status code: ${response.statusCode}');
    // Checking response status
    if (response.statusCode == 200) {
      CustomToast.success(
          context, "Password Updated", "Email updated successfully");
    } else {
      // Password reset failed
      log('Failed to reset Email. Status code: ${response.statusCode}');
      log('Response body: ${response.body}');
      CustomToast.errorToast(context, "Failed to reset Email",
          "Error: ${jsonDecode(response.body)['message']}");
    }
  } catch (e) {
    // Error occurred
    log('Error occurred: $e');
  }
}
