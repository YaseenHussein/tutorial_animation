import 'package:flutter/material.dart';

class Products {
  final String image;
  final Color color;

  const Products({required this.color, required this.image});
}

List<Products> myProducts = const [
  Products(image: "assets/images/image1.png", color: Color(0xff000000)),
  Products(
    color: Color(0xfffcecd0),
    image: "assets/images/image3.png",
  ),
  Products(
    color: Color(0xffb6d7e4),
    image: "assets/images/image2.png",
  ),
];
