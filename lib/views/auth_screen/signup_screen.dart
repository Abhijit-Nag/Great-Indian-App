import 'package:ecommerce_app/constants/firebase_consts.dart';
import 'package:ecommerce_app/controllers/auth_controller.dart';
import 'package:ecommerce_app/views/auth_screen/login_screen.dart';
import 'package:ecommerce_app/views/category_screens/home.dart';
import 'package:ecommerce_app/views/home_screen/home_screen.dart';
import 'package:ecommerce_app/widgets_common/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isChecked= false;

  var controller = Get.put(AuthController());

  //text controllers

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    print(currentUser);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height*1,
        color: const Color(0xffF9CC0B),
        child: Stack(
          children: [
            // Container(
            //   height: 180,
            //   padding: EdgeInsets.only(bottom: 35),
            //   width: MediaQuery.of(context).size.width*1,
            //   color: Color(0xff0C1D36),
            //   child: Align(
            //     alignment: Alignment.center,
            //     child: Text(
            //       'Great Indian',
            //       style: GoogleFonts.firaSans(
            //           color: Color(0xffF9CC0B),
            //           fontWeight: FontWeight.w200,
            //           fontSize: 50
            //       ),
            //     ),
            //   ),
            // ),
            const Image(image: AssetImage('assets/images/Great_Indian_logo.png')),
            Container(
              margin: const EdgeInsets.only(top: 180),
              child: Column(
                children: [

                  const SizedBox(height: 20,),
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Obx(() => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomTextField(context: context, hint: "Name", type: "name", controller: nameController, icon: Icons.person,),
                            const SizedBox(height: 20,),
                            CustomTextField(context: context, hint: "Email", type: "email", controller: emailController,icon: Icons.email_outlined,),
                            const SizedBox(height: 20,),
                            CustomTextField(context: context, hint: "Password", type: "password", controller: passwordController, icon: Icons.lock_outline_rounded,),
                            const SizedBox(height: 20,),
                            CustomTextField(context: context, hint: "Confirm your Password", type: "password", controller: confirmPasswordController, icon: Icons.lock_outline_rounded,),

                            const SizedBox(height: 15,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Checkbox(
                                    value: isChecked, onChanged:(newValue){
                                  setState(() {
                                    isChecked= newValue!;
                                  });
                                }),
                                const Text('Agree to Terms & Conditions', style: TextStyle(
                                    color: Colors.black
                                ),),
                                const SizedBox(width: 100,)
                              ],
                            ),
                            const SizedBox(height: 10,),


                            controller.isLoading.value?
                                const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(Colors.green),
                                ):
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(isChecked ? Colors.orange : Colors.grey),
                                minimumSize: MaterialStateProperty.all<Size>(Size(MediaQuery.of(context).size.width*0.8,50)),
                              ),
                              onPressed: () async{
                                if(isChecked !=false){
                                  controller.isLoading(true);
                                  try{
                                    // await controller.signUpMethod(context: context, email: emailController.text, password: passwordController.text).then((value) {
                                    //   return controller.storeUserData(
                                    //       email: emailController.text,
                                    //       password: passwordController.text,
                                    //       name: nameController.text
                                    //   );
                                    // }).then((value){
                                    //   VxToast.show(context, msg: "Logged In successfully..");
                                    //   Get.offAll(()=> HomeScreen());
                                    // });

                                    await controller.signUpMethod(context: context, email: emailController.text, password: passwordController.text).then((value) {
                                      print('new created userid : ${value!.user!.uid}');
                                      currentUser(value!.user);
                                      return controller.storeUserData(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          name: nameController.text,
                                        id:value!.user!.uid
                                      );
                                    }).then((value)async{
                                      VxToast.show(context, msg: "Logged In successfully..");

                                      // print('before waiting and after storing data in database: $currentUser');
                                      // await controller.waitForCurrentUser();
                                      // print('after waiting : $currentUser');
                                      Get.offAll(()=> HomeScreen());
                                    });

                                    // await controller.signUpMethod(context: context, email: emailController.text, password: passwordController.text);
                                    // if(currentUser!=null){
                                    //   await controller.storeUserData(email: emailController.text, password: passwordController.text, name: nameController.text);
                                    // }
                                    // // VxToast.show(context, msg: "Logged In successfully..");
                                    // Get.offAll(()=> LoginScreen());
                                  }catch(e){
                                    auth.signOut();
                                    print('Error Message:  $e.toString()');
                                    VxToast.show(context, msg: e.toString());
                                    controller.isLoading(false);
                                  }
                                }
                              },
                              child: const Text('Sign Up', style: TextStyle(
                                  fontSize: 20
                              ),),
                            ),

                            const SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('Already have account?', style: GoogleFonts.firaSans(

                                ),),
                                const SizedBox(width: 10,),
                                InkWell(
                                  onTap: (){
                                    // Get.offAll(()=>LoginScreen());
                                    Get.back();
                                  },
                                  child: Text('Log In', style: GoogleFonts.alegreyaSc(
                                      color: const Color(0xff0C1D36),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500
                                  ),),
                                ),
                                const SizedBox(width: 50,)
                              ],
                            ),





                          ],
                        ))

                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
