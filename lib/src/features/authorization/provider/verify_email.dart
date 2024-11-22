import 'dart:developer';

import 'package:chatremedy/src/utils/base_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../utils/toast_widget.dart';

Future<Map<String, dynamic>?> verifyEmail(
    String token, String email, BuildContext context) async {
  final url = Uri.parse(
      '${baseUrl}verify-email'); // Replace with your actual endpoint

  // Create the body of the request
  final body = json.encode({
    'token': token,
    'email': email,
  });

  // Set the headers
  final headers = {
    'Content-Type': 'application/json',
  };

  try {
    // Send the POST request
    final response = await http.post(url, headers: headers, body: body);
    final message = jsonDecode(response.body);

    log("messagsdaase ${message}");
    // Check the response status
    if (response.statusCode == 200) {
      return {'status': 'success'};
    } else {
      CustomToast.errorToast(
          context, "Error occurred", "${message['message']}");
      log('Failed to verify email: ${response.body}');
      return null;
    }
  } catch (e) {
    // Handle any errors that occur during the request
    log('Error: $e');
    return null;
  }
}
