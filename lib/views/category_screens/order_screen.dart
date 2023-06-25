import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/services/firestore_services.dart';
import 'package:ecommerce_app/views/category_screens/order_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_transition_mixin.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('My Orders'),
      ),
      body: StreamBuilder(
        stream: FireStoreServices.getOrders(),
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
          else{
            var data= snapshot.data!.docs;
            return ListView.builder(
              itemCount: data.length,
                itemBuilder: (context, index){
              return ListTile(
                onTap: (){
                  Get.to(()=> OrderDetails(
                    data: data[index],
                      orderId: data[index]['order_code'.toString()]));
                },
                leading: Image.network(data[index]['orders'][0]['image'].toString()),
                title: Text(data[index]['order_code'].toString()),
                subtitle: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.currency_rupee, size: 15,),
                    Text(data[index]['total_amount'].toString().numCurrency),
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              );
            });
          }
      }),
    );
  }
}
