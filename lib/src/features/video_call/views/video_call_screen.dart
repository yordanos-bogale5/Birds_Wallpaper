import 'dart:math';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

import '../../../model/counsellor_model/counsellor_model.dart';
import '../../../utils/hex_to_color.dart';
import '../../../utils/text_avatar.dart';

class VideoCallScreen extends StatefulWidget {
  final Call call;
  final CounsellorModel counsellor;
  const VideoCallScreen(
      {super.key, required this.call, required this.counsellor});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  bool participantJoined = false;
  bool rejected = false;
  bool timeOutCalled = false;

  var random = Random();
  int randomNumber = 0;

  @override
  void initState() {
    super.initState();
    randomNumber = random.nextInt(6);
    widget.call.callEvents.on<StreamCallRejectedEvent>((event) {
      Fluttertoast.showToast(msg: "Call Rejected");
      callEnd();
    });

    widget.call.callEvents.on<StreamCallParticipantJoinedEvent>((event) {
      setState(() {
        participantJoined = true;
      });
    });
  }

  void callTimeOut() {
    Future.delayed(const Duration(seconds: 15), () {
      if (!participantJoined) {
        widget.call.end();
        widget.call.leave();
      }
    });
  }

  callEnd() async {
    await widget.call.end();
    await widget.call.leave();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamCallContainer(
      call: widget.call,
      onLeaveCallTap: () {
        callEnd();
      },
      onDeclineCallTap: () {
        callEnd();
      },
      onCancelCallTap: () {
        callEnd();
      },
      pictureInPictureConfiguration: const PictureInPictureConfiguration(
        enablePictureInPicture: true,
      ),
      outgoingCallBuilder: (context, call, callState) {
        return StreamOutgoingCallContent(
          call: call,
          callState: callState,
          callBackgroundBuilder: outGoingCallBuilder,
          onCancelCallTap: () {
            callEnd();
          },
        );
      },
      callContentBuilder: (context, call, callState) {
        if (callState.status == CallStatus.connected()) {
          if (timeOutCalled == false) {
            callTimeOut();
          }
        }
        if (participantJoined) {
          return StreamCallContent(
            call: call,
            callState: callState,
            onLeaveCallTap: () {
              callEnd();
            },
          );
        } else {
          return StreamOutgoingCallContent(
              callBackgroundBuilder: outGoingCallBuilder,
              onCancelCallTap: () {
                callEnd();
              },
              call: call,
              callState: callState);
        }
      },
    ));
  }

  final callBGList = [
    'assets/images/call1.jpeg',
    'assets/images/call2.jpeg',
    'assets/images/call3.jpg',
    'assets/images/call4.jpg',
    'assets/images/call5.jpeg',
    'assets/images/call6.jpeg',
    'assets/images/call7.jpeg',
    'assets/images/call8.jpg',
    'assets/images/call9.jpeg',
  ];

  bool mute = false;
  bool video = true;

  Widget outGoingCallBuilder(
      Call call, CallState callState, List<UserInfo> userInfo, wid) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: widget.counsellor.avatar == null ||
                  widget.counsellor.avatar == ""
              ? AssetImage(callBGList[randomNumber]) as ImageProvider<Object>
              : CachedNetworkImageProvider('${widget.counsellor.avatar}'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3), // Adjust opacity for shade
            BlendMode.darken, // Blend mode to darken the image
          ),
        ),
        // gradient: const LinearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        //   colors: [Colors.white, AppColors.primaryColor],
        // ),
      ),
      width: double.infinity,
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.counsellor.avatar == null || widget.counsellor.avatar == ""
                ? TextAvatar(
                    shape: BoxShape.circle,
                    size: 150,
                    color: hexToColor(widget.counsellor.avatarColor ?? "#452e28"),
                    text:
                        '${widget.counsellor.firstname?.toUpperCase()} ${widget.counsellor.lastname?.toUpperCase()}',
                    fontSize: 45,
                  )
                : CachedNetworkImage(
                    imageUrl: "${widget.counsellor.avatar}",
                    imageBuilder: (context, imageProvider) => Container(
                      height: 150,
                      width: 150,
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
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: Text(
                "${widget.counsellor.firstname ?? "-"} ${widget.counsellor.lastname ?? ""}",
                textAlign: TextAlign.center,
                maxLines: 2,
                style: const TextStyle(
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(0.0, 1.0),
                        blurRadius: 3.0,
                        color: Colors.grey,
                      ),
                    ],
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              callState.status == CallStatus.connected()
                  ? "Ringing..."
                  : "Connecting...",
              style: TextStyle(
                  // shadows: <Shadow>[
                  //   Shadow(
                  //     offset: Offset(0.0, 1.0),
                  //     blurRadius: 3.0,
                  //     color: Colors.grey,
                  //   ),
                  // ],
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    if (callState.status == CallStatus.connected()) {
                      widget.call.muteSelf();
                      setState(() {
                        mute = !mute;
                      });
                    } else {
                      Fluttertoast.showToast(msg: "Wait for call to connect");
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ], color: Colors.white, shape: BoxShape.circle),
                    child: mute
                        ? const Icon(Icons.mic_off)
                        : const Icon(Icons.mic),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (callState.status == CallStatus.connected()) {
                      setState(() {
                        video = !video;
                      });
                      widget.call.setCameraEnabled(enabled: video);
                    } else {
                      Fluttertoast.showToast(msg: "Wait for call to connect");
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ], color: Colors.white, shape: BoxShape.circle),
                    child: video
                        ? const Icon(Icons.videocam)
                        : const Icon(Icons.videocam_off),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                callEnd();
              },
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ], color: Colors.red, shape: BoxShape.circle),
                child: const Icon(
                  Icons.call_end,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
