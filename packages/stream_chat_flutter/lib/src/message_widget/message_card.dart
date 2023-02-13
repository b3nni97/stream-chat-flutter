import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stages/widgets/layout/rebuild_once.dart';
import 'package:stream_chat_flutter/src/message_widget/text_bubble/text_bubble_container.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

/// {@template messageCard}
/// The widget containing a quoted message.
///
/// Used in [MessageWidgetContent]. Should not be used elsewhere.
/// {@endtemplate}
class MessageCard extends StatefulWidget {
  /// {@macro messageCard}
  const MessageCard({
    super.key,
    required this.message,
    required this.isFailedState,
    required this.showUserAvatar,
    required this.messageTheme,
    required this.hasQuotedMessage,
    required this.hasUrlAttachments,
    required this.hasNonUrlAttachments,
    required this.isOnlyEmoji,
    required this.isGiphy,
    required this.attachmentBuilders,
    required this.attachmentPadding,
    required this.textPadding,
    required this.reverse,
    this.shape,
    this.borderSide,
    this.borderRadiusGeometry,
    this.textBuilder,
    this.onLinkTap,
    this.onMentionTap,
    this.onQuotedMessageTap,
  });

  /// {@macro isFailedState}
  final bool isFailedState;

  /// {@macro showUserAvatar}
  final DisplayWidget showUserAvatar;

  /// {@macro shape}
  final ShapeBorder? shape;

  /// {@macro borderSide}
  final BorderSide? borderSide;

  /// {@macro messageTheme}
  final StreamMessageThemeData messageTheme;

  /// {@macro borderRadiusGeometry}
  final BorderRadiusGeometry? borderRadiusGeometry;

  /// {@macro hasQuotedMessage}
  final bool hasQuotedMessage;

  /// {@macro hasUrlAttachments}
  final bool hasUrlAttachments;

  /// {@macro hasNonUrlAttachments}
  final bool hasNonUrlAttachments;

  /// {@macro isOnlyEmoji}
  final bool isOnlyEmoji;

  /// {@macro isGiphy}
  final bool isGiphy;

  /// {@macro message}
  final Message message;

  /// {@macro attachmentBuilders}
  final Map<String, AttachmentBuilder> attachmentBuilders;

  /// {@macro attachmentPadding}
  final EdgeInsetsGeometry attachmentPadding;

  /// {@macro textPadding}
  final EdgeInsets textPadding;

  /// {@macro textBuilder}
  final Widget Function(BuildContext, Message)? textBuilder;

  /// {@macro onLinkTap}
  final void Function(String)? onLinkTap;

  /// {@macro onMentionTap}
  final void Function(User)? onMentionTap;

  /// {@macro onQuotedMessageTap}
  final OnQuotedMessageTap? onQuotedMessageTap;

  /// {@macro reverse}
  final bool reverse;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  final GlobalKey attachmentsKey = GlobalKey();
  final GlobalKey linksKey = GlobalKey();
  double? widthLimit;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final attachmentsRenderBox =
          attachmentsKey.currentContext?.findRenderObject() as RenderBox?;
      final attachmentsWidth = attachmentsRenderBox?.size.width;

      final linkRenderBox =
          linksKey.currentContext?.findRenderObject() as RenderBox?;
      final linkWidth = linkRenderBox?.size.width;

      if (mounted) {
        setState(() {
          if (attachmentsWidth != null && linkWidth != null) {
            widthLimit = max(attachmentsWidth, linkWidth);
          } else {
            widthLimit = attachmentsWidth ?? linkWidth;
          }
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isRoundMessage = _isRadiusRound(
      widget.borderRadiusGeometry?.resolve(TextDirection.ltr) ??
          BorderRadius.zero,
    );

    Widget content = ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: widthLimit ?? double.infinity,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.hasQuotedMessage)
            QuotedMessage(
              reverse: widget.reverse,
              message: widget.message,
              hasNonUrlAttachments: widget.hasNonUrlAttachments,
              onQuotedMessageTap: widget.onQuotedMessageTap,
            ),
          if (widget.hasNonUrlAttachments)
            ParseAttachments(
              key: attachmentsKey,
              message: widget.message,
              attachmentBuilders: widget.attachmentBuilders,
              attachmentPadding: widget.attachmentPadding,
            ),
          if (!widget.isGiphy)
            ConstrainedBox(
              constraints: BoxConstraints.loose(const Size.fromWidth(500)),
              child: TextBubble(
                messageTheme: widget.messageTheme,
                message: widget.message,
                textPadding: widget.textPadding,
                textBuilder: widget.textBuilder,
                isOnlyEmoji: widget.isOnlyEmoji,
                hasQuotedMessage: widget.hasQuotedMessage,
                hasUrlAttachments: widget.hasUrlAttachments,
                onLinkTap: widget.onLinkTap,
                onMentionTap: widget.onMentionTap,
              ),
            ),
          if (widget.hasUrlAttachments && !widget.hasQuotedMessage)
            _buildUrlAttachment(),
        ],
      ),
    );

    if (!isRoundMessage) {
      content = TextBubbleContainer(
        backgroundColor: _getBackgroundColor() ?? Colors.transparent,
        reverse: widget.reverse,
        child: Container(
          margin: EdgeInsets.only(
            left: widget.reverse ? 0 : 6,
            right: widget.reverse ? 6 : 0,
          ),
          child: content,
        ),
      );
    } else {
      content = Container(
        margin: EdgeInsets.only(
          left: widget.reverse ? 0 : 6,
          right: widget.reverse ? 6 : 0,
        ),
        decoration: BoxDecoration(
          borderRadius: widget.borderRadiusGeometry,
          color: _getBackgroundColor(),
        ),
        child: content,
      );
    }

    return RebuildOnce(
      key: ValueKey(widget.message.text),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: (widget.isFailedState ? 15.0 : 0.0) +
              (widget.showUserAvatar == DisplayWidget.gone ? 0 : 4.0),
        ),
        child: content,
      ),
    );
  }

  bool _isRadiusRound(BorderRadius radius) {
    return radius.topLeft == radius.topRight &&
        radius.bottomLeft == radius.bottomRight;
  }

  Widget _buildUrlAttachment() {
    final urlAttachment = widget.message.attachments
        .firstWhere((element) => element.titleLink != null);

    final host = Uri.parse(urlAttachment.titleLink!).host;
    final splitList = host.split('.');
    final hostName = splitList.length == 3 ? splitList[1] : splitList[0];
    final hostDisplayName = urlAttachment.authorName?.capitalize() ??
        getWebsiteName(hostName.toLowerCase()) ??
        hostName.capitalize();

    return StreamUrlAttachment(
      key: linksKey,
      urlAttachment: urlAttachment,
      hostDisplayName: hostDisplayName,
      textPadding: widget.textPadding,
      messageTheme: widget.messageTheme,
    );
  }

  Color? _getBackgroundColor() {
    if (widget.hasQuotedMessage) {
      return widget.messageTheme.messageBackgroundColor;
    }

    if (widget.hasUrlAttachments) {
      return widget.messageTheme.linkBackgroundColor;
    }

    if (widget.isOnlyEmoji) {
      return Colors.transparent;
    }

    if (widget.isGiphy) {
      return widget.messageTheme.messageBackgroundColor;
    }

    return widget.messageTheme.messageBackgroundColor;
  }
}
