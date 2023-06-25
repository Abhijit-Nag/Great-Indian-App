
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants/firebase_consts.dart';
import 'package:ecommerce_app/controllers/chats_controller.dart';
import 'package:ecommerce_app/services/firestore_services.dart';
import 'package:ecommerce_app/views/category_screens/components/sender_bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Chats'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(() =>
            controller.isLoading.value ?  const Center(child: CircularProgressIndicator()):
            Expanded(
              child: StreamBuilder(
                  stream: FireStoreServices.getChats(controller.chatDocId.toString()),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot){
                    if(!snapshot.hasData){
                      return const Center(child: CircularProgressIndicator());
                    }
                    if(snapshot.data!.docs.isEmpty){
                      return const Center(child: Text('Start messaging with the vendor directly..'),);
                    }
                    else{
                      return ListView(
                        children: snapshot.data!.docs.mapIndexed((currentValue, index){
                          var data= snapshot.data!.docs[index];
                          return Align(
                            alignment: data['uid'] == currentUser.value!.uid ? Alignment.centerRight : Alignment.centerLeft,
                              child: senderBubble(data));
                        }).toList(),
                      );
                    }

                  }),
            ))
            ,

             Row(
              children: [
                 Expanded(
                  child: TextFormField(
                    controller: controller.msgController,
                    decoration: const InputDecoration(
                      hintText: 'Type Message'
                    ),
                  ),
                ),
                const Icon(Icons.send, color: Colors.green,).onTap(() async {
                  await controller.sendMsg(controller.msgController.text);
                  controller.msgController.clear();
                })
              ],
            ).box.margin(const EdgeInsets.symmetric(horizontal: 10)).make()
          ],
        ),
      ),
    );
  }
}
