import 'dart:math';
import 'dart:developer' as dev;
import 'package:intl/intl.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

abstract class Helpers {
  static final random = Random();

  static String randomPictureUrl() {
    final randomInt = random.nextInt(1000);
    return 'https://picsum.photos/seed/$randomInt/300/300';
  }

  static String getChannelName(Channel channel, User currentUser) {
    if (channel.name != null) {
      return channel.name!;
    } else if (channel.state?.members.isNotEmpty ?? false) {
      final otherMembers = channel.state?.members
          .where(
            (element) => element.userId != currentUser.id,
          )
          .toList();

      if (otherMembers?.length == 1) {
        return otherMembers!.first.user?.name ?? 'No name';
      } else {
        return 'Multiple users';
      }
    } else {
      return 'No Channel Name';
    }
  }

  static String? getChannelImage(Channel channel, User currentUser) {
    if (channel.image != null) {
      return channel.image!;
    } else if (channel.state?.members.isNotEmpty ?? false) {
      final otherMembers = channel.state?.members
          .where(
            (element) => element.userId != currentUser.id,
          )
          .toList();

      if (otherMembers?.length == 1) {
        return otherMembers!.first.user?.extraData['avatar'].toString();
      }
    }
    return null;
  }

  static String getChannelActiveStatus(Channel channel, User currentUser) {
    if (channel.state?.members.isNotEmpty ?? false) {
      final otherMembers = channel.state?.members
          .where(
            (element) => element.userId != currentUser.id,
      )
          .toList();

      if (otherMembers?.length == 1) {
        final otherUser = otherMembers!.first.user;
        if (otherUser?.online == true) {
          return 'Online';
        } else if (otherUser?.lastActive != null) {
          final lastSeen = DateFormat('yMMMd').add_jm().format(otherUser!.lastActive!);
          return 'Last seen: $lastSeen';
        } else {
          return 'Offline';
        }
      }
    }
    return 'No members available';
  }
}
