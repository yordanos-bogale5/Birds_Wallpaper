import 'package:chatremedy/src/features/chat/provider/active_indicator.dart';
import 'package:chatremedy/src/features/chat/views/chat_screen.dart';
import 'package:chatremedy/src/utils/avatar.dart';
import 'package:chatremedy/src/utils/stream_chat_helper.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../../../utils/colors.dart';
import '../provider/unread_indicator.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  late final _listController = StreamChannelListController(
    client: StreamChat.of(context).client,
    filter: Filter.in_(
      'members',
      [StreamChat.of(context).currentUser!.id],
    ),
    channelStateSort: const [SortOption('last_message_at')],
    limit: 20,
  );

  @override
  void initState() {
    _listController.doInitialLoad();
    super.initState();
  }

  @override
  void dispose() {
    // _listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  children: [
                    Text(
                      "Chats",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                )),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20))),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                child: StreamChannelListView(
                  controller: _listController,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  itemBuilder: _channelTileBuilder,
                ),
              ),
            ),
          ],
        ));
  }

  Widget _channelTileBuilder(BuildContext context, List<Channel> channels,
      int index, StreamChannelListTile defaultChannelTile) {
    final channel = channels[index];
    final lastMessage = channel.state?.messages.reversed.firstWhere(
        (message) => !message.isDeleted,
        orElse: () => Message(text: ""));

    final subtitle =
        lastMessage?.text == "" ? 'nothing yet' : lastMessage!.text!;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return StreamChannel(
            channel: channel,
            child: const ChatScreen(),
          );
        }));
      },
      child: Container(
        height: 70,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).dividerColor,
              width: 0.05,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Avatar.medium(
                        url: Helpers.getChannelImage(
                            channel, StreamChat.of(context).currentUser!)),
                    ActiveStatusIndicator(
                        channel: channel,
                        currentUser: StreamChat.of(context).currentUser!),
                  ],
                ),
              ),
              // Text(Helpers.getChannelActiveStatus(channel, StreamChat.of(context).currentUser!)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Helpers.getChannelName(
                          channel, StreamChat.of(context).currentUser!),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        letterSpacing: 0.2,
                        wordSpacing: 1.5,
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    _buildLastMessage(subtitle, channel)
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    _buildLastMessageAt(channel),
                    const SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: UnreadIndicator(
                        channel: channel,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLastMessage(String? lastMessage, channel) {
    return BetterStreamBuilder<int>(
      stream: channel.state?.unreadCountStream,
      initialData: channel.state?.unreadCount ?? 0,
      builder: (context, count) {
        return BetterStreamBuilder<Message>(
          stream: channel.state?.lastMessageStream,
          initialData: channel.state?.lastMessage,
          builder: (context, lastMessage) {
            return Text(
              lastMessage.text ?? '',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildLastMessageAt(Channel channel) {
    return BetterStreamBuilder<DateTime>(
      stream: channel.lastMessageAtStream,
      initialData: channel.lastMessageAt,
      builder: (context, data) {
        final lastMessageAt = data.toLocal();
        String stringDate;
        final now = DateTime.now();

        final startOfDay = DateTime(now.year, now.month, now.day);

        if (lastMessageAt.millisecondsSinceEpoch >=
            startOfDay.millisecondsSinceEpoch) {
          stringDate = Jiffy.parseFromDateTime(lastMessageAt.toLocal()).jm;
        } else if (lastMessageAt.millisecondsSinceEpoch >=
            startOfDay
                .subtract(const Duration(days: 1))
                .millisecondsSinceEpoch) {
          stringDate = 'YESTERDAY';
        } else if (startOfDay.difference(lastMessageAt).inDays < 7) {
          stringDate = Jiffy.parseFromDateTime(lastMessageAt.toLocal()).EEEE;
        } else {
          stringDate = Jiffy.parseFromDateTime(lastMessageAt.toLocal()).yMd;
        }
        return Text(
          stringDate,
          style: const TextStyle(
            fontSize: 9,
            letterSpacing: -0.2,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
        );
      },
    );
  }
}
