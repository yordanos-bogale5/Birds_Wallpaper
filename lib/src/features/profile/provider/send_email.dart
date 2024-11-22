import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

Future<bool> sendEmail(Map<String, dynamic> templateParams) async {
  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: json.encode({
      'service_id': "service_m0rxujy",
      'template_id': "template_6dfamo8",
      'user_id': "Tu0t6lrsmPuvDdKP8",
      'accessToken': 'LLm1iIiuB4t_QfldGvmzb',
      'template_params': templateParams,
    }),
  );

  if (response.statusCode == 200) {
    log('Email sent successfully!');

    return true;
  } else {
    log('Failed to send email: ${response.statusCode}');
    log('Response: ${response.body}');
    return false;
  }
}
