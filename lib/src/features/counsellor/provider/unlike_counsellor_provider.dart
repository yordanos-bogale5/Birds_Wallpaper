import 'dart:developer';

import 'package:chatremedy/src/features/favourities/provider/favourites_provider.dart';
import 'package:chatremedy/src/utils/base_url.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/counsellor_model/counsellor_model.dart';
import '../../authorization/provider/user_provider.dart';

Future<void> unlikeCounsellorProvider(String userId) async {
  // API endpoint URL
  String apiUrl = '${baseUrl}unlike-user/$userId';

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("token");
  try {
    // Make the DELETE request with JWT token in the header
    http.Response response = await http.delete(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    // Check the status code of the response
    if (response.statusCode == 200) {
      print('User unliked successfully.');
    } else {
      // If there is an error, print the error message
      print('Failed to unlike user: ${response.body}');
    }
  } catch (error) {
    // If there is an exception, print the exception
    print('Error in unlikeCounsellorProvider function: $error');
  }
}

void unlikeCounsellor(WidgetRef ref, CounsellorModel counsellorModel) {
  unlikeCounsellorProvider(counsellorModel.id!);
  ref.read(userProvider.notifier).unlikeCounsellor(counsellorModel.id!);

  ref.read(favouritesProvider.notifier).removeCounsellor(counsellorModel);
}
