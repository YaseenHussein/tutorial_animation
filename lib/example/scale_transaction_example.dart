import 'dart:async';

import 'package:flutter/material.dart';

class ScaleTransactionExample extends StatefulWidget {
  const ScaleTransactionExample({super.key});

  @override
  State<ScaleTransactionExample> createState() =>
      _ScaleTransactionExampleState();
}

class _ScaleTransactionExampleState extends State<ScaleTransactionExample>
    with SingleTickerProviderStateMixin {
  late Animation<double> scaleAnimation;
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    scaleAnimation = Tween<double>(begin: 1.0, end: 7).animate(_controller);
    _controller.addListener(() {
      if (_controller.isCompleted) {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return const SecondScreen();
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
        Timer(
          const Duration(microseconds: 100),
          () async {
            _controller.reset();
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          _controller.forward();
        },
        child: ScaleTransition(
          scale: scaleAnimation,
          child: const Center(
            child: CircleAvatar(
              radius: 80,
              backgroundColor: Colors.purpleAccent,
            ),
          ),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("second screen"),
      ),
      body: const Center(
        child: CircleAvatar(
          backgroundColor: Colors.deepPurpleAccent,
          radius: 50,
        ),
      ),
    );
  }
}
