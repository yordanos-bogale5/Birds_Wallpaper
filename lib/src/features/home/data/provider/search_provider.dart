import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchProvider extends StateNotifier<String> {
  SearchProvider() : super("");

  void change(String text) {
    state = text;
  }
}

final searchProvider =
    StateNotifierProvider<SearchProvider, String>((ref) => SearchProvider());
