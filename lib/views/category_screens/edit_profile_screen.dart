import 'dart:io';

import 'package:ecommerce_app/controllers/profile_controller.dart';
import 'package:ecommerce_app/widgets_common/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  EditProfileScreen({Key? key, required this.data}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    // controller.nameController.text= data?['name'];
    // controller.passwordController.text= data?['password'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      body: Container(
          width: context.width,
          height: context.height,
          color: Colors.white.withOpacity(0.88),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  // width: MediaQuery.of(context).size.width*0.8,
                  // height: MediaQuery.of(context).size.height*0.5,
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(20),

                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.5)),
                  child: Obx(() => Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      20.heightBox,


                      data?['imageUrl']=="" && controller.profileImagePath.isEmpty ?
                      const CircleAvatar(
                        child: Icon(Icons.person),
                      ):
                          data?['imageUrl'] !="" && controller.profileImagePath.isEmpty ?
                              Image.network(data['imageUrl']):
                      Image.file(File(controller.profileImagePath.value))
                      ,
                      10.heightBox,


                      ElevatedButton(
                          onPressed: () {
                            controller.changeImage(context: context);
                          },
                          child: const Text('Change')),




                      10.heightBox,
                      CustomTextField(
                          context: context,
                          hint: "Name",
                          type: "name",
                          icon: (Icons.person),
                          controller: controller.nameController),
                      10.heightBox,
                      CustomTextField(
                          context: context,
                          hint: "Old Password",
                          type: "password",
                          icon: (Icons.lock),
                          controller: controller.oldPasswordController),
                      10.heightBox,
                      CustomTextField(
                          context: context,
                          hint: "New Password",
                          type: "password",
                          icon: (Icons.lock),
                          controller: controller.newPasswordController),
                      20.heightBox,
                      controller.isLoading.value == true? const CircularProgressIndicator(): ElevatedButton(onPressed: () async {
                        controller.isLoading(true);

                        //if profile Image in not selected to change


                        if(controller.profileImagePath.value.isNotEmpty){
                          await controller.uploadProfileImage();
                        }else{
                          controller.profileImageLink = data['imageUrl'];
                        }


                        //if old password matches the database then updation or save button should work

                        if(controller.oldPasswordController.text == data?['password']){
                          await controller.changeAuthPassword(
                            email: data['email'],
                            password: controller.oldPasswordController.text,
                            newPassword: controller.newPasswordController.text
                          );
                          await controller.updateProfile(name: controller.nameController.text, password: controller.newPasswordController.text, imageUrl: controller.profileImageLink);
                          VxToast.show(context, msg: "Updated");
                        }else{
                          VxToast.show(context, msg: "Wrong old Password");
                          controller.isLoading(false);
                        }

                      }, child: const Text('Save'))
                    ],
                  )),
                ),
              ],
            ),
          )),
    );
  }
}
