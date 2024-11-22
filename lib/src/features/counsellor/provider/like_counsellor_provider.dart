import 'package:chatremedy/src/features/favourities/provider/favourites_provider.dart';
import 'package:chatremedy/src/utils/base_url.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/counsellor_model/counsellor_model.dart';
import '../../authorization/provider/user_provider.dart';

Future<void> likeCounsellorProvider(String userId) async {
  // API endpoint URL
  String apiUrl = '${baseUrl}like-user/$userId';

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("token");
  try {
    // Make the POST request with JWT token in the header
    http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    // Check the status code of the response
    if (response.statusCode == 200) {
      print('User liked successfully.');
    } else {
      // If there is an error, print the error message
      print('Failed to like user: ${response.body}');
    }
  } catch (error) {
    // If there is an exception, print the exception
    print('Error in likeUser function: $error');
  }
}

void likeCounsellor(WidgetRef ref, CounsellorModel counsellorModel) {
  likeCounsellorProvider(counsellorModel.id!);
  ref
      .read(userProvider.notifier)
      .likeCounsellor(counsellorModel.id!);

  ref
      .read(favouritesProvider.notifier)
      .addCounsellor(counsellorModel);
}

