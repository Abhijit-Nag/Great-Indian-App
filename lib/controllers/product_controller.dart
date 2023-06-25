import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants/firebase_consts.dart';
import 'package:ecommerce_app/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductController extends GetxController{

  var quantity= 1.obs;
  var colorIndex = 0.obs;
  var subCat=[];

  var isFavorite = false.obs;

  getSubCategories(title) async{
    subCat.clear();
    var data= await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var subCategoryItems= decoded.categories.where((element) => element.name == title).toList();

    for (var e in subCategoryItems[0].subCategory){
      subCat.add(e);
    }
  }

  String totalPrice(price){
    return (quantity* int.parse(price)).toString();
  }

  addToCart({ title , img, seller, color, qty, productPrice, tPrice, vendorId })async{
    await fireStore.collection(cartCollection).doc().set({
      'title':title,
      'image': img,
      'seller': seller,
      'color': color,
      'vendor_id': vendorId,
      'quantity': qty,
      'p_price': productPrice,
      'total_price': tPrice,
      'added_by': currentUser.value!.uid
    });
  }

//  before reseting the value it has been seen that in the app changes we have made
//  in product Detail Screen like quantity increasing and color choosing these all are
// still the updated value through pressing the back button it is not reset so for this
// we have to explicitly call the reset function and we have to make the
// function here.


resetValues(){
    quantity(0);
    colorIndex(0);
}

  addToWishlist(docId, context)async{
    await fireStore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayUnion([currentUser.value!.uid])
    }, SetOptions(merge: true));

    VxToast.show(context, msg: "Added to Wishlist");
  }

  removeWishlist(docId, context)async{
    await fireStore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([currentUser.value!.uid])
    }, SetOptions(merge: true));
    VxToast.show(context, msg: "Removed from Wishlist");
  }

  checkIfFavorite(data){
    if(data['p_wishlist'].contains(currentUser.value!.uid)){
      isFavorite(true);
    }else{
      isFavorite(false);
    }
  }
}