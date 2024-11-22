import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatremedy/src/features/counsellor/views/counsellor_screen.dart';
import 'package:chatremedy/src/model/counsellor_model/counsellor_model.dart';
import 'package:chatremedy/src/utils/colors.dart';
import 'package:chatremedy/src/utils/hex_to_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/svg.dart';
import '../../../utils/text_avatar.dart';
import '../../authorization/provider/user_provider.dart';
import '../../chat/provider/active_indicator_by_id.dart';
import '../../counsellor/provider/like_counsellor_provider.dart';
import '../../counsellor/provider/unlike_counsellor_provider.dart';

class CounsellorCard extends ConsumerStatefulWidget {
  final CounsellorModel counsellor;
  const CounsellorCard({super.key, required this.counsellor});

  @override
  ConsumerState<CounsellorCard> createState() => _CounsellorCardState();
}

class _CounsellorCardState extends ConsumerState<CounsellorCard> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final liked = user.user!.likes!.contains(widget.counsellor.id!);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => CounsellorScreen(
              counsellor: widget.counsellor,
              key: widget.key,
            ),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
          // MaterialPageRoute(
          //     builder: (context) => CounsellorScreen(
          //           counsellor: widget.counsellor,
          //           key: widget.key,
          //         ))
        );
      },
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  widget.counsellor.avatar == null ||
                          widget.counsellor.avatar == ""
                      ? TextAvatar(
                          shape: BoxShape.circle,
                          size: 50,
                          color:
                              hexToColor(widget.counsellor.avatarColor ?? "#452e28"),
                          text:
                              '${widget.counsellor.firstname?.toUpperCase()} ${widget.counsellor.lastname?.toUpperCase()}',
                          fontSize: 20,
                        )
                      : CachedNetworkImage(
                          imageUrl: widget.counsellor.avatar ?? "",
                          imageBuilder: (context, imageProvider) => Container(
                            height: 50,
                            width: 50,
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
                  ActiveStatusIndicatorByUserId(userId: widget.counsellor.id!, size: 15, margin: false, active: widget.counsellor.isActive!,)
                  // Container(
                  //   height: 15,
                  //   width: 15,
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
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.counsellor.firstname ?? "-"} ${widget.counsellor.lastname ?? ""}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      widget.counsellor.jobtitle ?? "",
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: AppColors.primaryColor),
                    ),
                  ],
                ),
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
                child: SvgPicture.asset(
                  liked ? AppSvg.heartFilled : AppSvg.heartOutlined,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
