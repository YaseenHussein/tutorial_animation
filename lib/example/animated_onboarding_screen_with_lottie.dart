import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tutorial_animation/model/animation_lottie_images.dart';

class AnimatedOnboardingScreenWithLottie extends StatefulWidget {
  const AnimatedOnboardingScreenWithLottie({super.key});

  @override
  State<AnimatedOnboardingScreenWithLottie> createState() =>
      _AnimatedOnboardingScreenWithLottieState();
}

class _AnimatedOnboardingScreenWithLottieState
    extends State<AnimatedOnboardingScreenWithLottie> {
  int currentIndex = 0;
  late PageController pageController;
  @override
  void initState() {
    pageController = PageController();

    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomPaint(
            painter: ArcPainter(),
            child: SizedBox(
              width: size.width,
              height: size.height / 1.35,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            child: Lottie.network(
              onBoardingModel[currentIndex].imageUrl,
              fit: BoxFit.cover,
              alignment: AlignmentDirectional.centerStart,
            ),
          ),
          // for scrolling
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: SizedBox(
              height: 270,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: onBoardingModel.length,
                      itemBuilder: (context, index) {
                        final items = onBoardingModel[index];
                        return Column(
                          children: [
                            Text(
                              items.label,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Text(
                              items.description,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black45),
                            ),
                          ],
                        );
                      },
                      onPageChanged: (value) {
                        setState(() {
                          currentIndex = value;
                        });
                      },
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(onBoardingModel.length, (index) {
                      return indictor(isActive: index == currentIndex);
                    }),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOutCirc);
        },
        backgroundColor: Colors.white,
        elevation: 0,
        child: const Icon(Icons.arrow_forward_ios_outlined),
      ),
    );
  }

  AnimatedContainer indictor({required isActive}) {
    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      height: 10,
      width: isActive ? 25 : 10,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCirc,
      decoration: BoxDecoration(
          color: isActive ? Colors.black : Colors.black54,
          borderRadius: BorderRadius.circular(12)),
    );
  }
}

class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path orangeArc = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height - 175)
      ..quadraticBezierTo(
          size.width / 2, size.height, size.width, size.height - 175)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(
      orangeArc,
      Paint()..color = Colors.orange,
    );

    Path whiteArc = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height - 180)
      ..quadraticBezierTo(
          size.width / 2, size.height - 60, size.width, size.height - 180)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(
      whiteArc,
      Paint()..color = const Color.fromARGB(255, 144, 202, 249),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
