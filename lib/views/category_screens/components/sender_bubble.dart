import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants/firebase_consts.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;

Widget senderBubble(DocumentSnapshot data){
  var t = data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();

  var time = intl.DateFormat("h:mma").format(t);
  return Container(
    padding: const EdgeInsets.all(10.0),
    margin: const EdgeInsets.all(10.0),
    decoration: const BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(0), bottomLeft: Radius.circular(10)
        )
    ),
    child: Column(
      crossAxisAlignment: data['uid']==currentUser.value!.uid ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
         Text('${data['msg']}', style: const TextStyle(
          // color: Colors.white,
            fontSize: 18
        ),),
        10.heightBox,
         Text(time.toString())
      ],
    ),
  );
}