import 'dart:async';

import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:contextmenu/contextmenu.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ButtonStyle;
import 'package:flutter/services.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:night_vibes_context_menu/night_vibes_context_menu.dart';
import 'package:night_vibes_context_menu/night_vibes_context_menu_action.dart';
import 'package:night_vibes_context_menu/night_vibes_context_menu_controller.dart';
import 'package:stages/generated/locale_keys.g.dart';
import 'package:stages/widgets/animation/routes/context_menu.dart';
import 'package:stages/widgets/layout/freeze_media_query_wrapper.dart';
import 'package:stages/widgets/layout/rebuild_once.dart';
import 'package:stages/widgets/misc/async_helper.dart';
import 'package:stages/widgets/notification/local_notifications.dart';
import 'package:stream_chat_flutter/conditional_parent_builder/conditional_parent_builder.dart';
import 'package:stream_chat_flutter/platform_widget_builder/platform_widget_builder.dart';
import 'package:stream_chat_flutter/src/context_menu_items/context_menu_reaction_picker.dart';
import 'package:stream_chat_flutter/src/context_menu_items/stream_chat_context_menu_item.dart';
import 'package:stream_chat_flutter/src/dialogs/dialogs.dart';
import 'package:stream_chat_flutter/src/message_actions_modal/message_actions_modal.dart';
import 'package:stream_chat_flutter/src/message_widget/message_widget_content.dart';
import 'package:stream_chat_flutter/src/message_widget/reactions/message_reactions_modal.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

/// The display behaviour of a widget
enum DisplayWidget {
  /// Hides the widget replacing its space with a spacer
  hide,

  /// Hides the widget not replacing its space
  gone,

  /// Shows the widget normally
  show,
}

/// {@template messageWidget}
/// ![screenshot](https://raw.githubusercontent.com/GetStream/stream-chat-flutter/master/packages/stream_chat_flutter/screenshots/message_widget.png)
/// ![screenshot](https://raw.githubusercontent.com/GetStream/stream-chat-flutter/master/packages/stream_chat_flutter/screenshots/message_widget_paint.png)
///
/// Shows a message with reactions, replies and user avatar.
///
/// Usually you don't use this widget as it's the default message widget used by
/// [MessageListView].
///
/// The widget components render the ui based on the first ancestor of type
/// [StreamChatTheme].
/// Modify it to change the widget appearance.
/// {@endtemplate}
class StreamMessageWidget extends StatefulWidget {
  /// {@macro messageWidget}
  StreamMessageWidget({
    super.key,
    required this.message,
    required this.messageTheme,
    this.reverse = false,
    this.translateUserAvatar = true,
    this.shape,
    this.attachmentShape,
    this.borderSide,
    this.attachmentBorderSide,
    this.borderRadiusGeometry,
    this.attachmentBorderRadiusGeometry,
    this.onMentionTap,
    this.onMessageTap,
    this.showReactionPickerIndicator = false,
    this.reactionPickerIndicatorKey,
    this.reactionsKey,
    this.showUserAvatar = DisplayWidget.show,
    this.showSendingIndicator = true,
    this.showThreadReplyIndicator = false,
    this.showInChannelIndicator = false,
    this.onReplyTap,
    this.onThreadTap,
    this.showUsername = true,
    this.showTimestamp = true,
    this.showReactions = true,
    this.showDeleteMessage = true,
    this.showEditMessage = true,
    this.showReplyMessage = true,
    this.showThreadReplyMessage = true,
    this.showResendMessage = true,
    this.showCopyMessage = true,
    this.showFlagButton = true,
    this.showPinButton = true,
    this.showPinHighlight = true,
    this.onUserAvatarTap,
    this.onLinkTap,
    this.onMessageActions,
    this.onShowMessage,
    this.userAvatarBuilder,
    this.editMessageInputBuilder,
    this.textBuilder,
    this.bottomRowBuilder,
    this.deletedBottomRowBuilder,
    this.customAttachmentBuilders,
    this.padding,
    this.textPadding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
    this.attachmentPadding = EdgeInsets.zero,
    this.onQuotedMessageTap,
    this.customActions = const [],
    this.onAttachmentTap,
    this.usernameBuilder,
    this.imageAttachmentThumbnailSize = const Size(400, 400),
    this.imageAttachmentThumbnailResizeType = 'clip',
    this.imageAttachmentThumbnailCropType = 'center',
    this.hideBottomRow = false,
    this.enableContextMenu = true,
    this.contextMenuController,
    this.freezeMediaQueryController,
    this.profileAssetBuilder,
    this.showLoading,
    this.enableMessageContainer = true,
    this.useIntrinsicSize = false,
  }) : attachmentBuilders = {
          'image': (context, message, attachments) {
            final border = RoundedRectangleBorder(
              side: attachmentBorderSide ??
                  BorderSide(
                    color: StreamChatTheme.of(context).colorTheme.borders,
                  ),
              borderRadius: attachmentBorderRadiusGeometry ?? BorderRadius.zero,
            );

            final mediaSize = MediaQuery.sizeOf(context);
            if (attachments.length > 1) {
              return Padding(
                padding: attachmentPadding,
                child: WrapAttachmentWidget(
                  attachmentWidget: Material(
                    color: messageTheme.messageBackgroundColor,
                    child: StreamImageGroup(
                      constraints: BoxConstraints(
                        maxWidth: 400,
                        minWidth: 400,
                        maxHeight: mediaSize.height * 0.3,
                      ),
                      images: attachments,
                      message: message,
                      messageTheme: messageTheme,
                      onShowMessage: onShowMessage,
                      onReplyMessage: onReplyTap,
                      onAttachmentTap: onAttachmentTap,
                      imageThumbnailSize: imageAttachmentThumbnailSize,
                      imageThumbnailResizeType:
                          imageAttachmentThumbnailResizeType,
                      imageThumbnailCropType: imageAttachmentThumbnailCropType,
                    ),
                  ),
                  attachmentShape: border,
                ),
              );
            }

            return WrapAttachmentWidget(
              attachmentWidget: StreamImageAttachment(
                attachment: attachments[0],
                message: message,
                messageTheme: messageTheme,
                constraints: BoxConstraints(
                  maxWidth: 400,
                  minWidth: 400,
                  maxHeight: mediaSize.height * 0.3,
                ),
                onShowMessage: onShowMessage,
                onReplyMessage: onReplyTap,
                onAttachmentTap: onAttachmentTap != null
                    ? () {
                        onAttachmentTap.call(message, attachments[0]);
                      }
                    : null,
                imageThumbnailSize: imageAttachmentThumbnailSize,
                imageThumbnailResizeType: imageAttachmentThumbnailResizeType,
                imageThumbnailCropType: imageAttachmentThumbnailCropType,
              ),
              attachmentShape: border,
            );
          },
          'video': (context, message, attachments) {
            final border = RoundedRectangleBorder(
              side: attachmentBorderSide ??
                  BorderSide(
                    color: StreamChatTheme.of(context).colorTheme.borders,
                  ),
              borderRadius: attachmentBorderRadiusGeometry ?? BorderRadius.zero,
            );

            return WrapAttachmentWidget(
              attachmentWidget: Column(
                children: attachments.map((attachment) {
                  final mediaSize = MediaQuery.sizeOf(context);

                  return StreamVideoAttachment(
                    attachment: attachment,
                    messageTheme: messageTheme,
                    constraints: BoxConstraints(
                      maxWidth: 400,
                      minWidth: 400,
                      maxHeight: mediaSize.height * 0.3,
                    ),
                    message: message,
                    onShowMessage: onShowMessage,
                    onReplyMessage: onReplyTap,
                    onAttachmentTap: onAttachmentTap != null
                        ? () {
                            onAttachmentTap(message, attachment);
                          }
                        : null,
                  );
                }).toList(),
              ),
              attachmentShape: border,
            );
          },
          'giphy': (context, message, attachments) {
            final border = RoundedRectangleBorder(
              side: attachmentBorderSide ??
                  BorderSide(
                    color: StreamChatTheme.of(context).colorTheme.borders,
                  ),
              borderRadius: attachmentBorderRadiusGeometry ?? BorderRadius.zero,
            );

            return WrapAttachmentWidget(
              attachmentWidget: Column(
                children: attachments.map((attachment) {
                  final mediaSize = MediaQuery.sizeOf(context);
                  return StreamGiphyAttachment(
                    attachment: attachment,
                    message: message,
                    constraints: BoxConstraints(
                      maxWidth: 400,
                      minWidth: 400,
                      maxHeight: mediaSize.height * 0.3,
                    ),
                    onShowMessage: onShowMessage,
                    onReplyMessage: onReplyTap,
                    onAttachmentTap: onAttachmentTap != null
                        ? () {
                            onAttachmentTap(message, attachment);
                          }
                        : null,
                  );
                }).toList(),
              ),
              attachmentShape: border,
            );
          },
          'file': (context, message, attachments) {
            final border = RoundedRectangleBorder(
              side: attachmentBorderSide ??
                  BorderSide(
                    color: StreamChatTheme.of(context).colorTheme.borders,
                  ),
              borderRadius: attachmentBorderRadiusGeometry ?? BorderRadius.zero,
            );

            return Column(
              children: attachments
                  .map<Widget>((attachment) {
                    final mediaSize = MediaQuery.sizeOf(context);
                    return WrapAttachmentWidget(
                      attachmentWidget: StreamFileAttachment(
                        message: message,
                        attachment: attachment,
                        constraints: BoxConstraints(
                          maxWidth: 400,
                          minWidth: 400,
                          maxHeight: mediaSize.height * 0.3,
                        ),
                        onAttachmentTap: onAttachmentTap != null
                            ? () {
                                onAttachmentTap(message, attachment);
                              }
                            : null,
                      ),
                      attachmentShape: border,
                    );
                  })
                  .insertBetween(SizedBox(
                    height: attachmentPadding.vertical / 2,
                  ))
                  .toList(),
            );
          },
        }..addAll(customAttachmentBuilders ?? {});

