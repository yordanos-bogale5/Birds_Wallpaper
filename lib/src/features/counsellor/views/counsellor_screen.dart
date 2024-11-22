import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatremedy/src/features/authorization/provider/user_provider.dart';
import 'package:chatremedy/src/features/chat/provider/active_indicator_by_id.dart';
import 'package:chatremedy/src/features/chat/views/chat_screen.dart';
import 'package:chatremedy/src/features/counsellor/provider/like_counsellor_provider.dart';
import 'package:chatremedy/src/features/counsellor/widget/video_session_dialog.dart';
import 'package:chatremedy/src/model/counsellor_model/counsellor_model.dart';
import 'package:chatremedy/src/utils/colors.dart';
import 'package:chatremedy/src/utils/convert_date_to_year.dart';
import 'package:chatremedy/src/utils/show_loader_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';
import 'package:rxdart/rxdart.dart';
import '../../../utils/base_url.dart';
import '../../../utils/hex_to_color.dart';
import '../../../utils/svg.dart';
import '../../../utils/text_avatar.dart';
import '../../video_call/views/video_call_screen.dart';
import '../provider/unlike_counsellor_provider.dart';

class CounsellorScreen extends ConsumerStatefulWidget {
  final CounsellorModel counsellor;
  const CounsellorScreen({super.key, required this.counsellor});

  @override
  ConsumerState<CounsellorScreen> createState() => _CounsellorScreenState();
}

class _CounsellorScreenState extends ConsumerState<CounsellorScreen> {
  final _compositeSubscription = CompositeSubscription();

  @override
  void initState() {
    super.initState();

    _observeCallKitEvents();
  }

  void _observeCallKitEvents() {
    final streamVideo = StreamVideo.instance;

    // You can use our helper method to observe core CallKit events
    // It will handled call accepted, declined and ended events
    _compositeSubscription.add(
      streamVideo.observeCoreCallKitEvents(
        onCallAccepted: (callToJoin) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VideoCallScreen(
                        call: callToJoin,
                        counsellor: widget.counsellor,
                      )));
        },
      ),
    );

    // Or you can handle them by yourself, and/or add additional events such as handling mute events from CallKit
    // _compositeSubscription.add(streamVideo.onCallKitEvent<ActionCallToggleMute>(_onCallToggleMute));
  }

  @override
  void dispose() {
    super.dispose();
    _compositeSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final liked = user.user!.likes!.contains(widget.counsellor.id!);

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Container(
                    height: 50,
                    width: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle),
                    child: SvgPicture.asset(
                      AppSvg.arrowBack,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                GestureDetector(
                  onTap: () {
                    if (liked) {
                      unlikeCounsellor(ref, widget.counsellor);
                    } else {
                      likeCounsellor(ref, widget.counsellor);
                    }
                    setState(() {});
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle),
                    child: SvgPicture.asset(
                      liked ? AppSvg.heartFilled : AppSvg.heartOutlined,
                      color: liked ? Colors.red : Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      widget.counsellor.avatar == null ||
                              widget.counsellor.avatar == ""
                          ? TextAvatar(
                              shape: BoxShape.circle,
                              size: 100,
                              text:
                                  '${widget.counsellor.firstname?.toUpperCase()} ${widget.counsellor.lastname?.toUpperCase()}',
                              fontSize: 35,
                              color: hexToColor(
                                  widget.counsellor.avatarColor ?? "#452e28"),
                            )
                          : CachedNetworkImage(
                              imageUrl: "${widget.counsellor.avatar}",
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                alignment: Alignment.bottomRight,
                              ),
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),

                      ActiveStatusIndicatorByUserId(userId: widget.counsellor.id!, size: 20, margin: true, active: widget.counsellor.isActive!,)
                      // Container(
                      //   height: 20,
                      //   width: 20,
                      //   margin: const EdgeInsets.only(right: 5, bottom: 5),
                      //   decoration: BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       color: widget.counsellor.isActive!
                      //           ? Colors.green
                      //           : Colors.red,
                      //       border: Border.all(color: Colors.white, width: 3)),
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${widget.counsellor.firstname ?? "-"} ${widget.counsellor.lastname ?? ""}",
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${widget.counsellor.jobtitle}",
                    style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                                color: widget.counsellor.isActive!
                                    ? AppColors.primaryColor
                                    : AppColors.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  AppSvg.video,
                                  color: widget.counsellor.isActive!
                                      ? Colors.white
                                      : AppColors.primaryColor.withOpacity(0.5),
                                  width: 24,
                                ),
                                Text(
                                  "  \$${widget.counsellor.videoSessionPrice ?? 0}/30 min",
                                  style: TextStyle(
                                      color: widget.counsellor.isActive!
                                          ? Colors.white
                                          : AppColors.primaryColor
                                              .withOpacity(0.5),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            if (widget.counsellor.isActive!) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return VideoSessionDialog(
                                    counsellor: widget.counsellor,
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            showLoaderDialog(context);
                            final channel =
                                client.channel("messaging", extraData: {
                              "members": [
                                (StreamChat.of(context).currentUser?.id),
                                "${widget.counsellor.id}"
                              ]
                            });

                            await channel.watch().then((v) {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => StreamChannel(
                                    channel: channel,
                                    child: const ChatScreen(),
                                  ),
                                ),
                              );
                            }).catchError((e) {
                              Navigator.pop(context);
                              Fluttertoast.showToast(msg: "Error: $e");
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  AppSvg.email,
                                  color: AppColors.primaryColor,
                                  width: 24,
                                ),
                                Text(
                                  "  \$${widget.counsellor.emailPrice ?? 0}.00/msg",
                                  style: const TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${widget.counsellor.aboutMe}",
                    style: const TextStyle(
                        color: AppColors.hintColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  Divider(
                    height: 30,
                    color: Colors.black.withOpacity(0.05),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "What I can help you with",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          children: [
                            ...widget.counsellor.helpWith!.map((e) => Text(
                                  "$e, ",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Country",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${widget.counsellor.country}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        Divider(
                          height: 30,
                          color: Colors.black.withOpacity(0.05),
                        ),
                        const Text(
                          "Languages",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        widget.counsellor.languagesSpeak == null ||
                                widget.counsellor.languagesSpeak!.isEmpty
                            ? const SizedBox(
                                height: 40,
                              )
                            : SizedBox(
                                height: 40,
                                child: ListView(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    ...widget.counsellor.languagesSpeak!
                                        .map((e) => Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              child: Text(e),
                                            ))
                                  ],
                                ),
                              ),
                        Divider(
                          height: 30,
                          color: Colors.black.withOpacity(0.05),
                        ),
                        const Text(
                          "Religion",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(30)),
                          child: Text("${widget.counsellor.religion}"),
                        ),
                        Divider(
                          height: 30,
                          color: Colors.black.withOpacity(0.05),
                        ),
                        const Text(
                          "Education",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ...widget.counsellor.experiences!.map((e) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${e.institution}",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        "${e.specialization}",
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${e.startDate != null ? convertDateToYear(e.startDate!) : ""}-${e.endDate != null ? convertDateToYear(e.endDate!) : ""}",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            )),
                        Divider(
                          height: 20,
                          color: Colors.black.withOpacity(0.05),
                        ),
                        Divider(
                          height: 20,
                          color: Colors.black.withOpacity(0.05),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
