import 'package:flutter/material.dart';
import 'package:tutorial_animation/example/add_to_cart_animation.dart';

import 'package:tutorial_animation/example/animated_onboardin_screen_with_lottie.dart';
import 'package:tutorial_animation/example/list_scroll_animation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AddToCartAnimation(),
    );
  }
}
