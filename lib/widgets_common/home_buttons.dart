import 'package:flutter/material.dart';

Widget homeButtons(String text, IconData icon, onPress, double fontSize){
  return Expanded(child: InkWell(
    onTap: (){
      onPress();
    },
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
          ),

          // height: 30,
          // width: 30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  child: Icon(icon),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red,
                    width: 2
                  ),
                  borderRadius: BorderRadius.circular(5)
                ),
              ),
              SizedBox(height: 5,),
              Text(text, style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
              ),)
            ],
          ),
        )
      ],
    ),
  ));
}