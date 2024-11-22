import 'dart:math';

import 'package:chatremedy/src/features/authorization/provider/user_provider.dart';
import 'package:chatremedy/src/features/video_call/views/video_call_screen.dart';
import 'package:chatremedy/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

import '../../../model/counsellor_model/counsellor_model.dart';
import '../../../utils/base_url.dart';

class VideoSessionDialog extends ConsumerStatefulWidget {
  final CounsellorModel counsellor;
  const VideoSessionDialog({super.key, required this.counsellor});

  @override
  ConsumerState<VideoSessionDialog> createState() => _VideoSessionDialogState();
}

class _VideoSessionDialogState extends ConsumerState<VideoSessionDialog> {
  Random random = Random();
  initiateVideo() {
    final user = ref.watch(userProvider);
    final call = clientVideo!.makeCall(
        callType: StreamCallType.defaultType(),
        id: '${DateTime.now().microsecondsSinceEpoch}',
        preferences: DefaultCallPreferences(dropIfAloneInRingingFlow: true));

    call.getOrCreate(
        memberIds: ['${widget.counsellor.id}'], ringing: true, video: true);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VideoCallScreen(
                  call: call,
                  counsellor: widget.counsellor,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      actionsPadding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      titlePadding: const EdgeInsets.only(left: 15, right: 15, top: 15),
      title: const Text(
        "Video Session",
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("You’re about to start a video Session."),
          Text(
            "\$180.00/30min.",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            initiateVideo();
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            child: const Text(
              "Start Session",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
