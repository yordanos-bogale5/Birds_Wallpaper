import 'package:chatremedy/src/model/counsellor_model/counsellor_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListCounsellorProvider extends StateNotifier<List<CounsellorModel>> {
  ListCounsellorProvider() : super([]);

  void change(List<CounsellorModel> newList) {
    state = newList;
  }

  void updateStatus(String id, bool isActive) {
    final tempState = state;
    final counsellor = tempState.firstWhere((c) => c.id == id,
        orElse: () => CounsellorModel());
    counsellor.isActive = isActive;
    state = tempState;
  }

  // void filterList(String searchText) {
  //   final tempList = [...state];
  //   final filteredList = tempList
  //       .where((element) =>
  //           element.firstname!.toLowerCase() == searchText ||
  //           element.lastname!.toLowerCase() == searchText)
  //       .toList();
  //
  //   state = filteredList;
  // }
}

final listCounsellorProvider =
    StateNotifierProvider<ListCounsellorProvider, List<CounsellorModel>>(
        (ref) => ListCounsellorProvider());