  /// {@template onMentionTap}
  /// Function called on mention tap
  /// {@endtemplate}
  final void Function(User)? onMentionTap;

  /// {@template onThreadTap}
  /// The function called when tapping on threads
  /// {@endtemplate}
  final void Function(Message)? onThreadTap;

  /// {@template onReplyTap}
  /// The function called when tapping on replies
  /// {@endtemplate}
  final void Function(Message)? onReplyTap;

  /// {@template editMessageInputBuilder}
  /// Widget builder for edit message layout
  /// {@endtemplate}
  final EditMessageInputBuilder? editMessageInputBuilder;

  /// {@template textBuilder}
  /// Widget builder for building text
  /// {@endtemplate}
  final Widget Function(BuildContext, Message)? textBuilder;

  /// {@template usernameBuilder}
  /// Widget builder for building username
  /// {@endtemplate}
  final Widget Function(BuildContext, Message)? usernameBuilder;

  /// {@template onMessageActions}
  /// Function called on long press
  /// {@endtemplate}
  final void Function(BuildContext, Message)? onMessageActions;

  /// {@template bottomRowBuilder}
  /// Widget builder for building a bottom row below the message
  /// {@endtemplate}
  final Widget Function(BuildContext, Message)? bottomRowBuilder;

  /// {@template deletedBottomRowBuilder}
  /// Widget builder for building a bottom row below a deleted message
  /// {@endtemplate}
  final Widget Function(BuildContext, Message)? deletedBottomRowBuilder;

  /// {@template userAvatarBuilder}
  /// Widget builder for building user avatar
  /// {@endtemplate}
  final Widget Function(BuildContext, User)? userAvatarBuilder;

  /// {@template message}
  /// The message to display.
  /// {@endtemplate}
  final Message message;

  /// {@template messageTheme}
  /// The message theme
  /// {@endtemplate}
  final StreamMessageThemeData messageTheme;

  /// {@template reverse}
  /// If true the widget will be mirrored
  /// {@endtemplate}
  final bool reverse;

  /// {@template shape}
  /// The shape of the message text
  /// {@endtemplate}
  final ShapeBorder? shape;

  /// {@template attachmentShape}
  /// The shape of an attachment
  /// {@endtemplate}
  final ShapeBorder? attachmentShape;

  /// {@template borderSide}
  /// The borderSide of the message text
  /// {@endtemplate}
  final BorderSide? borderSide;

  /// {@template attachmentBorderSide}
  /// The borderSide of an attachment
  /// {@endtemplate}
  final BorderSide? attachmentBorderSide;

  /// {@template borderRadiusGeometry}
  /// The border radius of the message text
  /// {@endtemplate}
  final BorderRadiusGeometry? borderRadiusGeometry;

  /// {@template attachmentBorderRadiusGeometry}
  /// The border radius of an attachment
  /// {@endtemplate}
  final BorderRadiusGeometry? attachmentBorderRadiusGeometry;

  /// {@template padding}
  /// The padding of the widget
  /// {@endtemplate}
  final EdgeInsetsGeometry? padding;

  /// {@template textPadding}
  /// The internal padding of the message text
  /// {@endtemplate}
  final EdgeInsets textPadding;

  /// {@template attachmentPadding}
  /// The internal padding of an attachment
  /// {@endtemplate}
  final EdgeInsetsGeometry attachmentPadding;

  /// {@template showUserAvatar}
  /// It controls the display behaviour of the user avatar
  /// {@endtemplate}
  final DisplayWidget showUserAvatar;

  /// {@template showSendingIndicator}
  /// It controls the display behaviour of the sending indicator
  /// {@endtemplate}
  final bool showSendingIndicator;

  /// {@template showReactions}
  /// If `true` the message's reactions will be shown.
  /// {@endtemplate}
  final bool showReactions;

