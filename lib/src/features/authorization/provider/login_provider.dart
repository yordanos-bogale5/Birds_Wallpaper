import 'dart:convert';
import 'dart:developer';
import 'package:chatremedy/src/utils/base_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../utils/toast_widget.dart';

Future<Map<String, dynamic>?> loginProvider(
    String email, String password, BuildContext context) async {
  // API endpoint URL
  String apiUrl = '${baseUrl}login';

  // Create a Map with email and password
  Map<String, dynamic> data = {
    'email': email,
    'password': password,
    'source': 'user_app',
  };

  // Encode the data to JSON
  String body = json.encode(data);

  try {
    // Make the POST request
    http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    log("Responseee ${response.body}");

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (responseBody.containsKey('data')) {
        return responseBody;
      } else {
        return null;
      }
    } else {
      Navigator.pop(context);
      final message = jsonDecode(response.body);

      if (message['message'] == "Invalid Password.") {
        return {'status': 'password'};
      } else if (message['message'] == "No user registered with this email.") {
        return {'status': 'email'};
      } else if (message['message'] ==
          "This Account is currently Locked. To Unlock please email support team.") {
        return {'status': 'locked'};
      }
      return null;
    }
  } catch (e) {
    Navigator.pop(context);
    CustomToast.errorToast(
        context, "Error occurred", "Failed to connect to server");
    return null;
  }
}
