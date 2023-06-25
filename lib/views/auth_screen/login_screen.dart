import 'package:ecommerce_app/constants/firebase_consts.dart';
import 'package:ecommerce_app/controllers/auth_controller.dart';
import 'package:ecommerce_app/views/auth_screen/signup_screen.dart';
import 'package:ecommerce_app/views/home_screen/home_screen.dart';
import 'package:ecommerce_app/widgets_common/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    var controller= Get.put(AuthController());
    print('login screen currentUser : ${currentUser}');
    print('build');
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height*1,
        color: const Color(0xffF9CC0B),
        child: Stack(
          children: [
            const Image(image: AssetImage('assets/images/Great_Indian_logo.png'),
            ),
            Positioned(
              top: 280,
              left: 35,
              child: Obx(()=>Column(
                children: [
                  CustomTextField(context: context, hint: "Email", type: "email", controller: controller.emailController, icon: Icons.email_outlined,),
                  20.heightBox,
                  CustomTextField(context: context, hint: "Password", type: "password", controller: controller.passwordController, icon: Icons.lock_outline_rounded,),
                  Container(
                    margin: const EdgeInsets.only(left: 180, top: 10),
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.grey.withOpacity(0.8)
                      ),
                      child: const Text('Forgot Password?', style: TextStyle(
                        fontWeight: FontWeight.w500,

                      ),)),

                  const SizedBox(height: 15,),

                  controller.isLoading.value ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.red),
                  ):
                  ElevatedButton(
                    style: ButtonStyle(
                     minimumSize: MaterialStateProperty.all<Size>(Size(MediaQuery.of(context).size.width*0.8,50))
                    ),
                    onPressed: ()async{
                      controller.isLoading(true);
                      await controller.loginMethod(context: context).then((value)async{
                        if(value!= null){
                          VxToast.show(context, msg: "User logged in..");

                          //solution

                          currentUser(value!.user);



                          Get.offAll(()=> const HomeScreen());
                        }else{
                          controller.isLoading(false);
                        }
                      });
                    },
                    child: const Text('Login', style: TextStyle(
                      fontSize: 20,
                    ),),
                  ),
                  const SizedBox(height: 10,),
                  Text('Or Create a new Account?',style: TextStyle(
                      color: Colors.black.withOpacity(0.5)
                  )),
                  const SizedBox(height: 10,),

                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.orange),
                        minimumSize: MaterialStateProperty.all<Size>(Size(MediaQuery.of(context).size.width*0.8,50))
                    ),
                    onPressed: (){
                      Get.to(()=> const SignUpScreen());
                    },
                    child: const Text('Sign Up', style: TextStyle(
                        fontSize: 20,
                    ),),
                  ),

                  10.heightBox,
                  Text('Login with', style: TextStyle(
                    color: Colors.black.withOpacity(0.5)
                  ),),
                  const SizedBox(height: 15,),
                  Row(
                    children: [
                      FloatingActionButton(
                        backgroundColor: Colors.white,
                        onPressed: (){},
                        child: const Image(image: AssetImage('assets/images/google_icon.png',),
                        height: 35,
                          width: 35,
                        ),
                      ),
                      const SizedBox(width: 10,),
                      FloatingActionButton(
                        backgroundColor: Colors.white,
                        onPressed: (){},
                        child: const Image(image: AssetImage('assets/images/facebook.png',),
                          height:50,
                          width: 50,
                        ),
                      ),

                      const SizedBox(width: 10,),

                      FloatingActionButton(
                        backgroundColor: Colors.white,
                        onPressed: (){},
                        child: const Image(image: AssetImage('assets/images/twitter_icon.png',),
                          height: 50,
                          width: 50,

                        ),
                      ),


                    ],
                  )





                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
