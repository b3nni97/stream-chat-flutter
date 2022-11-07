// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: public_member_api_docs
class TextBubbleContainer extends StatelessWidget {
  // ignore: public_member_api_docs
  const TextBubbleContainer({
    required this.child,
    required this.backgroundColor,
    required this.reverse,
    this.borderColor,
    super.key,
  });

  final Widget child;
  final Color backgroundColor;
  final bool reverse;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TextBubblePainter(
        color: backgroundColor,
        borderColor: borderColor,
        alignment: reverse ? Alignment.topRight : Alignment.topLeft,
      ),
      child: child,
    );
  }
}

///custom painter use to create the shape of the chat bubble
///
/// [color],[alignment] and [tail] can be changed

class TextBubblePainter extends CustomPainter {
  TextBubblePainter({
    required this.color,
    required this.alignment,
    this.borderColor,
    this.radius = 15,
    this.nipSize = 6,
  });
  final Color color;
  final Alignment alignment;
  // final bool tail;

  final double radius;
  final double nipSize;
  final Color? borderColor;

  // final double radius = 10.0;

  @override
  void paint(Canvas canvas, Size size) {
    final h = size.height;
    final w = size.width;

    final path = Path();

    if (alignment == Alignment.topRight) {
      path
        ..moveTo(radius, 0)
        ..lineTo(size.width - radius - nipSize, 0)
        ..arcToPoint(
          Offset(size.width - nipSize, radius),
          radius: Radius.circular(radius),
        )
        ..lineTo(size.width - nipSize, size.height - nipSize)
        ..arcToPoint(
          Offset(size.width, size.height),
          radius: Radius.circular(nipSize),
          clockwise: false,
        )
        ..arcToPoint(
          Offset(size.width - nipSize * 2, size.height - nipSize),
          radius: Radius.circular(nipSize * 2),
        )
        ..arcToPoint(
          Offset(size.width - nipSize * 4, size.height),
          radius: Radius.circular(nipSize * 2),
        )
        ..lineTo(radius, size.height)
        ..arcToPoint(
          Offset(0, size.height - radius),
          radius: Radius.circular(radius),
        )
        ..lineTo(0, radius)
        ..arcToPoint(Offset(radius, 0), radius: Radius.circular(radius));
    } else {
      path
        ..moveTo(radius, 0)
        ..lineTo(size.width - radius, 0)
        ..arcToPoint(
          Offset(size.width, radius),
          radius: Radius.circular(radius),
        )
        ..lineTo(size.width, size.height - radius)
        ..arcToPoint(
          Offset(size.width - radius, size.height),
          radius: Radius.circular(radius),
        )
        ..lineTo(nipSize * 4, size.height)
        ..arcToPoint(
          Offset(nipSize * 2, size.height - nipSize),
          radius: Radius.circular(nipSize * 2),
        )
        ..arcToPoint(
          Offset(0, size.height),
          radius: Radius.circular(nipSize * 2),
        )
        ..arcToPoint(
          Offset(nipSize, size.height - nipSize),
          radius: Radius.circular(nipSize),
          clockwise: false,
        )
        ..lineTo(nipSize, radius)
        ..arcToPoint(
          Offset(radius + nipSize, 0),
          radius: Radius.circular(radius),
        );
    }

    canvas
      ..clipPath(path)
      ..drawRRect(
        RRect.fromLTRBR(0, 0, w, h, Radius.zero),
        Paint()
          ..color = color
          ..style = PaintingStyle.fill,
      );

    if (borderColor != null) {
      final borderPaint = Paint()
        ..color = borderColor!
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      canvas.drawPath(path, borderPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
