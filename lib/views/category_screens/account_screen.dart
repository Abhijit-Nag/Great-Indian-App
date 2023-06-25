import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants/firebase_consts.dart';
import 'package:ecommerce_app/constants/profile_constants.dart';
import 'package:ecommerce_app/controllers/auth_controller.dart';
import 'package:ecommerce_app/controllers/profile_controller.dart';
import 'package:ecommerce_app/services/firestore_services.dart';
import 'package:ecommerce_app/views/auth_screen/login_screen.dart';
import 'package:ecommerce_app/views/category_screens/components/detail_card.dart';
import 'package:ecommerce_app/views/category_screens/edit_profile_screen.dart';
import 'package:ecommerce_app/views/category_screens/messages_screen/messages_screen.dart';
import 'package:ecommerce_app/views/category_screens/order_screen.dart';
import 'package:ecommerce_app/views/category_screens/wishlist_screen/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    var auth_controller= Get.put(AuthController());
    print(currentUser.value!.uid);
    print('previous and present user id same: ${'FIkyW0rUq5bQzUGHEhVXwSYtLdk1' == currentUser.value!.uid}');
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.88),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(children: [
          const Text('Hello!'),
          20.widthBox,
          const Text('Mr. Nag')
        ],),
        actions: [
           IconButton(onPressed: (){}, icon: const Icon(Icons.shopping_cart, ).marginOnly(right: 10))
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FireStoreServices.getUser(currentUser.value!.uid),
        // stream: FirebaseFirestore.instance.collection(usersCollection).doc('yF0EaDyaWCpx06A253cS').snapshots(),
        builder:( BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){




          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.red),),
            );
          }else{

            // Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
            Map<String, dynamic>? data = snapshot.data!.data() as Map<String, dynamic>?;
            // fetchData()async{
            //
            //
            // // final data=await fireStore.collection(usersCollection).where('id', isEqualTo: currentUser!.uid).get();
            // // var data= snapshot.data!.docs[0];
            // print(data.docs[);
            // }
            // fetchData();
            // final data= snapshot.data;
            // for(int i=0;i<data.length;i++){
            //   if(data[i]['id'])
            // }
            // print((data));
            // print(data.name);
            final name= data?['name'] ?? '';
            // print(data?['email']);
            print(data);
            // print(currentUser);
            // print(currentUser!.uid == 'oKGpqxxChyejaY3HWZtF18GlEei1');
            // print(currentUser!.uid);
            print('7f0KkXtZuxNBpxIBFiUwcV3HeEh2'=='7f0KkXtZuxNBpxIBFiUwcV3HeEh2');
            // Map<String, dynamic> info = data;
            // print();
            // print(snapshot.data!.docs[0]['email']);
            // print(FireStoreServices.getUser(currentUser!.uid));
            // print(snapshot.hasData);


            return Container(
              // color: Colors.white.withOpacity(0.88),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    20.heightBox,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            data?['imageUrl']==''?
                            const CircleAvatar(child: Icon(Icons.person)):
                            Image.network(data?['imageUrl'], width: 100, height: 100,),
                            Expanded(
                              child: Column(
                                children: [
                                  Text('${data?['name']}'),
                                  Text('${data?['email']}')
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: ()async{
                                await auth_controller.signOutMethod(context: context);
                                // await Get.put(AuthController()).signOutMethod(context: context);
                                // if(currentUser == null){
                                // }
                                // currentUser= null;
                                Get.offAll(()=>  LoginScreen());

                              },
                              child: Text('Logout', style: GoogleFonts.lato(
                                  color: Colors.white
                              ),),
                            )
                          ],
                        ),
                        // IconButton(onPressed: (){
                        //   controller.nameController.text=data?['name'];
                        //   // controller.passwordController.text= data?['password'];
                        //   Get.to(()=>EditProfileScreen(data: data,));
                        // }, icon: const Icon(Icons.edit, color: Colors.white,)).
                        // box.color(Colors.blue).
                        // margin(const EdgeInsets.only(right: 290, top: 5, bottom: 5)).make(),
                        ElevatedButton(onPressed: (){
                          controller.nameController.text=data?['name'];
                          // controller.passwordController.text= data?['password'];
                          Get.to(()=>EditProfileScreen(data: data,));
                        }, child: const Text('Edit'))
                      ],
                    ).paddingOnly(left: 20, right: 20, top: 25, bottom: 5).box.color(Colors.white).margin(const EdgeInsets.symmetric(horizontal: 10)).make(),


                    FutureBuilder(
                      future: FireStoreServices.getCountAllCarts(),
                        builder: (BuildContext context, AsyncSnapshot snapshot){
                        if(!snapshot.hasData){
                          return const Center(child: CircularProgressIndicator(),);
                        }else{
                          var data= snapshot.data;
                          return GridView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 100, crossAxisSpacing: 8, mainAxisSpacing: 8),
                            children: [
                              DetailCard(count: data[1].toString(), title: "In Your Cart"),
                              DetailCard(count: data[0].toString(), title: "In Your WishList"),
                              DetailCard(count: data[2].toString(), title: "Your Orders"),
                            ],
                          ).box.margin(const EdgeInsets.symmetric(horizontal: 10, vertical: 10)).make();
                        }
                        })

                    ,


                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: profileButtons.length,
                      shrinkWrap: true,
                      separatorBuilder: (context, index){
                        return Container(
                          height: 1,
                          color: Colors.grey.withOpacity(0.28),
                        );
                      },
                      itemBuilder: (BuildContext context , int index){
                        return ListTile(
                          title: Text(profileButtons[index]['title'] as String),
                          leading: profileButtons[index]['icon'] as Icon,
                        ).paddingSymmetric(horizontal: 5, vertical: 5)
                        .onTap(() {
                          switch (index){
                            case 0:
                              Get.to(()=>OrderScreen());
                              break;
                            case 1:
                              Get.to(()=>WishlistScreen());
                              break;
                            case 2:
                              Get.to(()=>MessagesScreen());
                              break;
                          }
                          // if(index ==0){
                          //   Get.to(()=>OrderScreen());
                          // }else if(index ==1){
                          //   Get.to(()=> WishlistScreen());
                          // }else{
                          //   Get.to(()=> MessagesScreen());
                          // }
                        });
                      },
                    ).color(Colors.white)
                        .marginSymmetric(horizontal: 10)
                  ],
                ),
              ),
            );
          }





        },
      ),
    );
  }
}
