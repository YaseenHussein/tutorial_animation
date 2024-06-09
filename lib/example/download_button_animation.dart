import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tutorial_animation/painter/custom_painter.dart';

class DownloadButtonAnimationExample extends StatefulWidget {
  const DownloadButtonAnimationExample({super.key});

  @override
  State<DownloadButtonAnimationExample> createState() =>
      _DownloadButtonAnimationExampleState();
}

class _DownloadButtonAnimationExampleState
    extends State<DownloadButtonAnimationExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationWidth;
  late Animation<double> _animationFontSize;
  late Animation<double> _animationOpacity;
  late Animation<double> _animationCircular;
  late Animation<Offset> _animationFirst;
  late Animation<Offset> _animationSecond;
  late Animation<Offset> _animationCenterDot;
  late Animation<double> _animationSizeOfDot;
  late Animation<double> _animationOpacityOfSizeOfDot;
  Offset firstDot = const Offset(-15, 5);
  Offset firstCommon = const Offset(-5, 15);
  Offset secondDot = const Offset(20, -10);
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));
    _animationWidth = Tween<double>(begin: 250, end: 110).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0,
          0.5,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    _animationFontSize = Tween<double>(begin: 30, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0,
          0.3,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    _animationOpacity = TweenSequence<double>(
      [
        TweenSequenceItem(
          tween: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).chain(
            CurveTween(
              curve: Curves.fastOutSlowIn,
            ),
          ),
          weight: 50,
        ),
        TweenSequenceItem(
          tween: Tween<double>(
            begin: 1.0,
            end: 0.0,
          ).chain(
            CurveTween(
              curve: Curves.fastOutSlowIn,
            ),
          ),
          weight: 50,
        ),
      ],
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.03,
          0.5,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    _animationCircular = Tween<double>(begin: 0, end: pi * 2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.3,
          0.8,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    _animationFirst = Tween<Offset>(begin: firstDot, end: firstCommon).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.9,
          0.99,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    _animationSecond =
        Tween<Offset>(begin: firstCommon, end: secondDot).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.9,
          0.99,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    _animationCenterDot =
        Tween<Offset>(begin: Offset.zero, end: firstDot).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.8,
          0.9,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    _animationSizeOfDot = Tween<double>(begin: 8.0, end: 3.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.8,
          0.9,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    _animationOpacityOfSizeOfDot = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.3,
          0.3,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
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
        child: GestureDetector(
          onTap: () {
            _controller.forward();
          },
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: _animationWidth.value,
                    height: 110,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(60),
                      border: Border.all(color: Colors.blue, width: 5),
                    ),
                    child: Text(
                      "Download",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: _animationFontSize.value,
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: _animationOpacity.value,
                    child: const Icon(
                      Icons.arrow_downward,
                      size: 55,
                    ),
                  ),
                  CustomPaint(
                    painter: ArcPaint(
                      startAngle: pi / 2,
                      endAngle: _animationCircular.value,
                    ),
                  ),
                  CustomPaint(
                    painter: LinearPaint(
                      first: _animationFirst,
                      second: _animationSecond,
                      firstDot: firstDot,
                      firstCommon: firstCommon,
                      secondDot: secondDot,
                    ),
                  ),
                  Opacity(
                    opacity: _animationOpacityOfSizeOfDot.value,
                    child: CustomPaint(
                      painter: DotPainter(
                          radius: _animationSizeOfDot.value,
                          offset: _animationCenterDot.value),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
