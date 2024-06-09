import 'package:flutter/material.dart';

class ArcPaint extends CustomPainter {
  final double startAngle;
  final double endAngle;

  ArcPaint({super.repaint, required this.startAngle, required this.endAngle});
  @override
  void paint(Canvas canvas, Size size) {
    var center = Offset.zero;
    var paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 10
      ..style = PaintingStyle.fill;
    final rect = Rect.fromCircle(center: center, radius: 40);
    canvas.drawArc(rect, startAngle, endAngle, true, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class LinearPaint extends CustomPainter {
  final Animation<Offset> first;
  final Animation<Offset> second;
  final Offset firstDot;
  final Offset firstCommon;
  final Offset secondDot;

  LinearPaint(
      {super.repaint,
      required this.first,
      required this.second,
      required this.firstDot,
      required this.firstCommon,
      required this.secondDot});
  @override
  void paint(Canvas canvas, Size size) {
    double radius = 3;
    var paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 6
      ..style = PaintingStyle.fill;
    if (first.value != firstDot) {
      canvas.drawCircle(firstDot, radius, paint);
    }
    canvas.drawLine(firstDot, first.value, paint);
    if (first.value != firstDot) {
      canvas.drawCircle(firstCommon, radius, paint);
    }
    canvas.drawLine(firstCommon, second.value, paint);
    if (second.value != firstCommon) {
      canvas.drawCircle(second.value, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class DotPainter extends CustomPainter {
  final double radius;
  final Offset offset;

  DotPainter({super.repaint, required this.radius, required this.offset});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(offset, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
