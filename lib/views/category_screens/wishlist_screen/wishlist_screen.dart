import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/controllers/product_controller.dart';
import 'package:ecommerce_app/services/firestore_services.dart';
import 'package:ecommerce_app/views/category_screens/account_screen.dart';
import 'package:ecommerce_app/views/category_screens/product_detail_screen.dart';
import 'package:ecommerce_app/views/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text('My Wishlist'),
      ),
      body: StreamBuilder(
          stream: FireStoreServices.getWishlists(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot){
            if(!snapshot.hasData){
              return const Center(child: CircularProgressIndicator());
            }
            if(snapshot.hasError){
              return Center(child: Text(snapshot.error.toString()),);
            }
            if(snapshot.data!.docs.isEmpty){
              return const Center(child: Text('No Products added to wishlist yet'),);
            }
            var data= snapshot.data!.docs;
            String text ="fjdklfjdklfjkldjfljdklfjdklkdfjkldfkdjkfkdjkfjd";
            var textData= text.length;
            print(text.length> 30 ? text.substring(0, 28) : text);
            return ListView.builder(
              itemCount: data.length,
                itemBuilder: (context, index){
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  color: Colors.white,
                  child: ListTile(
                    leading: Image.network(data[index]['p_images'][0]),
                    title: Text(data[index]['p_name']),
                    subtitle: Text(data[index]['p_description'].length >30 ?'${data[index]['p_description'].substring(0,28)}.....' : data[index]['p_description']),
                    trailing: const Icon(Icons.favorite_rounded).onTap(()async {
                      await controller.removeWishlist(data[index].id, context);

                    }),
                  ),
                ).onTap(() {
                  Get.to(()=> ProductDetailScreen(productName: data[index]['p_name'], data: data[index]));
                });
                });
          }),
    );
  }
}
