import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../../utils/base_url.dart';
import '../../../utils/toast_widget.dart';

Future<bool> deleteUser(
    String jwtToken, String email, BuildContext context) async {
  String apiUrl = '${baseUrl}delete/$email';

  try {
    http.Response response = await http.delete(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $jwtToken',
        'Content-Type': 'application/json',
      },
    );

    log("Response Delete ${response.statusCode} ${response.body}");

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);

      if (responseData['status'] == "success") {
        CustomToast.success(
            context, "Account Deleted", "Account deleted successfully");
        return true;
      } else {
        return false;
      }
    } else {
      Navigator.pop(context);
      final message = jsonDecode(response.body);
      CustomToast.errorToast(
          context, "Error occurred", "${message['message']}");
      throw Exception('Failed to delete user: ${response.reasonPhrase}');
    }
  } catch (e) {
    return false;
  }
}
