import 'dart:developer';

import 'package:chatremedy/src/features/favourities/provider/favourites_provider.dart';
import 'package:chatremedy/src/features/home/widget/counsellor_card.dart';
import 'package:chatremedy/src/model/counsellor_model/counsellor_model.dart';
import 'package:chatremedy/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/images.dart';
import '../../../utils/svg.dart';
import '../data/provider/list_counsellor_provider.dart';
import '../data/provider/search_provider.dart';

class CounsellorList extends ConsumerWidget {
  final bool favourites;
  const CounsellorList({super.key, required this.favourites});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchText = ref.watch(searchProvider);
    List<CounsellorModel> counsellorList = favourites
        ? ref.watch(favouritesProvider)
        : ref.watch(listCounsellorProvider);

    if (searchText != "") {
      counsellorList = counsellorList.where((counsellor) {
        final fName = counsellor.firstname ?? "";
        final lName = counsellor.lastname ?? "";
        return fName.toLowerCase().contains(searchText) ||
            lName.toLowerCase().contains(searchText) ||
            counsellor.helpWith!
                .any((e) => e.toLowerCase().contains(searchText));
      }).toList();
    }

    if (counsellorList.isEmpty) {
      if (favourites) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Text(
                "No Favourites Yet!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Text(
                "Click the ♥ add Counsellor to Favourite.",
                style: TextStyle(fontSize: 14, color: AppColors.primaryColor),
              ),
              // Text(
              //   "counsellor profile to add a favourite.",
              //   style: TextStyle(fontSize: 16, color: AppColors.primaryColor),
              // ),
            ],
          ),
        );
      } else {
        return SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              SvgPicture.asset(
                AppSvg.searchBig,
                height: 60,
                width: 60,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "No results match your criteria!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const Text(
                "Try modifying your search.",
                style: TextStyle(fontSize: 14, color: AppColors.primaryColor),
              ),
            ],
          ),
        );
      }
    } else {
      return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          shrinkWrap: true,
          itemCount: counsellorList.length,
          itemBuilder: (context, index) {
            final counsellor = counsellorList[index];
            return CounsellorCard(
              key: UniqueKey(),
              counsellor: counsellor,
            );
          });
    }
  }
}
