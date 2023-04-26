import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stages/generated/locale_keys.g.dart';
import 'package:stages/theme/night_vibes_theme/night_vibes_theme.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

/// {@template deleteMessageDialog}
/// A dialog that asks the user to confirm that they want to
/// delete the selected message.
/// {@endtemplate}
class DeleteMessageDialog extends StatelessWidget {
  /// {@macro deleteMessageDialog}
  const DeleteMessageDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final streamTheme = StreamChatTheme.of(context);

    return CupertinoActionSheet(
      title: Text(
        context.translations.deleteMessageLabel,
        style: TextStyle(
          color: NightVibesTheme.of(context).red,
          fontSize: 18,
        ),
      ),
      message: Text(
        context.translations.deleteMessageQuestion,
        style: TextStyle(
          color: NightVibesTheme.of(context).red,
        ),
      ),
      actions: [
        CupertinoActionSheetAction(
          isDestructiveAction: true,
          child: Text(
            LocaleKeys.Delete.tr(),
          ),
          onPressed: () => Navigator.of(context).pop(true),
        ),
        CupertinoActionSheetAction(
          isDefaultAction: true,
          child: Text(
            LocaleKeys.Cancel.tr(),
            style: TextStyle(
              color: streamTheme.colorTheme.accentPrimary,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(false),
        ),
      ],
    );
  }
}
