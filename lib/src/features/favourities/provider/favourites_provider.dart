import 'package:chatremedy/src/model/counsellor_model/counsellor_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavouritesProvider extends StateNotifier<List<CounsellorModel>> {
  FavouritesProvider() : super([]);

  void change(List<CounsellorModel> newList) {
    state = newList;
  }

  addCounsellor(CounsellorModel model) {
    state.add(model);
  }

  removeCounsellor(CounsellorModel model) {
    state.removeWhere((element) => element.id == model.id);
  }
}

final favouritesProvider =
    StateNotifierProvider<FavouritesProvider, List<CounsellorModel>>(
        (ref) => FavouritesProvider());
