import 'dart:convert';
import 'dart:developer';
import 'package:chatremedy/src/utils/base_url.dart';
import 'package:chatremedy/src/utils/toast_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> updatePasswordProvider(
    String currentPassword, String newPassword, BuildContext context) async {
  // Replace the URL with your actual endpoint
  String url = '${baseUrl}updatePassword';

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("token");

  // Create a map representing the request body
  Map<String, String> requestBody = {
    "currentPassword": currentPassword,
    "newPassword": newPassword,
    "newPasswordConfirm": newPassword
  };

  // Convert the request body to JSON
  String jsonBody = jsonEncode(requestBody);

  try {
    // Make a POST request
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonBody,
    );

    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      CustomToast.success(
          context, "Password Updated", "Password updated successfully");
    } else {
      log("message ${response.body}");
      CustomToast.errorToast(context, "Failed to update password",
          "Error: ${jsonDecode(response.body)['message']}");
    }
  } catch (e) {
    // Handle any errors that occur during the process
    print('Error: $e');
  }
}
