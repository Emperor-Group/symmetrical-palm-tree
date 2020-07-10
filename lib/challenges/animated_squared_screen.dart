import 'package:flutter/material.dart';

class AnimatedSquareScreen extends StatelessWidget {
  const AnimatedSquareScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedSquare(),
      ),
    );
  }
}

class AnimatedSquare extends StatefulWidget {
  const AnimatedSquare({
    Key key,
  }) : super(key: key);

  @override
  _AnimatedSquareState createState() => _AnimatedSquareState();
}

class _AnimatedSquareState extends State<AnimatedSquare>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> moveRight;
  Animation<double> moveUp;
  Animation<double> moveLeft;
  Animation<double> moveDown;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 4500,
      ),
    );

    moveRight = Tween<double>(
      begin: 0.0,
      end: 100.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,
          0.25,
          curve: Curves.bounceOut,
        ),
      ),
    );

    moveUp = Tween<double>(
      begin: 0.0,
      end: 100.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.25,
          0.5,
          curve: Curves.bounceOut,
        ),
      ),
    );

    moveLeft = Tween<double>(
      begin: 0.0,
      end: 100.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.5,
          0.75,
          curve: Curves.bounceOut,
        ),
      ),
    );

    moveDown = Tween<double>(
      begin: 0.0,
      end: 100.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.75,
          1,
          curve: Curves.bounceOut,
        ),
      ),
    );

    controller.addListener(() {
      if (controller.status == AnimationStatus.completed) {
        controller.reset();
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
    return GestureDetector(
      child: AnimatedBuilder(
        animation: controller,
        child: _Rectangle(),
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(
              moveRight.value - moveLeft.value,
              -moveUp.value + moveDown.value,
            ),
            child: child,
          );
        },
      ),
      onDoubleTap: () => controller.forward(),
    );
  }
}

class _Rectangle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.deepPurple,
      ),
    );
  }
}
