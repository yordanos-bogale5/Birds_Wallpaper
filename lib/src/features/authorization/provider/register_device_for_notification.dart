import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../../../utils/base_url.dart';

Future<void> registerDevice(String email, String token, String jwtToken) async {
  final url = Uri.parse('${baseUrl2}notifications/register-device');

  final response = await http.post(
    url,
    headers: {
      'Authorization': 'Bearer $jwtToken',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'email': email,
      'deviceToken': token,
    }),
  );

  if (response.statusCode == 200) {
    // Successfully registered the device
    log('Device registered successfully');
  } else {
    // Handle error
    log('Failed to register device: ${response.statusCode}');
    log('Response body: ${response.body}');
  }
}