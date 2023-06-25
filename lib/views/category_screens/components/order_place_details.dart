import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

Widget orderPlaceDetails({required d1, required d2, required title1, required title2}){
  return  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title1, style: GoogleFonts.firaSans(
            fontSize: 16.5,
            fontWeight: FontWeight.w600,
            color: Colors.black.withOpacity(0.5)
          ),),
          5.heightBox,
          Text(d1.toString(),style: GoogleFonts.firaSans(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),)
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(title2,style: GoogleFonts.firaSans(
              fontSize: 16.5,
              fontWeight: FontWeight.w600,
              color: Colors.black.withOpacity(0.5)
          ),),
          5.heightBox,
          Text(d2.toString(),style: GoogleFonts.firaSans(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),)
        ],
      )
    ],
  );
}