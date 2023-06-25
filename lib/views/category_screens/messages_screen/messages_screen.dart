import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/services/firestore_services.dart';
import 'package:ecommerce_app/views/chat_screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.88),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('My Messages'),
      ),
      body: StreamBuilder(
          stream: FireStoreServices.getAllMessages(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot){
            if(!snapshot.hasData){
              return const Center(child: CircularProgressIndicator());
            }
            if(snapshot.hasError){
              return Center(child: Text(snapshot.error.toString()),);
            }
            if(snapshot.data!.docs.isEmpty){
              return const Center(child: Text('No orders yet'),);
            }
            var data = snapshot.data!.docs;
            return ListView.builder(
              itemCount: data.length,
                itemBuilder: (context, index){
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  color: Colors.white,
                  child: ListTile(
                    leading: const CircleAvatar(backgroundColor: Colors.green, child: Icon(Icons.person, color: Colors.white,),),
                    title: Text(data[index]['friend_name']),
                    subtitle: Text(data[index]['last_msg']),
                    trailing: SizedBox(
                      width: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${ intl.DateFormat("h:mma").format(data[index]['created_on'].toDate())}'),
                          const Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                ).onTap(() {
                  Get.to(()=>ChatScreen(),
                  arguments: [
                    data[index]['friend_name'],
                    data[index]['toId']
                  ]);
                });
                });
          }),
    );
  }
}
