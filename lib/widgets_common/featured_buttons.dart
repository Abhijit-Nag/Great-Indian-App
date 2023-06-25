import 'package:flutter/material.dart';

Widget featuredButtons(String title, String image, onPress){
  return Container(
    height: 50,
    width: 165,
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    margin: EdgeInsets.only(right: 15,left: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5)
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image(image: AssetImage(image),
        height: 35,
        width: 35,),
        Text(title)
      ],
    ),
  );
}