import 'dart:math';

import 'package:flutter/material.dart';

class AnimationsScreen extends StatelessWidget {
  const AnimationsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedSquared(),
      ),
    );
  }
}

class AnimatedSquared extends StatefulWidget {
  const AnimatedSquared({
    Key key,
  }) : super(key: key);

  @override
  _AnimatedSquaredState createState() => _AnimatedSquaredState();
}

class _AnimatedSquaredState extends State<AnimatedSquared>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> rotation;
  Animation<double> opacity;
  Animation<double> opacityOut;
  Animation<double> moveRight;
  Animation<double> scaleUp;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 4000),
    );
    rotation = Tween(
      begin: 0.0,
      end: 2.0 * pi,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.bounceOut,
      ),
    );

    opacity = Tween(
      begin: 0.1,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0,
          0.25,
          curve: Curves.easeOut,
        ),
      ),
    );

    opacityOut = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.25,
          1,
          curve: Curves.easeOut,
        ),
      ),
    );

    moveRight = Tween(
      begin: 0.0,
      end: 300.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    );

    scaleUp = Tween(
      begin: 0.0,
      end: 1.5,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutCubic,
      ),
    );

    controller.addListener(() {
      if (controller.status == AnimationStatus.completed) {
        controller.reverse();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();
    return AnimatedBuilder(
      animation: controller,
      child: _Rectangle(),
      builder: (BuildContext context, Widget child) {
        print('Opac Status: ${opacity.value}');
        return Transform.translate(
          offset: Offset(
            moveRight.value,
            0,
          ),
          child: Transform.rotate(
            angle: rotation.value,
            child: Opacity(
              opacity: opacity.value - opacityOut.value,
              child: Transform.scale(
                scale: scaleUp.value,
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Rectangle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(color: Colors.red),
    );
  }
}
