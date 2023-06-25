import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants/firebase_consts.dart';
import 'package:ecommerce_app/controllers/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatsController extends GetxController {
  @override
  void onInit() async {
    await getChatId();
    super.onInit();
  }

  var chats = fireStore.collection(chatsCollection);
  var friendName = Get.arguments[0];
  var friendId = Get.arguments[1];

  // var senderName = Get.find<HomeController>().username.value;
  var senderName = Get.put(HomeController()).username.value;
  String ? currentId = currentUser.value?.uid;

  var msgController = TextEditingController();


  var isLoading = false.obs;
  dynamic chatDocId;

  getChatId() async {
    // await chats.where('users', isEqualTo: {
    //   friendId: null,
    //   currentId: null
    // }).limit(1).get().then((QuerySnapshot snapshot){
    //   if(snapshot.docs.isNotEmpty){
    //     chatDocId=snapshot.docs.single.id;
    //     print('chat document exists.');
    //   }else{
    //     print('new Chat document created here.');
    //     chats.doc().set({
    //       'created_on': null,
    //       'last_msg': '',
    //       'users':{
    //         friendId: null, currentId: null
    //       },
    //       'toId': friendId,
    //       'fromId':currentId,
    //       'friend_name': friendName,
    //       'sender_name' : senderName
    //     }).then((value){
    //       // chatDocId=value.id;
    //     });
    //   }
    // });

    isLoading(true);
    var chat = await chats
        .where('users', isEqualTo: {friendId: null, currentId: null}).get();
    print('chat response : ${chat.docs.isEmpty}');

    if (chat.docs.isNotEmpty) {
      chatDocId = chat.docs.single.id;
      print(chatDocId);
    } else {
      print('new chat document created here.');
      // print('${currentId}');
       var response =await chats.doc().set({
        'created_on': null,
         'friend_name': friendName,
         'sender_name': senderName,
        'last_msg': '',
        'users': {'$friendId': null, currentId: null},
        'toId': friendId,
        'fromId': currentId,
      })
      ;
       chatDocId= chats.doc().id;
       print(chatDocId);

    }

    isLoading(false);

  }

  sendMsg(String msg) async {
    if (msg.trim().isNotEmpty) {
      chats.doc(chatDocId).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'fromId': currentId,
        'toId': friendId
      });

      chats.doc(chatDocId).collection(messagesCollection).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': currentId,
      });
    }
  }
}
