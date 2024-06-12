import 'package:flutter/material.dart';
import 'package:tutorial_animation/example/animated_onboarding_screen_with_lottie.dart';
import 'package:tutorial_animation/example/animation_button.dart';
import 'package:tutorial_animation/example/download_button_animation.dart';
import 'package:tutorial_animation/example/draggable_scrollable.dart';
import 'package:tutorial_animation/example/fab_circular_animation.dart';
import 'package:tutorial_animation/example/flutter_aniamtion_list.dart';
import 'package:tutorial_animation/example/scale_transaction_example.dart';
import 'package:tutorial_animation/example/shimmer_loader.dart';
import 'package:tutorial_animation/example/swipeable_button_view_example.dart';
import 'package:tutorial_animation/login_register_app/screen/splash_view.dart';

import 'package:tutorial_animation/login_rive_animation/rive_login_animation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SwipeableButtonViewExample(),
    );
  }
}
