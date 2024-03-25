import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

/// {@template streamUrlAttachment}
/// Displays a URL attachment in a [StreamMessageWidget].
/// {@endtemplate}
class StreamUrlAttachment extends StatelessWidget {
  /// {@macro streamUrlAttachment}
  const StreamUrlAttachment({
    super.key,
    required this.urlAttachment,
    required this.hostDisplayName,
    required this.messageTheme,
    this.textPadding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
    this.onLinkTap,
  });

  /// Attachment to be displayed
  final Attachment urlAttachment;

  /// Host name
  final String hostDisplayName;

  /// Padding for text
  final EdgeInsets textPadding;

  /// The [StreamMessageThemeData] to use for the image title
  final StreamMessageThemeData messageTheme;

  /// The function called when tapping on a link
  final void Function(String)? onLinkTap;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 200,
        minWidth: 200,
      ),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            final ogScrapeUrl = urlAttachment.ogScrapeUrl;
            if (ogScrapeUrl != null) {
              onLinkTap != null
                  ? onLinkTap!(ogScrapeUrl)
                  : launchURL(context, ogScrapeUrl);
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (urlAttachment.imageUrl != null)
                Container(
                  clipBehavior: Clip.hardEdge,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: CachedNetworkImage(
                    imageUrl: urlAttachment.imageUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
              Padding(
                padding: textPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (urlAttachment.title != null)
                      Text(
                        urlAttachment.title!.trim(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: messageTheme.messageTextStyle
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    if (urlAttachment.text != null)
                      Text(
                        urlAttachment.text!,
                        style: messageTheme.messageTextStyle
                            ?.copyWith(fontWeight: FontWeight.w400),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
