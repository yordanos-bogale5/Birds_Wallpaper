
import 'package:chatremedy/src/utils/colors.dart';
import 'package:chatremedy/src/utils/show_loader_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/functions/get_all_users.dart';
import '../data/provider/all_data_provider.dart';
import '../data/provider/filter_provider.dart';
import '../data/provider/list_counsellor_provider.dart';


class FilterSheet extends ConsumerStatefulWidget {
  const FilterSheet({super.key});

  @override
  ConsumerState<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends ConsumerState<FilterSheet> {
  @override
  Widget build(BuildContext context) {
    final allData = ref.watch(allDataProvider);
    final filters = ref.watch(filterProvider);
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 4,
            width: 100,
            decoration: BoxDecoration(
                color: AppColors.hintColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(30)),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.hintColor),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const Text(
                'Filters',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 60,
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Language',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.hintColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButton(
                    underline: const SizedBox(),
                    dropdownColor: Colors.white,
                    isExpanded: true,
                    value: filters.selectedLanguage,
                    hint: const Text("Select Language"),
                    items: [
                      ...allData.languages!.map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                    ],
                    onChanged: (value) {
                      ref.read(filterProvider.notifier).changeLanguage(value);
                    }),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Gender',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.hintColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButton(
                    underline: const SizedBox(),
                    dropdownColor: Colors.white,
                    isExpanded: true,
                    value: filters.selectedGender,
                    hint: const Text("Select Gender"),
                    items: [
                      ...allData.genders!.map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                    ],
                    onChanged: (value) {
                      ref.read(filterProvider.notifier).changeGender(value);
                    }),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Religion',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.hintColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButton(
                    underline: const SizedBox(),
                    dropdownColor: Colors.white,
                    isExpanded: true,
                    value: filters.selectedReligion,
                    hint: const Text("Select Religion"),
                    items: [
                      ...allData.religions!.map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                    ],
                    onChanged: (value) {
                      ref.read(filterProvider.notifier).changeReligion(value);
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: const Text(
                      'Reset All',
                      style: TextStyle(
                        color: AppColors.hintColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () async {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      final token = prefs.getString("token");
                      showLoaderDialog(context);

                      ref.read(filterProvider.notifier).reset();

                      getAllUsers(token ?? "", "Counsellor").then((value) {
                        ref.read(listCounsellorProvider.notifier).change(value);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      });
                    },
                  ),
                  GestureDetector(
                    onTap: () async {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      final token = prefs.getString("token");
                      showLoaderDialog(context);
                      getFilteredUser(token ?? "", "Counsellor",
                              religion: filters.selectedReligion,
                              gender: filters.selectedGender,
                              language: filters.selectedLanguage)
                          .then((value) {
                        ref.read(listCounsellorProvider.notifier).change(value);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                      child: const Text(
                        "Save Filter",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          )
        ],
      ),
    );
  }
}
