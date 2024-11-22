import 'dart:convert';
import 'dart:developer';
import 'package:chatremedy/src/model/counsellor_model/counsellor_model.dart';
import 'package:chatremedy/src/utils/base_url.dart';
import 'package:http/http.dart' as http;

Future<List<CounsellorModel>> getFavourites(String jwtToken) async {
  // API endpoint URL
  String apiUrl = '${baseUrl}get-liked-counselors';

  try {
    // Make the GET request with JWT token in the header and role in the query parameter
    http.Response response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $jwtToken',
        'Content-Type': 'application/json',
      },
    );

    // Check the status code of the response
    if (response.statusCode == 200) {
      // log("sssdsfasfsafasf ${json.decode(response.body)}");

      // If the request is successful, parse the response body
      List<dynamic> userList = json.decode(response.body)['data']['counselors'];

      List<CounsellorModel> users =
          userList.map((user) => CounsellorModel.fromJson(user)).toList();
      return users;
    } else {
      // If there is an error, print the error message
      print('Failed to get favourites: ${response.body}');
      return [];
    }
  } catch (error) {
    // If there is an exception, print the exception
    print('Error in get favourites function: $error');
    return [];
  }
}
