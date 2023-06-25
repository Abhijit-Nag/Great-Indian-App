
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants/firebase_consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthController extends GetxController{

  var isLoading= false.obs;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

//  login method

Future<UserCredential?>loginMethod({context}) async{
  UserCredential? userCredential;

  try{
    userCredential =await auth.signInWithEmailAndPassword(email: emailController.text.toString(), password: passwordController.text.toString());
  } on FirebaseAuthException catch(e){
    VxToast.show(context, msg: e.toString());
  }
  return userCredential;
}


//signUp method

Future<UserCredential?>signUpMethod({context, email, password}) async{
  UserCredential? userCredential;
  try{
    userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch(e){
    VxToast.show(context, msg: e.toString());
  }
  print(userCredential);
  return userCredential;
}


//storing data method in cloud

storeUserData({name, email, password, id}) async{
  // DocumentReference store = fireStore.collection(usersCollection).doc(currentUser!.uid);
  // await store.set({
  //   'name': name,
  //   'password':password,
  //   'email': email,
  //   'imageUrl':'',
  //   'cart_count':'00',
  //   'order_count':'00',
  //   'wishlist_count':'00'
  // });
  await fireStore.collection(usersCollection).doc(id).set({
      'name': name,
      'password':password,
      'email': email,
      'imageUrl':'',
      'cart_count':'00',
      'order_count':'00',
      'wishlist_count':'00'
  });
}

//signOut method

signOutMethod({context}) async{
  try{
    await auth.signOut();
  }catch(e){
    VxToast.show(context, msg: e.toString());
  }
}






// waiting for non-null user

  Future<void> waitForCurrentUser() async {
    // Create a completer to wait for the first non-null user value
    final completer = Completer<void>();

    // Listen to authentication state changes
    final authChanges = FirebaseAuth.instance.authStateChanges();
    final authSubscription = authChanges.listen((User? user) {
      if (user != null) {
        // User is signed in or signed up
        completer.complete(); // Complete the future when the first non-null user is received
      }
    });

    // Wait for the future to complete
    await completer.future;

    // Cancel the auth subscription to stop listening for further changes
    authSubscription.cancel();
  }














}