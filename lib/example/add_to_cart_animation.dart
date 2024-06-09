import 'package:flutter/material.dart';

class AddToCartAnimation extends StatefulWidget {
  const AddToCartAnimation({super.key});

  @override
  State<AddToCartAnimation> createState() => _AddToCartAnimationState();
}

class _AddToCartAnimationState extends State<AddToCartAnimation> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            },
            );
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 800),
            height: 70,
            width: isExpanded ? 220 : 90,
            decoration: BoxDecoration(
              color: isExpanded ? Colors.green : Colors.purpleAccent,
              borderRadius: BorderRadius.circular(isExpanded ? 50 : 10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isExpanded)
                  const SizedBox(
                    width: 25,
                  ),
                Icon(
                  isExpanded ? Icons.check : Icons.shopping_cart,
                  size: 30,
                  color: Colors.white,
                ),
                if (isExpanded) ...[
                  const SizedBox(
                    width: 5,
                  ),
                  const Expanded(
                    flex: 2,
                    child: Text(
                      maxLines: 1,
                      "Add to Cart",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
