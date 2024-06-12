import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' show radians;

class FABCircularAnimation extends StatefulWidget {
  const FABCircularAnimation({super.key});

  @override
  State<FABCircularAnimation> createState() => _FABCircularAnimationState();
}

class _FABCircularAnimationState extends State<FABCircularAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: RadialMenu(
        controller: _controller,
      )),
    );
  }
}

class RadialMenu extends StatelessWidget {
  RadialMenu({super.key, required this.controller})
      : scale = Tween<double>(begin: 1.0, end: 0.0)
            .animate(CurvedAnimation(parent: controller, curve: Curves.linear)),
        transform = Tween<double>(begin: 0.0, end: 100.0)
            .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn)),
        rotate = Tween<double>(begin: 0.0, end: 360 * pi).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, .8, curve: Curves.decelerate),
          ),
        );
  final AnimationController controller;
  final Animation<double> scale;
  final Animation<double> transform;
  final Animation<double> rotate;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.rotate(
          //the radians convert the value to pi
          angle: rotate.value /*radians(360) */,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              itemsButton(0, color: Colors.purple, icon: Icons.home),
              itemsButton(45, color: Colors.red.shade200, icon: Icons.add),
              itemsButton(90,
                  color: Colors.orange.shade200,
                  icon: Icons.location_on_outlined),
              itemsButton(135, color: Colors.brown.shade100, icon: Icons.menu),
              itemsButton(180,
                  color: Colors.green, icon: Icons.new_releases_sharp),
              itemsButton(225, color: Colors.teal, icon: Icons.help),
              itemsButton(270,
                  color: Colors.yellowAccent.shade100,
                  icon: Icons.video_camera_back_sharp),
              itemsButton(315, color: Colors.pink, icon: Icons.image),
              Transform.scale(
                scale: scale.value - 1.3,
                child: FloatingActionButton(
                  onPressed: close,
                  backgroundColor: Colors.blue[100],
                  child: const Icon(Icons.cancel_presentation_rounded),
                ),
              ),
              Transform.scale(
                scale: scale.value,
                child: FloatingActionButton(
                  onPressed: open,
                  backgroundColor: Colors.blue[100],
                  child: const Icon(
                    Icons.stop_circle,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  itemsButton(double angle, {required Color color, required IconData icon}) {
    double rad = radians(angle);
    return Transform(
      transform: Matrix4.identity()
        ..translate(
          (transform.value) * cos(rad),
          (transform.value) * sin(rad),
        ),
      child: FloatingActionButton(
        elevation: 0.5,
        onPressed: close,
        backgroundColor: color,
        child: Icon(
          icon,
        ),
      ),
    );
  }

  close() {
    controller.reverse();
  }

  open() {
    controller.forward();
  }
}
