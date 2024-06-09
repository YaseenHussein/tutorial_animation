import 'package:flutter/material.dart';

class DraggableScrollable extends StatefulWidget {
  const DraggableScrollable({super.key});

  @override
  State<DraggableScrollable> createState() => _DraggableScrollableState();
}

class _DraggableScrollableState extends State<DraggableScrollable> {
  double sizeOfCard = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            bottom: MediaQuery.sizeOf(context).height * 0.3,
            child: Image.network(
              "https://i.sstatic.net/B6fEt.png",
              fit: BoxFit.cover,
            ),
          ),
          NotificationListener<DraggableScrollableNotification>(
            onNotification: (notification) {
              setState(() {
                sizeOfCard = 2 * notification.extent - 0.8;
              });
              return true;
            },
            child: Positioned(
              child: DraggableScrollableSheet(
                maxChildSize: 0.9,
                minChildSize: 0.38,
                builder: (context, scrollController) {
                  return Material(
                    color: Colors.white,
                    elevation: 15,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10),
                      child: ListView(
                        controller: scrollController,
                        //     physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        children: [
                          Center(
                            child: Container(
                              height: 3,
                              width: 50,
                              color: Colors.black45,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text("ara you ready to start your Tracking"),
                          const Text(
                            "where are you going?",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 28),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const TextField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                size: 25,
                              ),
                              hintText: "search your destination",
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: scrollController,
                            itemCount: 100,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: const Icon(Icons.location_on_outlined),
                                title: Text(
                                  "Address :$index",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text("City $index"),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              top: -160 * (1 - sizeOfCard),
              child: Opacity(
                opacity: sizeOfCard.clamp(0, 1),
                child: Material(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        const Text(
                          "choice your destination",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          decoration: InputDecoration(
                              hintText: "what is your name?",
                              fillColor: Colors.grey[100],
                              filled: true),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          decoration: InputDecoration(
                              hintText: "where are going?",
                              fillColor: Colors.grey[100],
                              filled: true),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