  /// {@template showThreadReplyIndicator}
  /// If true the widget will show the thread reply indicator
  /// {@endtemplate}
  final bool showThreadReplyIndicator;

  /// {@template showInChannelIndicator}
  /// If true the widget will show the show in channel indicator
  /// {@endtemplate}
  final bool showInChannelIndicator;

  /// {@template onUserAvatarTap}
  /// The function called when tapping on UserAvatar
  /// {@endtemplate}
  final void Function(User)? onUserAvatarTap;

  /// {@template onLinkTap}
  /// The function called when tapping on a link
  /// {@endtemplate}
  final void Function(String)? onLinkTap;

  /// {@template showReactionPickerIndicator}
  /// Used in [StreamMessageReactionsModal] and [MessageActionsModal]
  /// {@endtemplate}
  final bool showReactionPickerIndicator;

  /// Provide a GlobalKey for the reaction picker indicator to get its location
  final GlobalKey? reactionPickerIndicatorKey;

  /// Provide a GlobalKey for the reaction picker
  final GlobalKey? reactionsKey;

  /// {@template onShowMessage}
  /// Callback when show message is tapped
  /// {@endtemplate}
  final ShowMessageCallback? onShowMessage;

  /// {@template showUsername}
  /// If true show the users username next to the timestamp of the message
  /// {@endtemplate}
  final bool showUsername;

  /// {@template showTimestamp}
  /// Show message timestamp
  /// {@endtemplate}
  final bool showTimestamp;

  /// {@template showReplyMessage}
  /// Show reply action
  /// {@endtemplate}
  final bool showReplyMessage;

  /// {@template showThreadReplyMessage}
  /// Show thread reply action
  /// {@endtemplate}
  final bool showThreadReplyMessage;

  /// {@template showEditMessage}
  /// Show edit action
  /// {@endtemplate}
  final bool showEditMessage;

  /// {@template showCopyMessage}
  /// Show copy action
  /// {@endtemplate}
  final bool showCopyMessage;

  /// {@template showDeleteMessage}
  /// Show delete action
  /// {@endtemplate}
  final bool showDeleteMessage;

  /// {@template showResendMessage}
  /// Show resend action
  /// {@endtemplate}
  final bool showResendMessage;

  /// {@template showFlagButton}
  /// Show flag action
  /// {@endtemplate}
  final bool showFlagButton;

  /// {@template showPinButton}
  /// Show pin action
  /// {@endtemplate}
  final bool showPinButton;

  /// {@template showPinHighlight}
  /// Display Pin Highlight
  /// {@endtemplate}
  final bool showPinHighlight;

  /// {@template attachmentBuilders}
  /// Builder for respective attachment types
  /// {@endtemplate}
  final Map<String, AttachmentBuilder> attachmentBuilders;

  /// {@template customAttachmentBuilders}
  /// Builder for respective attachment types (user facing builder)
  /// {@endtemplate}
  final Map<String, AttachmentBuilder>? customAttachmentBuilders;

  /// {@template translateUserAvatar}
  /// Center user avatar with bottom of the message
  /// {@endtemplate}
  final bool translateUserAvatar;

  /// {@macro onQuotedMessageTap}
  final OnQuotedMessageTap? onQuotedMessageTap;

  /// {@macro onMessageTap}
  final void Function(Message)? onMessageTap;

  /// {@template customActions}
  /// List of custom actions shown on message long tap
  /// {@endtemplate}
  final List<StreamMessageAction> customActions;

  /// {@macro onMessageWidgetAttachmentTap}
  final OnMessageWidgetAttachmentTap? onAttachmentTap;

  /// Size of the image attachment thumbnail.
  final Size imageAttachmentThumbnailSize;

  /// Resize type of the image attachment thumbnail.
  ///
  /// Defaults to [crop]
  final String /*clip|crop|scale|fill*/ imageAttachmentThumbnailResizeType;

  /// Crop type of the image attachment thumbnail.
  ///
  /// Defaults to [center]
  final String /*center|top|bottom|left|right*/
      imageAttachmentThumbnailCropType;

  /// Forcefully hide the bottom row which normally shows timestamp and sending indicator
  final bool hideBottomRow;

  /// Enable / Disable context menu
  final bool enableContextMenu;

  /// Provide context menu controller
  final NightVibesContextMenuController? contextMenuController;

  /// Provide freeze media query controller
  final FreezeMediaQueryController? freezeMediaQueryController;

  /// When the channel is a group we show the profile assets of the user if this
  /// is set
  final Widget Function(BuildContext, Message, bool show)? profileAssetBuilder;

  // Wether the StreamChannel should show a loading indicator.
  final bool? showLoading;

  /// Enables the colored text bubbles or rounded bubbles around
  /// messages.
  final bool enableMessageContainer;

  /// Enables wether or not to use a [IntrinsicWidth] widget to size
  /// the messages horizontally.
  final bool useIntrinsicSize;

