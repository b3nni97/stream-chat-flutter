import 'dart:math';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

/// {@template streamReactionBubble}
/// Creates a reaction bubble that displays over messages.
/// {@endtemplate}
class StreamReactionBubble extends StatelessWidget {
  /// {@macro streamReactionBubble}
  const StreamReactionBubble({
    super.key,
    required this.ownId,
    required this.reactions,
    required this.borderColor,
    required this.backgroundColor,
    required this.ownReactionColor,
    required this.otherReactionColor,
    this.reverse = false,
    this.flipTail = false,
    this.highlightOwnReactions = true,
    this.tailCirclesSpacing = 0,
  });

  /// The id of the current user.
  final String ownId;

  /// Reactions to show
  final List<Reaction> reactions;

  /// Border color of bubble
  final Color borderColor;

  /// Background color of bubble
  final Color backgroundColor;

  /// Reverse for other side
  final bool reverse;

  /// Reverse tail for other side
  final bool flipTail;

  /// Flag for highlighting own reactions
  final bool highlightOwnReactions;

  /// Spacing for tail circles
  final double tailCirclesSpacing;

  final Color ownReactionColor;

  final Color otherReactionColor;

  @override
  Widget build(BuildContext context) {
    final reactionIcons = StreamChatConfiguration.of(context).reactionIcons;
    final totalReactions = reactions.length;
    final offset =
        totalReactions > 1 ? 16.0.mirrorConditionally(flipTail) : 2.0;

    final firstReaction = reactions.first;

    final backgroundColor = totalReactions > 1
        ? otherReactionColor
        : (firstReaction.user!.id == ownId
            ? ownReactionColor
            : otherReactionColor);

    return SizedBox(
      height: 34,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Transform.translate(
            offset: Offset(-0, 0),
            child: Container(
              // height: 32,
              // padding: const EdgeInsets.all(2),
              // decoration: BoxDecoration(
              //   color: maskColor,
              //   borderRadius: const BorderRadius.all(Radius.circular(16)),
              // ),
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: borderColor,
                  ),
                  color: backgroundColor,
                  borderRadius: const BorderRadius.all(Radius.circular(99)),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) => Flex(
                    direction: Axis.horizontal,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (constraints.maxWidth < double.infinity)
                        ...reactions
                            .take((constraints.maxWidth) ~/ 24)
                            .map((reaction) => _buildReaction(
                                  reactionIcons,
                                  reaction,
                                  context,
                                ))
                            .toList(),
                      if (constraints.maxWidth == double.infinity)
                        ...reactions
                            .map((reaction) => _buildReaction(
                                  reactionIcons,
                                  reaction,
                                  context,
                                ))
                            .toList(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -2,
            // left: -2,
            left: reverse ? 0 : null,
            right: reverse ? null : 0,
            child: _buildReactionsTail(backgroundColor, context),
          ),
          // Positioned(
          //   bottom: 2,
          //   left: reverse ? null : 13,
          //   right: reverse ? 13 : null,
          //   child: _buildReactionsTail(context),
          // ),
        ],
      ),
    );
  }

  Widget _buildReaction(
    List<StreamReactionIcon> reactionIcons,
    Reaction reaction,
    BuildContext context,
  ) {
    final reactionIcon = reactionIcons.firstWhereOrNull(
      (r) => r.type == reaction.type,
    );

    final chatThemeData = StreamChatTheme.of(context);
    final userId = StreamChat.of(context).currentUser?.id;
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            reaction.user?.id == userId ? ownReactionColor : otherReactionColor,
      ),
      child: Center(
        child: reactionIcon != null
            ? ConstrainedBox(
                constraints: BoxConstraints.tight(const Size.square(20)),
                child: reactionIcon.builder(
                  context,
                  !highlightOwnReactions || reaction.user?.id == userId,
                  20,
                ),
              )
            : Icon(
                Icons.help_outline_rounded,
                size: 20,
                color: (!highlightOwnReactions || reaction.user?.id == userId)
                    ? chatThemeData.colorTheme.accentPrimary
                    : chatThemeData.colorTheme.textHighEmphasis
                        .withOpacity(0.5),
              ),
      ),
    );
  }

  Widget _buildReactionsTail(Color color, BuildContext context) {
    final tail = CustomPaint(
      painter: ReactionBubblePainter(
        color,
        borderColor,
        tailCirclesSpace: tailCirclesSpacing,
        flipTail: !flipTail,
        numberOfReactions: reactions.length,
      ),
    );
    return tail;
  }
}

/// Painter widget for a reaction bubble
class ReactionBubbleDetailPainter extends CustomPainter {
  /// Constructor for creating a [ReactionBubbleDetailPainter]
  ReactionBubbleDetailPainter(
    this.color,
    this.borderColor,
    this.maskColor, {
    this.tailCirclesSpace = 0,
    this.flipTail = false,
    this.numberOfReactions = 0,
  });

  /// Color of bubble
  final Color color;

  /// Border color of bubble
  final Color borderColor;

  /// Mask color
  final Color maskColor;

  /// Tail circle space
  final double tailCirclesSpace;

  /// Flip tail
  final bool flipTail;

  /// Number of reactions on the page
  final int numberOfReactions;

  @override
  void paint(Canvas canvas, Size size) {
    _drawLittleOval(size, canvas);

    _drawBigOval(size, canvas);
  }

  void _drawLittleOval(Size size, Canvas canvas) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..addOval(
        Rect.fromCenter(center: Offset.zero, width: 8, height: 7),
      );
    canvas.drawPath(path, paint);
  }

  void _drawBigOval(Size size, Canvas canvas) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final offset = const Offset(-8, -12).mirrorConditionally(flipTail);

    final path = Path()
      ..addOval(
        Rect.fromCenter(center: offset, width: 14, height: 13),
      );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

/// Painter widget for a reaction bubble
class ReactionBubblePainter extends CustomPainter {
  /// Constructor for creating a [ReactionBubblePainter]
  ReactionBubblePainter(
    this.color,
    this.borderColor, {
    this.tailCirclesSpace = 0,
    this.flipTail = false,
    this.numberOfReactions = 0,
  });

  /// Color of bubble
  final Color color;

  /// Border color of bubble
  final Color borderColor;

  /// Tail circle space
  final double tailCirclesSpace;

  /// Flip tail
  final bool flipTail;

  /// Number of reactions on the page
  final int numberOfReactions;

  @override
  void paint(Canvas canvas, Size size) {
    _drawLittleCircle(size, canvas);

    _drawArc(size, canvas);
  }

  void _drawLittleCircle(Size size, Canvas canvas) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..addOval(
        Rect.fromCenter(center: Offset.zero, width: 5, height: 5),
      );
    canvas.drawPath(path, paint);
  }

  void _drawArc(Size size, Canvas canvas) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    final offset = const Offset(6, -7).mirrorConditionally(flipTail);

    final startAngle = !flipTail ? -0.1 : 1.1;
    final sweepAngle = !flipTail ? -1.3 : 1.3;
    final path = Path()
      ..addArc(
        Rect.fromCenter(center: offset, width: 10, height: 10),
        -pi * startAngle,
        -pi * sweepAngle,
      );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

/// Extension on [Offset]
extension YTransformer on Offset {
  /// Flips x coordinate when flip is true
  // ignore: avoid_positional_boolean_parameters
  Offset mirrorConditionally(bool flip) => Offset(flip ? -dx : dx, dy);
}

/// Extension on [Offset]
extension IntTransformer on double {
  /// Flips x coordinate when flip is true
  // ignore: avoid_positional_boolean_parameters
  double mirrorConditionally(bool flip) => flip ? -this : this;
}
