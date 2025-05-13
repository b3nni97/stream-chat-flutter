import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

/// {@template unreadMessagesSeparator}
/// {@endtemplate}
class UnreadMessagesSeparator extends StatelessWidget {
  /// {@macro unreadMessagesSeparator}
  const UnreadMessagesSeparator({
    super.key,
    required this.unreadCount,
  });

  /// Number of unread messages.
  final int unreadCount;

  @override
  Widget build(BuildContext context) {
    final chatThemeData = StreamChatTheme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        children: [
          Flexible(
            child: Container(
              height: 1,
              color: chatThemeData.ownMessageTheme.createdAtStyle?.color,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Text(
              context.translations.unreadMessagesSeparatorText(
                unreadCount,
              ),
              textAlign: TextAlign.center,
              style: chatThemeData.ownMessageTheme.createdAtStyle?.copyWith(
                fontSize: 14,
              ),
            ),
          ),
          Flexible(
            child: Container(
              height: 1,
              color: chatThemeData.ownMessageTheme.createdAtStyle?.color,
            ),
          ),
        ],
      ),
    );
  }
}