  /// {@template copyWith}
  /// Creates a copy of [StreamMessageWidget] with specified attributes
  /// overridden.
  /// {@endtemplate}
  StreamMessageWidget copyWith({
    Key? key,
    void Function(User)? onMentionTap,
    void Function(Message)? onThreadTap,
    void Function(Message)? onReplyTap,
    EditMessageInputBuilder? editMessageInputBuilder,
    Widget Function(BuildContext, Message)? textBuilder,
    Widget Function(BuildContext, Message)? usernameBuilder,
    Widget Function(BuildContext, Message)? bottomRowBuilder,
    Widget Function(BuildContext, Message)? deletedBottomRowBuilder,
    void Function(BuildContext, Message)? onMessageActions,
    Message? message,
    StreamMessageThemeData? messageTheme,
    bool? reverse,
    ShapeBorder? shape,
    ShapeBorder? attachmentShape,
    BorderSide? borderSide,
    BorderSide? attachmentBorderSide,
    BorderRadiusGeometry? borderRadiusGeometry,
    BorderRadiusGeometry? attachmentBorderRadiusGeometry,
    EdgeInsetsGeometry? padding,
    EdgeInsets? textPadding,
    EdgeInsetsGeometry? attachmentPadding,
    DisplayWidget? showUserAvatar,
    bool? showSendingIndicator,
    bool? showReactions,
    bool? allRead,
    bool? showThreadReplyIndicator,
    bool? showInChannelIndicator,
    void Function(User)? onUserAvatarTap,
    void Function(String)? onLinkTap,
    bool? showReactionPickerIndicator,
    GlobalKey? reactionPickerIndicatorKey,
    GlobalKey? reactionsKey,
    List<Read>? readList,
    ShowMessageCallback? onShowMessage,
    bool? showUsername,
    bool? showTimestamp,
    bool? showReplyMessage,
    bool? showThreadReplyMessage,
    bool? showEditMessage,
    bool? showCopyMessage,
    bool? showDeleteMessage,
    bool? showResendMessage,
    bool? showFlagButton,
    bool? showPinButton,
    bool? showPinHighlight,
    Map<String, AttachmentBuilder>? customAttachmentBuilders,
    bool? translateUserAvatar,
    OnQuotedMessageTap? onQuotedMessageTap,
    void Function(Message)? onMessageTap,
    List<StreamMessageAction>? customActions,
    void Function(Message message, Attachment attachment)? onAttachmentTap,
    Widget Function(BuildContext, User)? userAvatarBuilder,
    Size? imageAttachmentThumbnailSize,
    String? imageAttachmentThumbnailResizeType,
    String? imageAttachmentThumbnailCropType,
    bool? hideBottomRow,
    bool? enableContextMenu,
    NightVibesContextMenuController? contextMenuController,
    FreezeMediaQueryController? freezeMediaQueryController,
    Widget Function(BuildContext, Message, bool)? profileAssetBuilder,
    bool? showLoading,
    bool? enableMessageContainer,
    bool? useIntrinsicSize,
  }) {
    return StreamMessageWidget(
      key: key ?? this.key,
      onMentionTap: onMentionTap ?? this.onMentionTap,
      onThreadTap: onThreadTap ?? this.onThreadTap,
      onReplyTap: onReplyTap ?? this.onReplyTap,
      editMessageInputBuilder:
          editMessageInputBuilder ?? this.editMessageInputBuilder,
      textBuilder: textBuilder ?? this.textBuilder,
      usernameBuilder: usernameBuilder ?? this.usernameBuilder,
      bottomRowBuilder: bottomRowBuilder ?? this.bottomRowBuilder,
      deletedBottomRowBuilder:
          deletedBottomRowBuilder ?? this.deletedBottomRowBuilder,
      onMessageActions: onMessageActions ?? this.onMessageActions,
      message: message ?? this.message,
      messageTheme: messageTheme ?? this.messageTheme,
      reverse: reverse ?? this.reverse,
      shape: shape ?? this.shape,
      attachmentShape: attachmentShape ?? this.attachmentShape,
      borderSide: borderSide ?? this.borderSide,
      attachmentBorderSide: attachmentBorderSide ?? this.attachmentBorderSide,
      borderRadiusGeometry: borderRadiusGeometry ?? this.borderRadiusGeometry,
      attachmentBorderRadiusGeometry:
          attachmentBorderRadiusGeometry ?? this.attachmentBorderRadiusGeometry,
      padding: padding ?? this.padding,
      textPadding: textPadding ?? this.textPadding,
      attachmentPadding: attachmentPadding ?? this.attachmentPadding,
      showUserAvatar: showUserAvatar ?? this.showUserAvatar,
      showSendingIndicator: showSendingIndicator ?? this.showSendingIndicator,
      showReactions: showReactions ?? this.showReactions,
      showThreadReplyIndicator:
          showThreadReplyIndicator ?? this.showThreadReplyIndicator,
      showInChannelIndicator:
          showInChannelIndicator ?? this.showInChannelIndicator,
      onUserAvatarTap: onUserAvatarTap ?? this.onUserAvatarTap,
      onLinkTap: onLinkTap ?? this.onLinkTap,
      showReactionPickerIndicator:
          showReactionPickerIndicator ?? this.showReactionPickerIndicator,
      reactionPickerIndicatorKey:
          reactionPickerIndicatorKey ?? this.reactionPickerIndicatorKey,
      reactionsKey: reactionsKey ?? this.reactionsKey,
      onShowMessage: onShowMessage ?? this.onShowMessage,
      showUsername: showUsername ?? this.showUsername,
      showTimestamp: showTimestamp ?? this.showTimestamp,
      showReplyMessage: showReplyMessage ?? this.showReplyMessage,
      showThreadReplyMessage:
          showThreadReplyMessage ?? this.showThreadReplyMessage,
      showEditMessage: showEditMessage ?? this.showEditMessage,
      showCopyMessage: showCopyMessage ?? this.showCopyMessage,
      showDeleteMessage: showDeleteMessage ?? this.showDeleteMessage,
      showResendMessage: showResendMessage ?? this.showResendMessage,
      showFlagButton: showFlagButton ?? this.showFlagButton,
      showPinButton: showPinButton ?? this.showPinButton,
      showPinHighlight: showPinHighlight ?? this.showPinHighlight,
      customAttachmentBuilders:
          customAttachmentBuilders ?? this.customAttachmentBuilders,
      translateUserAvatar: translateUserAvatar ?? this.translateUserAvatar,
      onQuotedMessageTap: onQuotedMessageTap ?? this.onQuotedMessageTap,
      onMessageTap: onMessageTap ?? this.onMessageTap,
      customActions: customActions ?? this.customActions,
      onAttachmentTap: onAttachmentTap ?? this.onAttachmentTap,
      userAvatarBuilder: userAvatarBuilder ?? this.userAvatarBuilder,
      imageAttachmentThumbnailSize:
          imageAttachmentThumbnailSize ?? this.imageAttachmentThumbnailSize,
      imageAttachmentThumbnailResizeType: imageAttachmentThumbnailResizeType ??
          this.imageAttachmentThumbnailResizeType,
      imageAttachmentThumbnailCropType: imageAttachmentThumbnailCropType ??
          this.imageAttachmentThumbnailCropType,
      hideBottomRow: hideBottomRow ?? this.hideBottomRow,
      enableContextMenu: enableContextMenu ?? this.enableContextMenu,
      contextMenuController:
          contextMenuController ?? this.contextMenuController,
      freezeMediaQueryController:
          freezeMediaQueryController ?? this.freezeMediaQueryController,
      profileAssetBuilder: profileAssetBuilder ?? this.profileAssetBuilder,
      showLoading: showLoading ?? this.showLoading,
      enableMessageContainer:
          enableMessageContainer ?? this.enableMessageContainer,
      useIntrinsicSize: useIntrinsicSize ?? this.useIntrinsicSize,
    );
  }

  @override
  _StreamMessageWidgetState createState() => _StreamMessageWidgetState();
}

