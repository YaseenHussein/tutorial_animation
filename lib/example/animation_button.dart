import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class AnimationButtons extends StatelessWidget {
  const AnimationButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const MyButtonItems(
              color: Colors.white,
              child: Text(
                "Click here",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
            const MyButtonItems(
              color: Colors.deepPurple,
              child: Text(
                "Click here",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
            ),
            MyButtonItems(
              color: Colors.orangeAccent,
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.white,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [WavyAnimatedText("Click here")],
                  onTap: () {},
                  repeatForever: true,
                  pause: const Duration(milliseconds: 300),
                  displayFullTextOnTap: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyButtonItems extends StatefulWidget {
  const MyButtonItems({super.key, required this.child, required this.color});
  final Widget child;
  final Color color;
  @override
  State<MyButtonItems> createState() => _MyButtonItemsState();
}

class _MyButtonItemsState extends State<MyButtonItems>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.purple,
              widget.color,
              Colors.blue,
            ], stops: [
              0.0,
              _controller.value,
              1.0
            ]),
            borderRadius: BorderRadius.circular(20),
          ),
          child: child,
        );
      },
    ));
  }
}
