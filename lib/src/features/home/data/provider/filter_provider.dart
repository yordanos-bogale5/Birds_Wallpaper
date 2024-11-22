import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final filterProvider = ChangeNotifierProvider((ref) => FilterProvider());

class FilterProvider extends ChangeNotifier {
  String? selectedLanguage;
  String? selectedGender;
  String? selectedReligion;

  void changeLanguage(String? newVal) {
    selectedLanguage = newVal;
    notifyListeners();
  }

  void changeReligion(String? newVal) {
    selectedReligion = newVal;
    notifyListeners();
  }

  void changeGender(String? newVal) {
    selectedGender = newVal;
    notifyListeners();
  }

  void reset() {
    selectedGender = null;
    selectedReligion = null;
    selectedLanguage = null;
    notifyListeners();
  }
}
