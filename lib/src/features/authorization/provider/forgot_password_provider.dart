import 'dart:convert';
import 'dart:developer';

import 'package:chatremedy/src/utils/base_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../utils/toast_widget.dart';

Future<Map<String, dynamic>?> forgotPasswordProvider(
    BuildContext context, String email) async {
  const apiUrl = '${baseUrl}forgotPassword';

  final Map<String, dynamic> requestData = {
    'email': email,
  };

  try {
    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(requestData),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      CustomToast.success(
          context, "Success", "${jsonDecode(response.body)['message']}");
      return jsonDecode(response.body)['data'];
    } else {
      if (jsonDecode(response.body)['message'] == "Email Address Not Found!") {
        return {'status': 'email'};
      }
      return null;
    }
  } catch (e) {
    CustomToast.errorToast(context, "Error occurred", "$e");

    return null;
  }
}
