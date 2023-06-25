import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants/firebase_consts.dart';
import 'package:ecommerce_app/controllers/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var totalPrice = 0.obs;

  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postalController = TextEditingController();
  var countryController = TextEditingController();
  var phoneController = TextEditingController();

  var paymentIndex= 0.obs;

   dynamic productSnapshots;

   var products =[];

   var placingOrder = false.obs;

  calculate(dynamic data) {
    totalPrice(0);
    for (int i = 0; i < data.length; i++) {
      totalPrice.value = totalPrice.value + int.parse(data[i]['total_price']);
    }
  }

  getProductDetails(){
    products.clear();
    for(int i=0;i<productSnapshots.length;i++){
      products.add({
        'color': productSnapshots[i]['color'],
        'image': productSnapshots[i]['image'],
        'vendor_id': productSnapshots[i]['vendor_id'],
        'qty': productSnapshots[i]['quantity'],
        'title': productSnapshots[i]['title']
      });
    }
    print(' cart products are : ${products}');
  }


  placeMyOrder({required orderPaymentMethod, required totalAmount})async{

    placingOrder(true);

    await getProductDetails();
    await fireStore.collection(ordersCollection).doc().set({
      'order_code':'212645648965',
      'order_date':FieldValue.serverTimestamp(),
      'order_by': currentUser.value!.uid,
      'order_by_name': Get.put(HomeController()).username.value,
      'order_by_email': currentUser.value!.email,
      'order_by_address': addressController.text,
      'order_by_state': stateController.text,
      'order_by_city': cityController.text,
      'order_by_postal': postalController.text,
      'order_by_country': countryController.text,
      'order_by_phone': phoneController.text,
      'shipping_method': "Home Delivery",
      'order_confirmed': false,
      'order_delivered': false,
      'order_on_delivery':false,
      'payment_method' : orderPaymentMethod,
      'total_amount': totalAmount,
      'order_placed': true,
      'orders': FieldValue.arrayUnion(products)

    });

    placingOrder(false);
  }

  clearCart()async{
    for(int i=0; i<productSnapshots.length;i++){
      await fireStore.collection(cartCollection).doc(productSnapshots[i].id).delete();
    }
  }
}
