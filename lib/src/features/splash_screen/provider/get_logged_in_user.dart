import 'dart:convert';
import 'dart:developer';
import 'package:chatremedy/src/model/user_data/user_data.dart';
import 'package:chatremedy/src/utils/base_url.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<UserData?> getLoggedInUser() async {
  // API endpoint URL
  String apiUrl = baseUrl;

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("token");
  try {
    // Make the POST request
    http.Response response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    // Check the status code of the response
    if (response.statusCode == 200) {
      // If the request is successful, return the token
      Map<String, dynamic> responseBody = json.decode(response.body);

      return UserData.fromJson(responseBody['data']);
    } else {
      // If there is an error, print the error message
      log('Failed to login: ${response.body}');
      return null;
    }
  } catch (error) {
    // If there is an exception, print the exception
    print('Error in login function: $error');
    return null;
  }
}
