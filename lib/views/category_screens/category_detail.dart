import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants/lists.dart';
import 'package:ecommerce_app/controllers/product_controller.dart';
import 'package:ecommerce_app/controllers/profile_controller.dart';
import 'package:ecommerce_app/services/firestore_services.dart';
import 'package:ecommerce_app/views/category_screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryDetailScreen extends StatelessWidget {
  String categoryTitle;
  CategoryDetailScreen({Key? key, required this.categoryTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller= Get.find<ProductController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0C1D36),
        title: Text(
          categoryTitle,
          style: GoogleFonts.firaSans(),
        ),
      ),
      body: StreamBuilder(
        stream: FireStoreServices.getProducts(categoryTitle),
          builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return const Center(child:  CircularProgressIndicator());
          }
          else if(snapshot.data!.docs.isEmpty){
            return const Center(
              child:  Text('No Data Found', style: TextStyle(color: Colors.white),),
            );
          }
          else{
            var data = snapshot.data!.docs;
            print(data[0]['p_seller']);
            return Container(
              color: Colors.white.withOpacity(0.88),
              height: context.height,
              width: context.width,
              padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: List.generate(controller.subCat.length, (index){
                        return Container(
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white
                          ),
                          child:  Text('${controller.subCat[index]}'),
                        );
                      }),
                    ),
                  ),

                  20.heightBox,

                  Expanded(
                    child: GridView.builder(
                        itemCount: data.length,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20,
                          mainAxisExtent: 280,
                        ),
                        itemBuilder: (context, index){
                          return GestureDetector(
                            onTap: (){
                              controller.checkIfFavorite(data[index]);
                              Get.to(()=> ProductDetailScreen( productName: data[index]['p_name'] , data: data[index],));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              margin: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white
                              ),
                              child:  Column(
                                children: [

                                  // Image(image: AssetImage('assets/images/laptop1.jpg'),
                                  //   fit: BoxFit.fitWidth,
                                  // ),
                                  Image.network(data[index]['p_images'][0]),
                                  10.heightBox,
                                  Text('${data[index]['p_name']}', style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w500,

                                  ),),
                                  15.heightBox,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('₹ ${data[index]['p_price']}', style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 15,
                                        color: Colors.green,
                                      ),
                                      ),


                                      const Icon(Icons.favorite_rounded, color: Colors.pinkAccent,)


                                    ],
                                  ),
                                  // Align(
                                  //   alignment: Alignment.centerLeft,
                                  //   child: Text('₹ ${data[index]['p_price']}', style: GoogleFonts.roboto(
                                  //       fontWeight: FontWeight.w800,
                                  //       fontSize: 15,
                                  //       color: Colors.green,
                                  //   ),
                                  //   ),
                                  // ),
                                  // const Align(
                                  //   alignment: Alignment.topRight,
                                  //   child: Icon(Icons.favorite_rounded, color: Colors.pinkAccent,),
                                  // )
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            );
          }


          }

      ),







      // body: Container(
      //   color: Colors.white.withOpacity(0.88),
      //   height: context.height,
      //   width: context.width,
      //   padding: EdgeInsets.only(left: 10, right: 10, top: 15),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       SingleChildScrollView(
      //         scrollDirection: Axis.horizontal,
      //         physics: const BouncingScrollPhysics(),
      //         child: Row(
      //           children: List.generate(controller.subCat.length, (index){
      //             return Container(
      //               padding: const EdgeInsets.all(8.0),
      //               margin: const EdgeInsets.all(8.0),
      //               decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(5),
      //                   color: Colors.white
      //               ),
      //               child:  Text('${controller.subCat[index]}'),
      //             );
      //           }),
      //         ),
      //       ),
      //
      //       20.heightBox,
      //
      //       Expanded(
      //         child: GridView.builder(
      //             itemCount: 24,
      //             physics: const BouncingScrollPhysics(),
      //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //               crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20,
      //               mainAxisExtent: 240,
      //             ),
      //             itemBuilder: (context, index){
      //               return GestureDetector(
      //                 onTap: (){
      //                   Get.to(()=> ProductDetailScreen(image: "assets/images/laptop1.jpg", price: "₹ 89000", productName: "HP Pavilion Core i5 Intel Processor"));
      //                 },
      //                 child: Container(
      //                   padding: const EdgeInsets.all(10.0),
      //                   margin: const EdgeInsets.all(8.0),
      //                   decoration: BoxDecoration(
      //                       borderRadius: BorderRadius.circular(5),
      //                       color: Colors.white
      //                   ),
      //                   child:  Column(
      //                     children: [
      //                       Image(image: AssetImage('assets/images/laptop1.jpg'),
      //                         fit: BoxFit.fitWidth,
      //                       ),
      //                       10.heightBox,
      //                       Text('HP Pavilion Core i5 Intel Processor', style: GoogleFonts.roboto(
      //                         fontWeight: FontWeight.w500,
      //
      //                       ),),
      //                       10.heightBox,
      //                       Align(
      //                         alignment: Alignment.centerLeft,
      //                         child: Text('₹ 89000', style: GoogleFonts.roboto(
      //                             fontWeight: FontWeight.w800,
      //                             fontSize: 15,
      //                             color: Colors.green
      //                         ),
      //                         ),
      //                       ),
      //                       const Align(
      //                         alignment: Alignment.topRight,
      //                         child: Icon(Icons.favorite_rounded, color: Colors.pinkAccent,),
      //                       )
      //                     ],
      //                   ),
      //                 ),
      //               );
      //             }),
      //       )
      //     ],
      //   ),
      // ),






    );
  }
}
