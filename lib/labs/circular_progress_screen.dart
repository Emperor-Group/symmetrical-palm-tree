import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class CircularProgressScreen extends StatefulWidget {
  CircularProgressScreen({Key key}) : super(key: key);

  @override
  _CircularProgressScreenState createState() => _CircularProgressScreenState();
}

class _CircularProgressScreenState extends State<CircularProgressScreen>
    with SingleTickerProviderStateMixin {
  double percentage = 0.0;
  double newPercentage = 0.0;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = new AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 800,
      ),
    );

    controller.addListener(() {
      setState(() {
        percentage = lerpDouble(
          percentage,
          newPercentage,
          controller.value,
        );
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          width: 300,
          height: 300,
          child: CustomPaint(
            painter: _MyRadialProgressPainter(
              percentage,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.refresh,
        ),
        onPressed: () {
          setState(() {
            percentage = newPercentage;
            newPercentage += 0.1;
            if (newPercentage > 1) {
              newPercentage = 0;
              percentage = 0;
            }
          });
          controller.forward(
            from: 0.0,
          );
        },
      ),
    );
  }
}

class _MyRadialProgressPainter extends CustomPainter {
  final double percentage;

  _MyRadialProgressPainter(
    this.percentage,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint()
      ..strokeWidth = 5
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;

    final Offset center = new Offset(size.width * 0.5, size.height * 0.5);

    final double radius = min<double>(size.width * 0.5, size.height * 0.5);

    canvas.drawCircle(center, radius, paint);

    final paintArc = new Paint()
      ..strokeWidth = 10
      ..color = Colors.pink
      ..style = PaintingStyle.stroke;

    double arcAngle = 2 * pi * (percentage);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius + 5),
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
