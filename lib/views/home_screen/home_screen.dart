import 'package:ecommerce_app/constants/firebase_consts.dart';
import 'package:ecommerce_app/controllers/home_controller.dart';
import 'package:ecommerce_app/views/category_screens/account_screen.dart';
import 'package:ecommerce_app/views/category_screens/cart_screen.dart';
import 'package:ecommerce_app/views/category_screens/category_screen.dart';
import 'package:ecommerce_app/views/category_screens/home.dart';
import 'package:ecommerce_app/widgets_common/exit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var controller = Get.put(HomeController());

  var navbarItem=[
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
    const BottomNavigationBarItem(icon: Icon(Icons.category), label: 'category'),
    const BottomNavigationBarItem(icon: Icon(Icons.shopping_cart,), label: 'cart'),
    const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'account')
  ];

  var navBody=[
    // const HomeScreen(),
    const Home(),
    const CategoryScreen(),
    const CartScreen(),
    const AccountScreen()
  ];
  @override
  Widget build(BuildContext context) {
    print('build');
    // print(currentUser!.uid);
    print(auth.currentUser);
    controller.getUser();
    // print(controller.username.value);

    //WillPopScope widget is used to control the hardware buttons back button in mobile phone
    return WillPopScope(
      onWillPop: ()async{
        showDialog(context: context, builder: (context)=>exitDialog(context));
         return false;
      },
      child: Scaffold(
        // appBar: AppBar(title: Text('Great Indian'), backgroundColor: Colors.green,),
        body: Column(
          children: [
            Expanded(
              // height: MediaQuery.of(context).size.height*0.5,
                child: Obx(()=> navBody[controller.currentNavIndex.value]))
          ],
        ),
        bottomNavigationBar: Obx(()=>
           BottomNavigationBar(
             currentIndex: controller.currentNavIndex.value,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.red,
            type: BottomNavigationBarType.fixed,
            items: navbarItem,
             onTap: (value){
               controller.currentNavIndex.value = value;
             },
          ),
        ),
      ),
    );
  }
}
