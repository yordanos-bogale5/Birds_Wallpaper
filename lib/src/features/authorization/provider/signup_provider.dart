import 'dart:convert';
import 'dart:developer';
import 'package:chatremedy/src/utils/base_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../../utils/toast_widget.dart';

Future<Map<String, dynamic>?> signupProvider(String username, String email,
    String password, BuildContext context) async {
  // API endpoint URL
  String apiUrl = '${baseUrl}signup';

  try {
    // Create a Map with email and password
    Map<String, dynamic> data = {
      'isAdmin': false,
      'role': 'User',
      'username': username,
      'email': email,
      'password': password,
      'passwordConfirm': password
    };

    // Encode the data to JSON
    String body = json.encode(data);

    // Make the POST request
    http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    // Check the status code of the response
    if (response.statusCode == 200 || response.statusCode == 201) {
      // If the request is successful, return the token
      Map<String, dynamic> responseBody = json.decode(response.body);

      return responseBody;
    } else {
      final message = jsonDecode(response.body);
      log("Reponse $message");
      if (message['message'] ==
          'Username already exists. Please use a different username.') {
        return {"status": "username"};
      } else if (message['message'] ==
          "Email already exists. Please use a different email address.") {
        return {'status': 'email'};
      } else {
        CustomToast.errorToast(
            context, "Error occurred", "${message['message']}");
        return null;
      }
    }
  } catch (error) {
    // If there is an exception, print the exception
    log('Error in signup function: $error');
    CustomToast.errorToast(context, "Error occurred", "$error");
    return null;
  }
}
