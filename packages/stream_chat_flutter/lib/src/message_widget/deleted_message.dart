import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/src/message_widget/text_bubble/text_bubble_container.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

/// {@template streamDeletedMessage}
/// Displays that a message was deleted at this position in the message list.
/// {@endtemplate}
class StreamDeletedMessage extends StatelessWidget {
  /// {@macro streamDeletedMessage}
  const StreamDeletedMessage({
    super.key,
    required this.messageTheme,
    this.borderRadiusGeometry,
    this.shape,
    this.borderSide,
    this.reverse = false,
  });

  /// The theme of the message
  final StreamMessageThemeData messageTheme;

  /// The border radius of the message text
  final BorderRadiusGeometry? borderRadiusGeometry;

  /// The shape of the message text
  final ShapeBorder? shape;

  /// The [BorderSide] of the message text
  final BorderSide? borderSide;

  /// If true the widget will be mirrored
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    return TextBubbleContainer(
      backgroundColor: messageTheme.messageBackgroundColor ?? Colors.black,
      reverse: reverse,
      child: Container(
        margin: EdgeInsets.only(
          left: reverse ? 0 : 6,
          right: reverse ? 6 : 0,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          child: Text(
            context.translations.messageDeletedLabel,
            style: messageTheme.messageTextStyle?.copyWith(
              fontStyle: FontStyle.italic,
              color: messageTheme.createdAtStyle?.color,
            ),
          ),
        ),
      ),
    );
  }
}
