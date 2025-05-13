import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:stages/widgets/misc/text/night_vibes_text.dart';
import 'package:stages/widgets/misc/text/utils/platform_text_utils.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

/// {@template streamMessageText}
/// The text content of a message.
/// {@endtemplate}
class StreamMessageText extends StatelessWidget {
  /// {@macro streamMessageText}
  const StreamMessageText({
    super.key,
    required this.message,
    required this.messageTheme,
    this.onMentionTap,
    this.onLinkTap,
  });

  /// Message whose text is to be displayed
  final Message message;

  /// The action to perform when a mention is tapped
  final void Function(User)? onMentionTap;

  /// The action to perform when a link is tapped
  final void Function(String)? onLinkTap;

  /// [StreamMessageThemeData] whose text theme is to be applied
  final StreamMessageThemeData messageTheme;

  @override
  Widget build(BuildContext context) {
    final streamChat = StreamChat.of(context);
    assert(streamChat.currentUser != null, '');
    return BetterStreamBuilder<String>(
      stream: streamChat.currentUserStream.map((it) => it!.language ?? 'en'),
      initialData: streamChat.currentUser!.language ?? 'en',
      builder: (context, language) {
        final messageText = message
            .translate(language)
            .replaceMentions()
            .text
            ?.replaceAll('\n', '\n\n')
            .trim();
        final themeData = Theme.of(context);
        final streamChatTheme = StreamChatTheme.of(context);

        return MarkdownBody(
          data: messageText ?? '',
          selectable: isDesktopDeviceOrWeb,
          onTapLink: (
            String link,
            String? href,
            String title,
          ) {
            if (link.startsWith('@')) {
              final mentionedUser = message.mentionedUsers.firstWhereOrNull(
                (u) => '@${u.name}' == link,
              );

              if (mentionedUser == null) return;

              onMentionTap?.call(mentionedUser);
            } else {
              if (onLinkTap != null) {
                onLinkTap!(link);
              } else {
                launchURL(context, link);
              }
            }
          },
          styleSheet: MarkdownStyleSheet.fromTheme(
            themeData.copyWith(
              textTheme: themeData.textTheme.apply(
                bodyColor: messageTheme.messageTextStyle?.color,
                decoration: messageTheme.messageTextStyle?.decoration,
                decorationColor: messageTheme.messageTextStyle?.decorationColor,
                decorationStyle: messageTheme.messageTextStyle?.decorationStyle,
                fontFamily: messageTheme.messageTextStyle?.fontFamily,
              ),
              cardTheme: CardThemeData(
                color: messageTheme.messageBackgroundColor,
              ),
            ),
          ).copyWith(
            a: messageTheme.messageLinksStyle,
            p: messageTheme.messageTextStyle,
            blockquote: TextStyle(
              color: streamChatTheme.colorTheme.textDateDivider,
            ),
            blockquoteDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: streamChatTheme.colorTheme.overlayDark,
            ),
            blockquotePadding: const EdgeInsets.only(
              left: 12,
              right: 12,
              top: 8,
              bottom: 8,
            ),
            em: const TextStyle(
              fontStyle: FontStyle.italic,
              fontFamily: 'CupertinoSystemDisplay',
            ),
          ),
          strutStyleFactory: (style) {
            return PlatformTextUtils.createOptimizedStrutStyle(
                style?.fontSize ?? 16);
          },
          spanFactory: (text, {recognizer, style, semanticsLabel}) {
            return CustomTextSpan(
              text: text,
              recognizer: recognizer,
              style: PlatformTextUtils.optimizeTextStyle(
                  style ?? const TextStyle()),
              semanticsLabel: semanticsLabel,
            );
          },
        );
      },
    );
  }
}
