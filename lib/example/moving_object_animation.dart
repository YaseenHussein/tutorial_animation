import 'package:flutter/material.dart';
import 'package:tutorial_animation/model/moving_object_mode.dart';

class MovingObjectAnimation extends StatefulWidget {
  const MovingObjectAnimation({super.key});

  @override
  State<MovingObjectAnimation> createState() => _MovingObjectAnimationState();
}

class _MovingObjectAnimationState extends State<MovingObjectAnimation>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> animation;
  late AnimationController animationController;
  int selectIndex = 0;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    )..repeat(reverse: true);
    animation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, 0.03),
    ).animate(animationController);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: const Icon(Icons.add),
      // ),
      // extendBody: true,
      backgroundColor: const Color.fromARGB(255, 41, 41, 41),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.6,
              child: SlideTransition(
                position: animation,
                child: AnimatedSwitcher(
                    duration: const Duration(
                      seconds: 3,
                    ),
                    child: Image.asset(
                        key: Key("$selectIndex"),
                        myProducts[selectIndex].image)),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              "BOAT ROCKERZ M450K",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white),
            ),
            const Text(
              "bluetooth headphone",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.grey,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                myProducts.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectIndex = index;
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                          color: selectIndex == index
                              ? Colors.white70
                              : Colors.transparent,
                        ),
                        color: myProducts[index].color,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        color: selectIndex == index
                            ? Colors.white
                            : Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
