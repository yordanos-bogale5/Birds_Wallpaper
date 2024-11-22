import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../model/all_data/all_data.dart';


class AllDataProvider extends StateNotifier<AllData> {
  AllDataProvider() : super(AllData(languages: [], religions: [], genders: []));

  void change(AllData newData) {
    state = newData;
  }
}

final allDataProvider =
    StateNotifierProvider<AllDataProvider, AllData>((ref) => AllDataProvider());
