import 'dart:developer';

import 'package:chatremedy/src/features/authorization/provider/user_provider.dart';
import 'package:chatremedy/src/features/authorization/widgets/text_form_field.dart';
import 'package:chatremedy/src/features/home/widget/counsellor_list.dart';
import 'package:chatremedy/src/features/home/widget/filter_sheet.dart';
import 'package:chatremedy/src/utils/colors.dart';
import 'package:chatremedy/src/utils/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../data/provider/search_provider.dart';
import '../data/services/socket_service.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final searchController = TextEditingController();

  late final _listController = StreamChannelListController(
    client: StreamChat.of(context).client,
    filter: Filter.in_(
      'members',
      [StreamChat.of(context).currentUser!.id],
    ),
    channelStateSort: const [SortOption('last_message_at')],
    limit: 20,
  );


  initSocket()  {
    ref.read(socketServiceProvider).manuallyConnect();
  }

  @override
  void initState() {
    super.initState();
    _listController.doInitialLoad();
    Future(initSocket);
  }

  // @override
  // void dispose() {
  //   ref.read(socketServiceProvider).disconnectSocket();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: size.height * 0.175,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    "Hello, ${user.user!.username}!",
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "We're here to listen.",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          backgroundColor: Colors.white.withOpacity(0.15),
                          SVG: AppSvg.search,
                          hintText: "Search by name",
                          borderRadius: 40,
                          hintStyle: const TextStyle(color: Colors.white),
                          controller: searchController,
                          textStyle: const TextStyle(color: Colors.white),
                          onChanged: (String text) {
                            ref
                                .read(searchProvider.notifier)
                                .change(text.toLowerCase());
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          _showFilterBottomSheet(context);
                        },
                        child: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.15),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: SvgPicture.asset(
                            AppSvg.filter,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
              child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                color: AppColors.backgroundColor),
            child: const CounsellorList(
              favourites: false,
            ),
          ))
        ],
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const FilterSheet();
      },
    );
  }
}