class _StreamMessageWidgetState extends State<StreamMessageWidget>
    with AutomaticKeepAliveClientMixin<StreamMessageWidget> {
  bool get showThreadReplyIndicator => widget.showThreadReplyIndicator;

  bool get showSendingIndicator => widget.showSendingIndicator;

  bool get isDeleted => widget.message.isDeleted;

  bool get showUsername => widget.showUsername;

  bool get showTimeStamp => widget.showTimestamp;

  bool get showInChannel => widget.showInChannelIndicator;

  /// {@template hasQuotedMessage}
  /// `true` if [StreamMessageWidget.quotedMessage] is not null.
  /// {@endtemplate}
  bool get hasQuotedMessage => widget.message.quotedMessage != null;

  bool get isSendFailed => widget.message.status == MessageSendingStatus.failed;

  bool get isUpdateFailed =>
      widget.message.status == MessageSendingStatus.failed_update;

  bool get isDeleteFailed =>
      widget.message.status == MessageSendingStatus.failed_delete;

  /// {@template isFailedState}
  /// Whether the message has failed to be sent, updated, or deleted.
  /// {@endtemplate}
  bool get isFailedState => isSendFailed || isUpdateFailed || isDeleteFailed;

  /// {@template isGiphy}
  /// `true` if any of the [message]'s attachments are a giphy.
  /// {@endtemplate}
  bool get isGiphy =>
      widget.message.attachments.any((element) => element.type == 'giphy');

  /// {@template isOnlyEmoji}
  /// `true` if [message.text] contains only emoji.
  /// {@endtemplate}
  bool get isOnlyEmoji => widget.message.text?.isOnlyEmoji == true;

  /// {@template hasNonUrlAttachments}
  /// `true` if any of the [message]'s attachments are a giphy and do not
  /// have a [Attachment.titleLink].
  /// {@endtemplate}
  bool get hasNonUrlAttachments => widget.message.attachments
      .where((it) => it.titleLink == null || it.type == 'giphy')
      .isNotEmpty;

  /// {@template hasUrlAttachments}
  /// `true` if any of the [message]'s attachments are a giphy with a
  /// [Attachment.titleLink].
  /// {@endtemplate}
  bool get hasUrlAttachments => widget.message.attachments
      .any((it) => it.titleLink != null && it.type != 'giphy');

  /// {@template showBottomRow}
  /// Show the [BottomRow] widget if any of the following are `true`:
  /// * [StreamMessageWidget.showThreadReplyIndicator]
  /// * [StreamMessageWidget.showUsername]
  /// * [StreamMessageWidget.showTimestamp]
  /// * [StreamMessageWidget.showInChannelIndicator]
  /// * [StreamMessageWidget.showSendingIndicator]
  /// * [StreamMessageWidget.message.isDeleted]
  /// {@endtemplate}
  bool get showBottomRow =>
      !widget.hideBottomRow &&
      (showThreadReplyIndicator ||
          showUsername ||
          showTimeStamp ||
          showInChannel ||
          showSendingIndicator ||
          isDeleted);

  /// {@template isPinned}
  /// Whether [StreamMessageWidget.message] is pinned or not.
  /// {@endtemplate}
  bool get isPinned => widget.message.pinned;

  /// {@template shouldShowReactions}
  /// Should show message reactions if [StreamMessageWidget.showReactions] is
  /// `true`, if there are reactions to show, and if the message is not deleted.
  /// {@endtemplate}
  bool get shouldShowReactions =>
      widget.showReactions &&
      (widget.message.reactionCounts?.isNotEmpty == true) &&
      !widget.message.isDeleted;

  bool get shouldShowReplyAction =>
      widget.showReplyMessage && !isFailedState && widget.onReplyTap != null;

  bool get shouldShowEditAction =>
      widget.showEditMessage &&
      !isDeleteFailed &&
      !widget.message.attachments.any((element) => element.type == 'giphy');

  bool get shouldShowResendAction =>
      widget.showResendMessage && (isSendFailed || isUpdateFailed);

  bool get shouldShowCopyAction =>
      widget.showCopyMessage &&
      !isFailedState &&
      widget.message.text?.trim().isNotEmpty == true;

  bool get shouldShowEditMessage =>
      widget.showEditMessage &&
      !isDeleteFailed &&
      !widget.message.attachments.any((element) => element.type == 'giphy');

  bool get shouldShowThreadReplyAction =>
      widget.showThreadReplyMessage &&
      !isFailedState &&
      widget.onThreadTap != null;

  bool get shouldShowDeleteAction => widget.showDeleteMessage || isDeleteFailed;

  @override
  bool get wantKeepAlive => widget.message.attachments.isNotEmpty;

  bool editMessage = false;

  late StreamChatThemeData _streamChatTheme;
  late StreamChatState _streamChat;

  late final GlobalKey reactionsKey;
  final GlobalKey contextMessageKey = GlobalKey();
  late final GlobalKey reactionPickerIndicatorKey;

  final GlobalKey contextOverlayKey = GlobalKey();

  @override
  void initState() {
    reactionsKey = widget.reactionsKey ?? GlobalKey();
    reactionPickerIndicatorKey =
        widget.reactionPickerIndicatorKey ?? GlobalKey();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _streamChatTheme = StreamChatTheme.of(context);
    _streamChat = StreamChat.of(context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final avatarWidth =
        widget.messageTheme.avatarTheme?.constraints.maxWidth ?? 40;
    final bottomRowPadding =
        widget.showUserAvatar != DisplayWidget.gone ? avatarWidth + 14.0 : 6.0;

    final showReactions = shouldShowReactions;

    final channel = StreamChannel.of(context).channel;

    if (editMessage &&
        shouldShowEditMessage &&
        widget.editMessageInputBuilder != null) {
      return widget.editMessageInputBuilder!(context, widget.message, () {
        if (mounted) {
          setState(() {
            editMessage = false;
          });
        }
      });
    }

    final messageContent = MessageWidgetContent(
      streamChatTheme: _streamChatTheme,
      showUsername: showUsername,
      showTimeStamp: showTimeStamp,
      showThreadReplyIndicator: showThreadReplyIndicator,
      showSendingIndicator: showSendingIndicator,
      showInChannel: showInChannel,
      isGiphy: isGiphy,
      isOnlyEmoji: isOnlyEmoji,
      hasUrlAttachments: hasUrlAttachments,
      messageTheme: widget.messageTheme,
      reverse: widget.reverse,
      message: widget.message,
      hasNonUrlAttachments: hasNonUrlAttachments,
      shouldShowReactions: shouldShowReactions,
      hasQuotedMessage: hasQuotedMessage,
      textPadding: widget.textPadding,
      attachmentBuilders: widget.attachmentBuilders,
      attachmentPadding: widget.attachmentPadding,
      avatarWidth: avatarWidth,
      bottomRowPadding: bottomRowPadding,
      isFailedState: isFailedState,
      isPinned: isPinned,
      messageWidget: widget,
      showBottomRow: showBottomRow,
      showPinHighlight: widget.showPinHighlight,
      reactionPickerIndicatorKey: reactionPickerIndicatorKey,
      showReactionPickerIndicator: widget.showReactionPickerIndicator,
      showReactions: showReactions,
      showUserAvatar: widget.showUserAvatar,
      streamChat: _streamChat,
      translateUserAvatar: widget.translateUserAvatar,
      deletedBottomRowBuilder: widget.deletedBottomRowBuilder,
      onThreadTap: widget.onThreadTap,
      shape: widget.shape,
      borderSide: widget.borderSide,
      borderRadiusGeometry: widget.borderRadiusGeometry,
      textBuilder: widget.textBuilder,
      onLinkTap: widget.onLinkTap,
      onMentionTap: widget.onMentionTap,
      onQuotedMessageTap: widget.onQuotedMessageTap,
      bottomRowBuilder: widget.bottomRowBuilder,
      onUserAvatarTap: widget.onUserAvatarTap,
      userAvatarBuilder: widget.userAvatarBuilder,
      usernameBuilder: widget.usernameBuilder,
      onReactionPressed: () {
        widget.contextMenuController?.openContextMenu();
      },
      isGroup: channel.isGroup,
      profileAssetBuilder: widget.profileAssetBuilder,
      enableMessageContainer: widget.enableMessageContainer,
    );

    Widget content = Align(
      alignment: widget.reverse ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.76,
        ),
        child: messageContent,
      ),
    );

    // Without a intrinsic sized widget the complete horizontal space
    // is requested even if the message is not that big.
    // This leads to the problem where the user tries to click outside
    // of a NightVibesContextMenu but it won´t close because this widget
    // uses the whole space.
    if (widget.useIntrinsicSize) {
      content = IntrinsicWidth(
        child: content,
      );
    }

    content = Padding(
      padding: widget.padding ?? const EdgeInsets.all(8),
      child: content,
    );
    return Material(
      type: MaterialType.transparency,
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        color: widget.message.pinned && widget.showPinHighlight
            ? _streamChatTheme.colorTheme.highlight
            : _streamChatTheme.colorTheme.barsBg.withOpacity(0),
        child: Portal(
          child: StreamChannel(
            channel: channel,
            showLoading: widget.showLoading ?? true,
            populateFutures: false,
            child: PlatformWidgetBuilder(
              mobile: (context, child) {
                if (widget.enableContextMenu) {
                  final viewPadding = MediaQuery.viewPaddingOf(context);

                  child = NightVibesContextMenu(
                    actions: _buildContextMenu(),
                    enableSafeArea: false,
                    alignChild: false,
                    childCrossAxisAlignment: CrossAxisAlignment.stretch,
                    childMainAxisAlignment: MainAxisAlignment.center,
                    contextMenuController: widget.contextMenuController,
                    menuAlignment: Alignment.center,
                    padding: viewPadding,
                    child: child!,
                    decoyBuilder: (context, child) {
                      return StreamChannel(
                        channel: channel,
                        showLoading: false,
                        populateFutures: false,
                        child: IgnorePointer(child: child!),
                      );
                    },
                    previewBuilder: (context, animation, child) {
                      final curveAnimation = CurvedAnimation(
                        parent: animation,
                        curve: const Cubic(0.15, 0.52, 0.27, 1.05),
                        reverseCurve: Curves.easeInCubic,
                      );

                      final reactionPickerAnimation = CurvedAnimation(
                        parent: animation,
                        curve: const Interval(
                          0.5,
                          1,
                          curve: Cubic(0.15, 0.52, 0.27, 1.05),
                        ),
                        reverseCurve: const Interval(
                          0.5,
                          1,
                          curve: Curves.easeInCubic,
                        ),
                      );

                      final alignAnimation = AlignmentTween(
                        begin: widget.reverse
                            ? Alignment.bottomRight
                            : Alignment.bottomLeft,
                        end: Alignment.center,
                      ).animate(curveAnimation);

                      final reactionPickerAlignAnimation = AlignmentTween(
                        begin: widget.reverse
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        end: widget.reverse
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                      ).animate(curveAnimation);

                      final scaleAnimation = Tween<double>(begin: 1, end: 1.05)
                          .animate(curveAnimation);

                      final topPaddingAnimation =
                          Tween<double>(begin: 0, end: 72).animate(
                        curveAnimation,
                      );

                      final hasReaction =
                          (widget.message.latestReactions?.length ?? 0) > 0;
                      final isPinned = widget.message.pinned;

                      EdgeInsetsGeometry margin = EdgeInsets.zero;

                      if (showBottomRow) {
                        margin = margin.add(const EdgeInsets.only(bottom: 18));
                      }

                      if (isPinned && hasReaction) {
                        margin = margin.add(const EdgeInsets.only(bottom: 8));
                      } else if (isPinned) {
                        margin = margin.add(const EdgeInsets.only(bottom: 10));
                      }

                      final pickerPosition =
                          _getReactionsPickerIndicatorPosition();

                      final messageContent = Padding(
                        padding: margin,
                        child: RebuildOnce(
                          key: contextMessageKey,
                          child: widget.copyWith(
                            showLoading: false,
                            // message: widget.message.copyWith(
                            //   text: (widget.message.text?.length ?? 0) > 200
                            //       ? '${widget.message.text!.substring(0, 200)}...'
                            //       : widget.message.text,
                            // ),

                            showReactions: false,
                            hideBottomRow: true,
                            reactionPickerIndicatorKey:
                                reactionPickerIndicatorKey,
                            reactionsKey: reactionsKey,
                            showReactionPickerIndicator:
                                widget.message.status ==
                                    MessageSendingStatus.sent,
                            showPinHighlight: false,
                            enableContextMenu: false,
                            contextMenuController: widget.contextMenuController,
                            freezeMediaQueryController:
                                widget.freezeMediaQueryController,
                            useIntrinsicSize: true,
                          ),
                        ),
                      );

                      return SizedBox(
                        key: contextOverlayKey,
                        child: StreamChannel(
                          channel: channel,
                          showLoading: false,
                          populateFutures: false,
                          child: Stack(
                            fit: StackFit.passthrough,
                            children: [
                              // SizedBox.shrink()
                              Padding(
                                padding: EdgeInsets.only(
                                  top: topPaddingAnimation.value,
                                ),
                                child: Align(
                                  heightFactor: 1,
                                  alignment: alignAnimation.value,
                                  child: Transform.scale(
                                    scale: scaleAnimation.value,
                                    child: SingleChildScrollView(
                                      clipBehavior: Clip.none,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      child: messageContent,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    final reactionPicker = FadeTransition(
                                      opacity: reactionPickerAnimation,
                                      child: ScaleTransition(
                                        alignment:
                                            reactionPickerAlignAnimation.value,
                                        scale: reactionPickerAnimation,
                                        child: StreamReactionPicker(
                                          key: reactionsKey,
                                          message: widget.message,
                                        ),
                                      ),
                                    );

                                    final reactionsPickerSize =
                                        _getSize(reactionsKey);

                                    const paddingHorizontal = 24.0;
                                    final maxWidth = constraints.maxWidth -
                                        paddingHorizontal;
                                    const minWidth = paddingHorizontal;

                                    final maxLeftPaddingToFit =
                                        (reactionsPickerSize.width == 0
                                                ? minWidth
                                                : (maxWidth -
                                                    reactionsPickerSize.width))
                                            .clamp(minWidth, maxWidth);

                                    final reactionsIndicatorWithOffset =
                                        pickerPosition.dx - 42;

                                    var leftOffset = maxLeftPaddingToFit;

                                    if (maxLeftPaddingToFit >
                                        reactionsIndicatorWithOffset) {
                                      leftOffset =
                                          reactionsIndicatorWithOffset.clamp(
                                        minWidth,
                                        maxWidth,
                                      );
                                    }

                                    return Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                          left: leftOffset,
                                          bottom: (constraints.maxHeight -
                                                  pickerPosition.dy +
                                                  14)
                                              .clamp(
                                            0,
                                            constraints.maxHeight,
                                          ),
                                        ),
                                        child: reactionPicker,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }

                return child;
              },
              desktop: (_, child) => MouseRegion(child: child),
              web: (_, child) => MouseRegion(child: child),
              child: content,
            ),
          ),
        ),
      ),
    );
  }

  Offset _getReactionsPickerIndicatorPosition() {
    if (reactionPickerIndicatorKey.currentContext == null) {
      return Offset.zero;
    }

    if (contextOverlayKey.currentContext == null) {
      return Offset.zero;
    }

    final box = reactionPickerIndicatorKey.currentContext?.findRenderObject()
        as RenderBox?;

    final relativeBox =
        contextOverlayKey.currentContext?.findRenderObject() as RenderBox?;

    final position = box?.localToGlobal(Offset.zero, ancestor: relativeBox);

    return position ?? Offset.zero;
  }

// Given a GlobalKey, return the Rect of the corresponding RenderBox's
// paintBounds in global coordinates.
  Size _getSize(GlobalKey globalKey) {
    if (globalKey.currentContext == null) {
      return Size.zero;
    }
    final renderBoxContainer =
        globalKey.currentContext!.findRenderObject()! as RenderBox;

    return renderBoxContainer.size;
  }

  List<Widget> _buildContextMenu() {
    final channel = StreamChannel.of(context).channel;

    return [
      if (shouldShowReplyAction) ...[
        NightVibesContextMenuAction(
          // leading: StreamSvgIcon.reply(),
          trailingIcon: CupertinoIcons.arrowshape_turn_up_left_fill,
          child: Text(
            context.translations.replyLabel,
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.fade,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          // title: Text(context.translations.replyLabel),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            widget.onReplyTap!(widget.message);
          },
        ),
      ],
      if (shouldShowThreadReplyAction)
        NightVibesContextMenuAction(
          trailingIcon: CupertinoIcons.text_alignleft,
          // leading: StreamSvgIcon.thread(),
          child: Text(
            context.translations.threadReplyLabel,
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.fade,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            widget.onThreadTap!(widget.message);
          },
        ),
      if (shouldShowEditAction) ...[
        NightVibesContextMenuAction(
          trailingIcon: CupertinoIcons.pencil,
          // leading: StreamSvgIcon.edit(color: Colors.grey),
          // title: Text(context.translations.editMessageLabel),
          child: Text(
            context.translations.editMessageLabel,
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.fade,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() {
                  editMessage = true;
                });
              }
            });

            // showModalBottomSheet(
            //   context: context,
            //   elevation: 2,
            //   clipBehavior: Clip.hardEdge,
            //   isScrollControlled: true,
            //   backgroundColor:
            //       StreamMessageInputTheme.of(context).inputBackgroundColor,
            //   shape: const RoundedRectangleBorder(
            //     borderRadius: BorderRadius.only(
            //       topLeft: Radius.circular(16),
            //       topRight: Radius.circular(16),
            //     ),
            //   ),
            //   builder: (_) => EditMessageSheet(
            //     message: widget.message,
            //     channel: StreamChannel.of(context).channel,
            //   ),
            // );
          },
        ),
      ],
      if (shouldShowCopyAction)
        NightVibesContextMenuAction(
          trailingIcon: CupertinoIcons.doc_on_clipboard_fill,
          child: Text(
            context.translations.copyMessageLabel,
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.fade,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            Clipboard.setData(ClipboardData(text: widget.message.text ?? ''));
          },
        ),
      if (widget.showPinButton)
        NightVibesContextMenuAction(
          trailingIcon: CupertinoIcons.star_fill,
          child: Text(
            context.translations.togglePinUnpinText(
              pinned: widget.message.pinned,
            ),
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.fade,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          onPressed: () async {
            Navigator.of(context, rootNavigator: true).pop();
            try {
              if (!widget.message.pinned) {
                await channel.pinMessage(widget.message);
              } else {
                await channel.unpinMessage(widget.message);
              }
            } catch (e) {
              throw Exception(e);
            }
          },
        ),
      if (shouldShowResendAction)
        NightVibesContextMenuAction(
          trailingIcon: CupertinoIcons.arrow_clockwise_circle_fill,
          // leading: StreamSvgIcon.iconSendMessage(),
          // title: Text(
          //   context.translations.toggleResendOrResendEditedMessage(
          //     isUpdateFailed:
          //         widget.message.status == MessageSendingStatus.failed,
          //   ),
          // ),
          child: Text(
            context.translations.toggleResendOrResendEditedMessage(
              isUpdateFailed:
                  widget.message.status == MessageSendingStatus.failed,
            ),
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.fade,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            final isUpdateFailed =
                widget.message.status == MessageSendingStatus.failed_update;
            final channel = StreamChannel.of(context).channel;
            if (isUpdateFailed) {
              channel.updateMessage(widget.message);
            } else {
              channel.sendMessage(widget.message);
            }
          },
        ),
      if (shouldShowDeleteAction)
        NightVibesContextMenuAction(
          isDestructiveAction: true,
          trailingIcon: CupertinoIcons.delete_solid,
          // leading: StreamSvgIcon.delete(color: Colors.red),
          // title: Text(
          //   context.translations.deleteMessageLabel,
          //   style: const TextStyle(color: Colors.red),
          // ),
          child: Text(
            context.translations.deleteMessageLabel,
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.fade,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          onPressed: () async {
            Navigator.of(context, rootNavigator: true).pop();

            final deleted = await showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return const DeleteMessageDialog();
              },
            );

            if (deleted) {
              try {
                await StreamChannel.of(context)
                    .channel
                    .deleteMessage(widget.message);
              } catch (e) {
                NightVibesNotification.error(
                  context.translations.deleteMessageLabel,
                  LocaleKeys.Something_went_wrong.tr(),
                );
              }
            }
          },
        ),
    ];
    return [
      Material(
        child: StreamChatContextMenuItem(
          child: StreamChannel(
            channel: channel,
            child: ContextMenuReactionPicker(
              message: widget.message,
            ),
          ),
        ),
      ),
      // if (shouldShowReplyAction) ...[
      //   StreamChatContextMenuItem(
      //     leading: StreamSvgIcon.reply(),
      //     title: Text(context.translations.replyLabel),
      //     onClick: () {
      //       Navigator.of(context, rootNavigator: true).pop();
      //       widget.onReplyTap!(widget.message);
      //     },
      //   ),
      // ],
      // if (shouldShowThreadReplyAction)
      //   StreamChatContextMenuItem(
      //     leading: StreamSvgIcon.thread(),
      //     title: Text(context.translations.threadReplyLabel),
      //     onClick: () {
      //       Navigator.of(context, rootNavigator: true).pop();
      //       widget.onThreadTap!(widget.message);
      //     },
      //   ),
      // if (shouldShowCopyAction)
      //   StreamChatContextMenuItem(
      //     leading: StreamSvgIcon.copy(),
      //     title: Text(context.translations.copyMessageLabel),
      //     onClick: () {
      //       Navigator.of(context, rootNavigator: true).pop();
      //       Clipboard.setData(ClipboardData(text: widget.message.text));
      //     },
      //   ),
      // if (shouldShowEditAction) ...[
      //   StreamChatContextMenuItem(
      //     leading: StreamSvgIcon.edit(color: Colors.grey),
      //     title: Text(context.translations.editMessageLabel),
      //     onClick: () {
      //       Navigator.of(context, rootNavigator: true).pop();
      //       showModalBottomSheet(
      //         context: context,
      //         elevation: 2,
      //         clipBehavior: Clip.hardEdge,
      //         isScrollControlled: true,
      //         backgroundColor:
      //             StreamMessageInputTheme.of(context).inputBackgroundColor,
      //         shape: const RoundedRectangleBorder(
      //           borderRadius: BorderRadius.only(
      //             topLeft: Radius.circular(16),
      //             topRight: Radius.circular(16),
      //           ),
      //         ),
      //         builder: (_) => EditMessageSheet(
      //           message: widget.message,
      //           channel: StreamChannel.of(context).channel,
      //         ),
      //       );
      //     },
      //   ),
      // ],
      // if (widget.showPinButton)
      //   StreamChatContextMenuItem(
      //     leading: StreamSvgIcon.pin(
      //       color: Colors.grey,
      //       size: 24,
      //     ),
      //     title: Text(
      //       context.translations.togglePinUnpinText(
      //         pinned: widget.message.pinned,
      //       ),
      //     ),
      //     onClick: () async {
      //       Navigator.of(context, rootNavigator: true).pop();
      //       try {
      //         if (!widget.message.pinned) {
      //           await channel.pinMessage(widget.message);
      //         } else {
      //           await channel.unpinMessage(widget.message);
      //         }
      //       } catch (e) {
      //         throw Exception(e);
      //       }
      //     },
      //   ),
      // if (shouldShowResendAction)
      //   StreamChatContextMenuItem(
      //     leading: StreamSvgIcon.iconSendMessage(),
      //     title: Text(
      //       context.translations.toggleResendOrResendEditedMessage(
      //         isUpdateFailed:
      //             widget.message.status == MessageSendingStatus.failed,
      //       ),
      //     ),
      //     onClick: () {
      //       Navigator.of(context, rootNavigator: true).pop();
      //       final isUpdateFailed =
      //           widget.message.status == MessageSendingStatus.failed_update;
      //       final channel = StreamChannel.of(context).channel;
      //       if (isUpdateFailed) {
      //         channel.updateMessage(widget.message);
      //       } else {
      //         channel.sendMessage(widget.message);
      //       }
      //     },
      //   ),
      // if (shouldShowDeleteAction)
      //   StreamChatContextMenuItem(
      //     leading: StreamSvgIcon.delete(color: Colors.red),
      //     title: Text(
      //       context.translations.deleteMessageLabel,
      //       style: const TextStyle(color: Colors.red),
      //     ),
      //     onClick: () async {
      //       Navigator.of(context, rootNavigator: true).pop();
      //       final deleted = await showDialog(
      //         context: context,
      //         barrierDismissible: false,
      //         builder: (_) => const DeleteMessageDialog(),
      //       );
      //       if (deleted) {
      //         try {
      //           await StreamChannel.of(context)
      //               .channel
      //               .deleteMessage(widget.message);
      //         } catch (e) {
      //           showDialog(
      //             context: context,
      //             builder: (_) => const MessageDialog(),
      //           );
      //         }
      //       }
      //     },
      //   ),
    ];
  }

  void onLongPress(BuildContext context) {
    if (widget.message.isEphemeral ||
        widget.message.status == MessageSendingStatus.sending) {
      return;
    }

    if (widget.onMessageActions != null) {
      widget.onMessageActions!(context, widget.message);
    } else {
      _showMessageActionModalBottomSheet(context);
    }
    return;
  }

  void _showMessageActionModalBottomSheet(BuildContext context) {
    final channel = StreamChannel.of(context).channel;

    showDialog(
      useRootNavigator: false,
      context: context,
      barrierColor: _streamChatTheme.colorTheme.overlay,
      builder: (context) => StreamChannel(
        channel: channel,
        child: MessageActionsModal(
          messageWidget: widget.copyWith(
            key: const Key('MessageWidget'),
            message: widget.message.copyWith(
              text: (widget.message.text?.length ?? 0) > 200
                  ? '${widget.message.text!.substring(0, 200)}...'
                  : widget.message.text,
            ),
            showReactions: false,
            showUsername: false,
            showTimestamp: false,
            translateUserAvatar: false,
            showSendingIndicator: false,
            padding: EdgeInsets.zero,
            showReactionPickerIndicator: widget.showReactions &&
                (widget.message.status == MessageSendingStatus.sent),
            showPinHighlight: false,
            showUserAvatar:
                widget.message.user!.id == channel.client.state.currentUser!.id
                    ? DisplayWidget.gone
                    : DisplayWidget.show,
          ),
          onCopyTap: (message) =>
              Clipboard.setData(ClipboardData(text: message.text ?? '')),
          messageTheme: widget.messageTheme,
          reverse: widget.reverse,
          showDeleteMessage: shouldShowDeleteAction,
          message: widget.message,
          editMessageInputBuilder: widget.editMessageInputBuilder,
          onReplyTap: widget.onReplyTap,
          onThreadReplyTap: widget.onThreadTap,
          showResendMessage: shouldShowResendAction,
          showCopyMessage: shouldShowCopyAction,
          showEditMessage: shouldShowEditAction,
          showReactions: widget.showReactions,
          showReplyMessage: shouldShowReplyAction,
          showThreadReplyMessage: shouldShowThreadReplyAction,
          showFlagButton: widget.showFlagButton,
          showPinButton: widget.showPinButton,
          customActions: widget.customActions,
        ),
      ),
    );
  }

  void retryMessage(BuildContext context) {
    final channel = StreamChannel.of(context).channel;
    if (widget.message.status == MessageSendingStatus.failed) {
      channel.sendMessage(widget.message);
      return;
    }
    if (widget.message.status == MessageSendingStatus.failed_update) {
      channel.updateMessage(widget.message);
      return;
    }

    if (widget.message.status == MessageSendingStatus.failed_delete) {
      channel.deleteMessage(widget.message);
      return;
    }
  }
}
