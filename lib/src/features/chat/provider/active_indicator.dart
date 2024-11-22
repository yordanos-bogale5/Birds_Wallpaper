import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

/// Widget for showing active status of other members in a channel
class ActiveStatusIndicator extends StatelessWidget {
  /// Constructor for creating an [ActiveStatusIndicator]
  const ActiveStatusIndicator({
    super.key,
    required this.channel,
    required this.currentUser,
  });

  final Channel channel;
  final User currentUser;

  @override
  Widget build(BuildContext context) {
    return BetterStreamBuilder<List<Member>>(
      stream: channel.state!.membersStream,
      initialData: channel.state!.members,
      builder: (context, members) {
        // Filter out the current user
        final otherMembers = members
            .where((member) => member.userId != currentUser.id)
            .toList();

        if (otherMembers.isEmpty) {
          return const SizedBox.shrink(); // No other members, nothing to show
        }

        // For simplicity, show the status of the first other member
        final otherMember = otherMembers.first;

        // Get the user information for the other member
        final otherUser = otherMember.user;

        if (otherUser == null) {
          return const SizedBox.shrink(); // No user data
        }

        // Determine the color based on the user's status
        final isOnline = otherUser.online;
        final containerColor = isOnline ? Colors.green : Colors.red;

        return Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: containerColor, // Green if online, red if offline
            border: Border.all(color: Colors.white, width: 2),
          ),
        );
      },
    );
  }
}
