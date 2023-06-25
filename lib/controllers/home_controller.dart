import 'package:ecommerce_app/constants/firebase_consts.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  var currentNavIndex = 0.obs;

  var username=''.obs;

  getUser()async{
    var n=await fireStore.collection(usersCollection).doc(currentUser.value!.uid).snapshots().first;

    username.value= n.data()?['name'];
    // return username.value;

  }
}