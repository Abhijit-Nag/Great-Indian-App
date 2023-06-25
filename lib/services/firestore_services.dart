import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants/firebase_consts.dart';

class FireStoreServices{

  //get userData
  static getUser(uid){
    // return fireStore.collection(usersCollection).where('id', isEqualTo: uid).snapshots();
    return fireStore.collection(usersCollection).doc(uid).snapshots();
  }

  // static Future<QuerySnapshot> getUser(String uid) {
  //   return FirebaseFirestore.instance
  //       .collection('users') // Replace 'users' with your Firestore collection name
  //       .where('uid', isEqualTo: uid)
  //       .get();
  // }

  // static Stream<QuerySnapshot<Map<String, dynamic>>> getUser(String uid) {
  //   return FirebaseFirestore.instance
  //       .collection('users')
  //       .where('uid', isEqualTo: uid)
  //       .snapshots();
  // }



 static getProducts(category){
    return fireStore.collection(productsCollection).where('p_category', isEqualTo: category).snapshots();
 }

 static getCart(uid){
    return fireStore.collection(cartCollection).where('added_by', isEqualTo: uid).snapshots();
 }


// delete document from fireStore

  static deleteDocument(docId){
    return fireStore.collection(cartCollection).doc(docId).delete();
  }


//  get the chats

  static  getChats(docId){
    return fireStore.collection(chatsCollection).doc(docId).collection(messagesCollection).orderBy('created_on', descending: false).snapshots();
  }

  static getOrders(){
    return fireStore.collection(ordersCollection).where('order_by', isEqualTo: currentUser.value!.uid).snapshots();
  }

  static getWishlists(){
    return fireStore.collection(productsCollection).where('p_wishlist', arrayContains: currentUser.value!.uid).snapshots();
  }
  
  static getAllMessages(){
    return fireStore.collection(chatsCollection).where('fromId', isEqualTo: currentUser.value!.uid).snapshots();
  }


  static getCountAllCarts()async{
    var res= Future.wait([
      fireStore.collection(productsCollection).where('p_wishlist', arrayContains: currentUser.value!.uid).get().then((value){
        return value.docs.length;
      }),
      fireStore.collection(cartCollection).where('added_by', isEqualTo: currentUser.value!.uid).get().then((value) => value.docs.length),
      fireStore.collection(ordersCollection).where('order_by', isEqualTo: currentUser.value!.uid).get().then((value) => value.docs.length)
    ]);

    return res;
  }
}