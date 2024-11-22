
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

/// Widget for showing active status of a user by their user ID
class ActiveStatusIndicatorByUserId extends StatelessWidget {
  const ActiveStatusIndicatorByUserId(
      {super.key,
      required this.userId,
      required this.size,
      required this.margin,
      required this.active});

  final String userId;
  final double size;
  final bool margin;
  final bool active;

  @override
  Widget build(BuildContext context) {
    // Get the Stream client
    final client = StreamChatCore.of(context).client;

    // Subscribe to the users stream for real-time updates
    return BetterStreamBuilder<Map<String, User?>>(
      stream: client.state.usersStream,
      initialData: client.state.users, // Initial user data if available
      builder: (context, users) {
        final user = users[userId];

        if (user == null) {
          return Container(
            height: size,
            width: size,
            margin: margin
                ? const EdgeInsets.only(right: 5, bottom: 5)
                : EdgeInsets.zero,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: active
                  ? Colors.green
                  : Colors.red, // Green if online, red if offline
              border: Border.all(color: Colors.white, width: 3),
            ),
          ); // No user data or user not found
        }

        // Determine the color based on the user's status
        final isOnline = user.online;
        final containerColor = isOnline ? Colors.green : Colors.red;

        return Container(
          height: size,
          width: size,
          margin: margin
              ? const EdgeInsets.only(right: 5, bottom: 5)
              : EdgeInsets.zero,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: containerColor, // Green if online, red if offline
            border: Border.all(color: Colors.white, width: 3),
          ),
        );
      },
    );
  }
}
