import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class DetailCard extends StatelessWidget {
  String count, title;
  DetailCard({Key? key, required this.count, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(count, style: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.w500
        ),),
        10.heightBox,
        Text(title, style: GoogleFonts.lato(
          fontSize: 18,
        ),)
      ],
    ).box.padding(const EdgeInsets.all(5)).color(Colors.white).make();
  }
}
