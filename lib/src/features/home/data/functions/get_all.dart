import 'dart:convert';
import 'dart:developer';

import 'package:chatremedy/src/model/all_data/all_data.dart';
import 'package:http/http.dart' as http;

Future<AllData?> fetchAllData() async {
  var url = Uri.parse('https://api.chatremedy.com/api/v1/list/all');

  try {
    var response = await http.get(url);

    if (response.statusCode == 200) {
      // Convert each user object to CounsellorModel
      AllData allData = AllData.fromJson(json.decode(response.body)['data']);

      return allData;
    } else {
      // If the server did not return a 200 OK response, throw an exception
      throw Exception('Failed to load data');
    }
  } catch (e) {
    // Catch any errors that might occur during the process
    log('Error: $e');
    return null;
  }
}
