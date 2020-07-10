import 'dart:math';

import 'package:flutter/material.dart';

class RadialProgress extends StatefulWidget {
  final double percentage;
  final Color primaryColor;
  final Color secondaryColor;
  final double secondaryWidth;
  final double primaryWidth;
  final double separation;

  RadialProgress({
    @required this.percentage,
    this.primaryColor = Colors.pink,
    this.secondaryColor = Colors.grey,
    this.secondaryWidth = 4.0,
    this.primaryWidth = 10.0,
    this.separation = 5.0,
  });

  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  double previousPercentage;

  @override
  void initState() {
    previousPercentage = widget.percentage;

    controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward(from: 0.0);
    final animateDifference = widget.percentage - previousPercentage;
    previousPercentage = widget.percentage;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            painter: _MyRadialProgressPainter(
                (widget.percentage - animateDifference) +
                    (animateDifference * controller.value),
                primaryColor: widget.primaryColor,
                secondaryColor: widget.secondaryColor,
                secondaryWidth: widget.secondaryWidth,
                primaryWidth: widget.primaryWidth,
                separation: widget.separation),
          ),
        );
      },
    );
  }
}

class _MyRadialProgressPainter extends CustomPainter {
  final double percentage;
  final Color primaryColor;
  final Color secondaryColor;
  final double secondaryWidth;
  final double primaryWidth;
  final double separation;

  _MyRadialProgressPainter(
    this.percentage, {
    @required this.primaryColor,
    @required this.secondaryColor,
    @required this.primaryWidth,
    @required this.secondaryWidth,
    @required this.separation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint()
      ..strokeWidth = secondaryWidth
      ..color = secondaryColor
      ..style = PaintingStyle.stroke;

    final Offset center = new Offset(size.width * 0.5, size.height * 0.5);

    final double radius = min<double>(size.width * 0.5, size.height * 0.5);

    canvas.drawCircle(center, radius, paint);

    final paintArc = new Paint()
      ..strokeWidth = primaryWidth
      ..color = primaryColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    double arcAngle = 2 * pi * (percentage);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius + separation),
      -pi / 2,
      arcAngle,
      false,
      paintArc,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
