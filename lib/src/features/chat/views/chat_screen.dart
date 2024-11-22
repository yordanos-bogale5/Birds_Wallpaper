import 'dart:developer';

import 'package:chatremedy/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../../../utils/avatar.dart';
import '../../../utils/stream_chat_helper.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: AppColors.primaryColor,
          title: const _AppBarTitle(),
          titleSpacing: 1,
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: StreamMessageListView(
                markReadWhenAtTheBottom: true,
                messageBuilder: (context, details, messageList, defaultImpl) {
                  return defaultImpl.copyWith(
                      showUsername: true,
                      showTimestamp: true,
                      showReactions: true,
                      showDeleteMessage: true,
                      showReplyMessage: true,
                      showThreadReplyMessage: true,
                      showResendMessage: true,
                      showCopyMessage: true,
                      showFlagButton: true,
                      showPinButton: true,
                      showPinHighlight: true,
                      // showUserAvatar: DisplayWidget.show,
                      userAvatarBuilder: (context, user) {
                        return Avatar.small(
                          url: user.extraData['avatar'].toString(),
                        );
                      });
                },
              ),
            )),
            const StreamMessageInput(
              autoCorrect: false,
            )
          ],
        ));
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final channel = StreamChannel.of(context).channel;
    return Row(
      children: [
        Avatar.small(
          url: Helpers.getChannelImage(
              channel, StreamChat.of(context).currentUser!),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Helpers.getChannelName(
                    channel, StreamChat.of(context).currentUser!),
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 2),
              BetterStreamBuilder<List<Member>>(
                stream: channel.state!.membersStream,
                initialData: channel.state!.members,
                builder: (context, data) => ConnectionStatusBuilder(
                  statusBuilder: (context, status) {
                    switch (status) {
                      case ConnectionStatus.connected:
                        return _buildConnectedTitleState(context, data);
                      case ConnectionStatus.connecting:
                        return const Text(
                          'Connecting',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      case ConnectionStatus.disconnected:
                        return const Text(
                          'Offline',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      default:
                        return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildConnectedTitleState(
    BuildContext context,
    List<Member>? members,
  ) {
    Widget? alternativeWidget;
    final channel = StreamChannel.of(context).channel;
    final memberCount = channel.memberCount;
    if (memberCount != null && memberCount > 2) {
      var text = 'Members: $memberCount';
      final watcherCount = channel.state?.watcherCount ?? 0;
      if (watcherCount > 0) {
        text = 'watchers $watcherCount';
      }
      alternativeWidget = Text(
        text,
      );
    } else {
      final userId = StreamChatCore.of(context).currentUser?.id;
      final otherMember = members?.firstWhere(
          (element) => element.userId != userId,
          orElse: () => Member());

      if (otherMember != null) {
        if (otherMember.user?.online == true) {
          alternativeWidget = const Text(
            'Online',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          );
        } else {
          alternativeWidget = Text(
            'Last seen: '
            '${otherMember.user!.lastActive == null ? "Never" : Jiffy.parseFromDateTime(otherMember.user!.lastActive!).fromNow()}',
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          );
        }
      }
    }

    return TypingIndicator(
      alternativeWidget: alternativeWidget,
    );
  }
}

/// Widget to show the current list of typing users
class TypingIndicator extends StatelessWidget {
  /// Instantiate a new TypingIndicator
  const TypingIndicator({
    super.key,
    this.alternativeWidget,
  });

  /// Widget built when no typings is happening
  final Widget? alternativeWidget;

  @override
  Widget build(BuildContext context) {
    final channelState = StreamChannel.of(context).channel.state!;

    final altWidget = alternativeWidget ?? const SizedBox.shrink();

    return BetterStreamBuilder<Iterable<User>>(
      initialData: channelState.typingEvents.keys,
      stream: channelState.typingEventsStream
          .map((typings) => typings.entries.map((e) => e.key)),
      builder: (context, data) {
        return Align(
          alignment: Alignment.centerLeft,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: data.isNotEmpty == true
                ? const Align(
                    alignment: Alignment.centerLeft,
                    key: ValueKey('typing-text'),
                    child: Text(
                      'Typing message',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Align(
                    alignment: Alignment.centerLeft,
                    key: const ValueKey('altwidget'),
                    child: altWidget,
                  ),
          ),
        );
      },
    );
  }
}

/// Widget that builds itself based on the latest snapshot of interaction with
/// a [Stream] of type [ConnectionStatus].
///
/// The widget will use the closest [StreamChatClient.wsConnectionStatusStream]
/// in case no stream is provided.
class ConnectionStatusBuilder extends StatelessWidget {
  /// Creates a new ConnectionStatusBuilder
  const ConnectionStatusBuilder({
    super.key,
    required this.statusBuilder,
    this.connectionStatusStream,
    this.errorBuilder,
    this.loadingBuilder,
  });

  /// The asynchronous computation to which this builder is currently connected.
  final Stream<ConnectionStatus>? connectionStatusStream;

  /// The builder that will be used in case of error
  final Widget Function(BuildContext context, Object? error)? errorBuilder;

  /// The builder that will be used in case of loading
  final WidgetBuilder? loadingBuilder;

  /// The builder that will be used in case of data
  final Widget Function(BuildContext context, ConnectionStatus status)
      statusBuilder;

  @override
  Widget build(BuildContext context) {
    final stream = connectionStatusStream ??
        StreamChatCore.of(context).client.wsConnectionStatusStream;
    final client = StreamChatCore.of(context).client;
    return BetterStreamBuilder<ConnectionStatus>(
      initialData: client.wsConnectionStatus,
      stream: stream,
      noDataBuilder: loadingBuilder,
      errorBuilder: (context, error) {
        if (errorBuilder != null) {
          return errorBuilder!(context, error);
        }
        return const Offstage();
      },
      builder: statusBuilder,
    );
  }
}
