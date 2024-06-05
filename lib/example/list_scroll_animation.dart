import 'package:flutter/material.dart';
import 'package:tutorial_animation/model/scroll_items.dart';
 
class ListScrollAnimation extends StatefulWidget {
  const ListScrollAnimation({super.key});

  @override
  State<ListScrollAnimation> createState() => _ListScrollAnimationState();
}

class _ListScrollAnimationState extends State<ListScrollAnimation> {
  bool closeContainer = false;
  double myTopContainer = 0;
  List<Widget> myItems = [];
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    myBodyItem();
    scrollController.addListener(
      () {
        //Overall, this code creates a scroll animation effect where the top container expands and collapses based on the scroll position, and the list items fade in and scale based on the scroll position. The division by 120 in the line double myData = scrollController.offset / 120; is used to control the sensitivity of the animation. By dividing the scroll offset by 120, the animation will be smoother and slower.
        double myData = scrollController.offset / 120;

        setState(
          () {
            myTopContainer = myData;
            closeContainer = scrollController.offset > 50;
          },
        );
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SizedBox(
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            AnimatedOpacity(
              opacity: closeContainer ? 0 : 1,
              duration: const Duration(milliseconds: 500),
              child: AnimatedContainer(
                width: size.width,
                height: closeContainer ? 0 : size.height * 0.31,
                duration: const Duration(milliseconds: 500),
                alignment: Alignment.topCenter,
                child: ListView(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          Text(
                            "Discover",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "view all",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black26,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                            color: Colors.black26,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.25,
                      child: ListView.builder(
                        itemCount: 16,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return discoverItem(
                            size: size,
                            color: Colors.accents[index],
                            name: "super saving",
                            numOfItem: "20 items",
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 22),
              child: Text(
                "My Coupons",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black45),
              ),
            ),
            AnimatedScrollView(
                scrollController: scrollController,
                myItems: myItems,
                myTopContainer: myTopContainer)
          ],
        ),
      )),
    );
  }

  void myBodyItem() {
    List<Widget> listItems = [];
    for (ScrollItems item in dataItem) {
      listItems.add(
        Container(
          height: 160,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
              )
            ],
            borderRadius: BorderRadius.circular(20),
            color: Color(item.color),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              Image.asset(
                item.image,
                height: 60,
                fit: BoxFit.cover,
              )
            ],
          ),
        ),
      );
    }
    setState(() {
      myItems = listItems;
    });
  }

  Container discoverItem(
      {required Size size,
      required Color? color,
      required String name,
      required String numOfItem}) {
    return Container(
      height: size.height * 0.23,
      width: 170,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    height: 1.5,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  numOfItem,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                )
              ],
            ),
            const Positioned(
              right: 10,
              bottom: 10,
              child: Icon(
                Icons.favorite_border_sharp,
                color: Colors.white54,
                size: 40,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AnimatedScrollView extends StatelessWidget {
  const AnimatedScrollView({
    super.key,
    required this.scrollController,
    required this.myItems,
    required this.myTopContainer,
  });

  final ScrollController scrollController;
  final List<Widget> myItems;
  final double myTopContainer;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView.builder(
          controller: scrollController,
          itemCount: myItems.length,
          itemBuilder: (BuildContext context, int index) {
            //this condition calculates the value of opacity based on the value of myTopContainer and ensures that it is within the range of 0 to 1.
            double opacity = 1.0;
            if (myTopContainer > .5) {
              opacity = index + 0.5 - myTopContainer;
              if (opacity < 0) {
                opacity = 0.0;
              } else if (opacity > 1) {
                opacity = 1;
              }
            }

            return Opacity(
              opacity: opacity,
              child: Transform(
                transform: Matrix4.identity()..scale(opacity, opacity),
                alignment: Alignment.topCenter,
                child: Align(
                  heightFactor: 0.7,
                  child: myItems[index],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
