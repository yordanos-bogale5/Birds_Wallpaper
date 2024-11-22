import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../utils/base_url.dart';
import '../../../utils/toast_widget.dart';

Future<Map<String, dynamic>?> updateEmailProvider(String oldEmail,
    String newEmail, String token, BuildContext context) async {
  String apiUrl = '${baseUrl}updateEmail'; // Replace with your API endpoint

  try {
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
          {'oldEmail': oldEmail, 'newEmail': newEmail}), // Encode body to JSON
    );

    log("responseee ${response.body}");

    if (response.statusCode == 200) {
      CustomToast.success(
          context, "Success", "${jsonDecode(response.body)['message']}");
      return jsonDecode(response.body)['data'];
    } else {
      CustomToast.errorToast(
          context, "Error occurred", "Failed to send code to email");
      return null;
    }
  } catch (e) {
    // Error occurred
    log('Error: $e');
    return null;
  }
}
