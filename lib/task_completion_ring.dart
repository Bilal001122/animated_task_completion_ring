import 'dart:math' show pi;

import 'package:flutter/material.dart';

class TaskCompletionRing extends StatelessWidget {
  final double progress;

  const TaskCompletionRing({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          CustomPaint(
            painter: RingPainter(
              taskNotCompletedColor: Colors.blue.withOpacity(0.5),
              taskCompletedColor: Colors.blue,
              progress: progress,
            ),
          ),
          Center(
            child: Text(
              '${(progress * 100).round()}%',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RingPainter extends CustomPainter {
  final Color taskNotCompletedColor;
  final Color taskCompletedColor;
  final double progress;

  RingPainter({
    required this.taskCompletedColor,
    required this.taskNotCompletedColor,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = size.width / 15;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final backgroundPaint = Paint()
      ..isAntiAlias = true
      ..color = taskNotCompletedColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, backgroundPaint);

    final foregroundPaint = Paint()
      ..isAntiAlias = true
      ..color = taskCompletedColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      progress * 2 * pi,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant RingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
