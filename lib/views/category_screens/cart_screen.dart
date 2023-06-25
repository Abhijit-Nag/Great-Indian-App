import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants/firebase_consts.dart';
import 'package:ecommerce_app/controllers/cart_controlller.dart';
import 'package:ecommerce_app/services/firestore_services.dart';
import 'package:ecommerce_app/views/category_screens/shipping_screen.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    print(currentUser);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Shopping Cart', style: GoogleFonts.lato(
          color: Colors.black
        ),),
        backgroundColor: Colors.yellow,
      ),

      bottomNavigationBar: Container(
        color: Colors.red,
        height: 60,
        child:  const Center(child: Text('Buy Now', style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w800,
      ),)),
        
      ).onTap(() { 
        Get.to(()=> ShippingScreen());
      }),






      body: StreamBuilder(
        stream: FireStoreServices.getCart(currentUser.value!.uid),
        builder: (context, AsyncSnapshot<QuerySnapshot>snapshot){
          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator());
          }
          if(snapshot.data!.docs.isEmpty){
            return const Center(child: Text('Your Shopping Cart is Empty!', style: TextStyle(color: Colors.white),),);
          }
          if(snapshot.hasError){
            return const SnackBar(content: Text("Please check your internet connection")) ;
          }
          var data= snapshot.data!.docs;
          controller.calculate(data);
          controller.productSnapshots=data;
          return  Container(
            color: Colors.white.withOpacity(0.95),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                        itemBuilder: (context, index){
                        return ListTile(
                          leading: Image.network(data[index]['image']),
                          title: Row(
                            children: [
                              Text(data[index]['title']),
                              15.widthBox,
                              Row(
                                children: [
                                  const Icon(Icons.clear, size: 15,),
                                  Text('${data[index]['quantity']}')
                                ],
                              ).box.roundedSM.padding(const EdgeInsets.all(5)).color(const Color(0xffFFD700).withOpacity(0.5)).make()

                            ],
                          ),
                          subtitle: Row(
                            children: [
                              const Text('₹'),
                              Text(data[index]['p_price']),
                            ],
                          ),
                          trailing: const Icon(Icons.delete).onTap(() {
                            print(data[index].id);
                            FireStoreServices.deleteDocument(data[index].id);
                          }),
                        );
                        }
                    )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total price '),
                    Row(
                      children: [
                       const Text("₹"),
                        Obx(() => "${controller.totalPrice.value}".numCurrency.text.make())
                      ],
                    )
                  ],).box.padding(const EdgeInsets.all(12)).margin(const EdgeInsets.only(left: 10, right: 10)).color(const Color(0xffFFD700).withOpacity(0.5)).make(),
                10.heightBox,
                // Container(
                //   width: context.screenWidth -60,
                //   padding: const EdgeInsets.all(12.0),
                //   decoration:  BoxDecoration(
                //       color: Colors.red,
                //       borderRadius: BorderRadius.circular(5)
                //   ),
                //   child: const Center(child: Text('Buy Now', style: TextStyle(
                //     color: Colors.white,
                //     fontWeight: FontWeight.w800,
                //   ),)),
                // )
              ],
            ),
          );
        },
      ),







    );
  }
}
