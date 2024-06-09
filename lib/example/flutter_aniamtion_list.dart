import 'package:flutter/material.dart';
import 'package:tutorial_animation/model/animatedlist_model.dart';

class AnimationListViewExample extends StatefulWidget {
  const AnimationListViewExample({super.key});

  @override
  State<AnimationListViewExample> createState() =>
      _AnimationListViewExampleState();
}

class _AnimationListViewExampleState extends State<AnimationListViewExample> {
  final List<User> selectedItem = [];
  final GlobalKey<AnimatedListState> itemKey = GlobalKey<AnimatedListState>();
  final GlobalKey<AnimatedListState> selectItemKey =
      GlobalKey<AnimatedListState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 25, right: 25),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 200,
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    const Text("Selected Members"),
                    const SizedBox(
                      height: 20,
                    ),
                    //for display selected user
                    Expanded(
                        child: AnimatedList(
                      key: selectItemKey,
                      initialItemCount: selectedItem.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index, animation) {
                        return displaySelectedUserItem(
                            animation: animation,
                            index: index,
                            user: selectedItem[index]);
                      },
                    ))
                  ],
                ),
              ),
              //for items
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: AnimatedList(
                  key: itemKey,
                  initialItemCount: users.length,
                  itemBuilder: (context, index, animation) {
                    return userItem(
                        animation: animation, index: index, user: users[index]);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding displaySelectedUserItem(
      {required Animation<double> animation,
      required int index,
      required User user}) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: FadeTransition(
        opacity: animation,
        child: Column(
          children: [
            SizedBox(
              width: 50,
              child: Text(
                user.name,
                maxLines: 1,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Stack(
              children: [
                Positioned(
                  child: SizedBox(
                    height: 70,
                    width: 70,
                    child: CircleAvatar(
                      backgroundColor: Colors.deepPurpleAccent,
                      backgroundImage: NetworkImage(user.image),
                    ),
                  ),
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            itemKey.currentState?.insertItem(
                              users.length,
                              duration: const Duration(milliseconds: 500),
                            );
                            selectItemKey.currentState?.removeItem(
                              index,
                              (context, animation) => displaySelectedUserItem(
                                  animation: animation,
                                  index: index,
                                  user: user),
                            );
                            selectedItem.remove(user);
                            users.add(user);
                          },
                        );
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 15,
                        ),
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector userItem(
      {required Animation<double> animation,
      required int index,
      required User user}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedItem.length > 4) return;

          selectItemKey.currentState?.insertItem(
            selectedItem.length,
            duration: const Duration(
              microseconds: 500,
            ),
          );

          itemKey.currentState?.removeItem(index, (context, animation) {
            return userItem(animation: animation, index: index, user: user);
          });
          selectedItem.add(user);
          users.remove(user);
        });
      },
      child: FadeTransition(
        opacity: animation,
        child: Container(
          padding: const EdgeInsets.only(top: 15),
          child: Row(
            children: [
              SizedBox(
                height: 70,
                width: 70,
                child: CircleAvatar(
                  backgroundColor: Colors.deepPurpleAccent,
                  backgroundImage: NetworkImage(user.image),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    user.username,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black45),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
