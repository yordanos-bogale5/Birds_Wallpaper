import 'dart:convert';
import 'dart:developer';
import 'package:chatremedy/src/model/counsellor_model/counsellor_model.dart';
import 'package:chatremedy/src/utils/base_url.dart';
import 'package:http/http.dart' as http;

Future<List<CounsellorModel>> getAllUsers(String jwtToken, String role) async {
  // API endpoint URL
  String apiUrl = '${baseUrl}get-users';

  try {
    // Make the GET request with JWT token in the header and role in the query parameter
    http.Response response = await http.get(
      Uri.parse('$apiUrl?role=$role'),
      headers: {
        'Authorization': 'Bearer $jwtToken',
        'Content-Type': 'application/json',
      },
    );

    // Check the status code of the response
    if (response.statusCode == 200) {
      // If the request is successful, parse the response body
      List<dynamic> userList = json.decode(response.body)['data']['users'];
      // Convert each user object to CounsellorModel
      List<CounsellorModel> users =
          userList.map((user) => CounsellorModel.fromJson(user)).toList();
      return users;
    } else {
      // If there is an error, print the error message
      print('Failed to get users: ${response.body}');
      return [];
    }
  } catch (error) {
    // If there is an exception, print the exception
    print('Error in getAllUsers function: $error');
    return [];
  }
}

Future<List<CounsellorModel>> getFilteredUser(String jwtToken, String role,
    {String? name,
    String? country,
    String? language,
    String? gender,
    String? religion}) async {
  String apiUrl = '${baseUrl}get-users';
  String url = '$apiUrl?role=$role';

  if (name != null) url += '&name=$name';
  if (country != null) url += '&country=$country';
  if (language != null) url += '&language=$language';
  if (gender != null) url += '&gender=$gender';
  if (religion != null) url += '&religion=$religion';

  try {
    http.Response response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $jwtToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> userList = json.decode(response.body)['data']['users'];
      List<CounsellorModel> users =
          userList.map((user) => CounsellorModel.fromJson(user)).toList();
      return users;
    } else {
      log('Failed to load users ${response.body}');
      return [];
    }
  } catch (e) {
    log('Failed to fetch data: $e');
    return [];
  }
}
