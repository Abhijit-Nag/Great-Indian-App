

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore fireStore = FirebaseFirestore.instance;
// User ? currentUser = auth.currentUser;

Rx<User?> currentUser = auth.currentUser.obs;

//collections

const usersCollection = "users";
const productsCollection= "products";
const cartCollection = "cart";
const chatsCollection ="chats";
const messagesCollection = "messages";
const ordersCollection = "orders";