import 'dart:async';

import 'package:ecommerce_app/constants/firebase_consts.dart';
import 'package:ecommerce_app/views/auth_screen/login_screen.dart';
import 'package:ecommerce_app/views/home_screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {

  changeScreen(){
    Future.delayed(const Duration(seconds: 5),(){
      // Get.offAll(()=>  LoginScreen());

      auth.authStateChanges().listen((User ? user) {
        if(user == null && mounted){
          Get.offAll(()=> LoginScreen());
        }else{
          Get.offAll(()=>HomeScreen());
        }
      });
    });
  }

  @override

  void initState() {
    // TODO: implement initState
    changeScreen();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color(0xff0C1D36),
      body:  Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 150,),
            Image(image: AssetImage('assets/images/Great_Indian_logo.png')),
            SizedBox(height: 100,),
            Container(
              padding: EdgeInsets.only(left: 26),
                child: Text('Where Quality is King, Speed is Key, Customer Service is Supreme', style: GoogleFonts.alegreyaSc(
                  color: Color(0xffF9CC0B),
                  fontSize: 21,
                  fontWeight: FontWeight.w700
                ),))
          ],
        ),
      ),

    );
  }
}
