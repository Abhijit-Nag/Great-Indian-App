import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10.0),
          child: "Are you sure, you want to exit?".text.fontWeight(FontWeight.bold).color(Colors.black.withOpacity(0.5)).size(18).make(),),
        10.heightBox,
        const Divider(),
        20.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {
              SystemNavigator.pop();
            }, child: const Text('Yes')).marginOnly(right: 10),
            ElevatedButton(onPressed: () {
              Navigator.pop(context);
            }, child: const Text('No')).marginOnly(left: 10)
          ],
        )
      ],
    ).box.roundedSM.padding(const EdgeInsets.all(10)).height(150).make(),
  );
}
