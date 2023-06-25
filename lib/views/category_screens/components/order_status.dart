import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

Widget orderStatus({icon, title, color, showDone}){
  return ListTile(
    leading: Icon(icon, color: color,).box.border(color: color, width: 2).roundedSM.padding(const EdgeInsets.all(5.0)).make(),
    title: Container(
      height: 3,
      width: 150,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50)
      ),
    ),
    trailing: SizedBox(
      height: 120,
      width: 168,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Text(title, style: GoogleFonts.firaSans(
            fontSize: 18
          ),),
          showDone ? const Icon(Icons.done_outline_sharp, color: Colors.red,) : Container()
        ],
      ),
    ),
  );
}