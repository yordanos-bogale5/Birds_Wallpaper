import 'dart:developer';

import 'package:stream_chat/stream_chat.dart';
import 'package:stream_video/stream_video.dart' as vid;

const String baseUrl = "https://api.chatremedy.com/api/v1/users/";
const String baseUrl2 = "https://api.chatremedy.com/api/v1/";

const String streamApiKey = "ub4qt9crhz6d";
const String streamSecret =
    "769d5dz82qeerytd4kawq5fjbxgdj2e79m7h5dyedkf4x9gwsrwdp9sph8sgs63a";
// const String streamUserToken =
//     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoidGFsaGFqYXZlZCJ9.OznLiNTAT_T9sPJxb_03AKkYG4wK8gYgQmHVtI9vnSg";
// const String streamUserToken =
//     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNjY0ZTE1ZjE1MDMyOGY2NmQwY2FkNzlkIn0.4sOddy1R8siahFOMJlc-NHDVdmiBqv-5Q6mIEohELZ0";

final client = StreamChatClient(
  'ub4qt9crhz6d',
  logLevel: Level.INFO,
);

vid.StreamVideo? clientVideo;

setStreamVideoClient(String token, String id, String name) {
  clientVideo = vid.StreamVideo(
    'ub4qt9crhz6d',
    user: vid.User.regular(userId: id, name: name),
    userToken: token,
    options: const vid.StreamVideoOptions(
        logPriority: vid.Priority.info,

        keepConnectionsAliveWhenInBackground: true),
  );
}
