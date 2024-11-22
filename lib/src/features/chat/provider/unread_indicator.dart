import 'package:chatremedy/src/utils/base_url.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import '../../../utils/colors.dart';

/// Widget for showing an unread indicator
class UnreadIndicator extends StatelessWidget {
  /// Constructor for creating an [UnreadIndicator]
  const UnreadIndicator({
    super.key,
    required this.channel,
  });

  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: BetterStreamBuilder<int>(
        stream: channel.state!.unreadCountStream,
        initialData: channel.state!.unreadCount,
        builder: (context, data) {
          if (data == 0) {
            return const SizedBox.shrink();
          }
          return Container(
            height: 15,
            width: 15,
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
            alignment: Alignment.center,
            child: Text(
              '${data > 99 ? '99+' : data}',
              style: const TextStyle(
                fontSize: 11,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Widget for showing an unread indicator
class UnreadIndicatorInbox extends StatelessWidget {
  /// Constructor for creating an [UnreadIndicatorInbox]
  const UnreadIndicatorInbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: BetterStreamBuilder<int>(
        stream: client.state.unreadChannelsStream,
        initialData: client.state.unreadChannels,
        builder: (context, data) {
          if (data == 0) {
            return const SizedBox.shrink();
          }
          return Container(
            height: 15,
            width: 15,
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
            alignment: Alignment.center,
            child: Text(
              '${data > 99 ? '99+' : data}',
              style: const TextStyle(
                fontSize: 10,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
