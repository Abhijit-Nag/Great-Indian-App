import 'package:ecommerce_app/controllers/cart_controlller.dart';
import 'package:ecommerce_app/views/category_screens/payment_method.dart';
import 'package:ecommerce_app/widgets_common/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class ShippingScreen extends StatelessWidget {
  const ShippingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller= Get.find<CartController>();
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.88),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Shipping Info'),
      ),
      bottomNavigationBar:  Container(
        color: Colors.red,
        padding: const EdgeInsets.all(8.0),
        height: 50,
        child: Center(
          child: Text(
            'Continue',
            style: GoogleFonts.lato(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800
            ),
          ),
        ),
      ).onTap(() {
        if(controller.addressController.text.isEmpty
            || controller.cityController.text.isEmpty
            || controller.stateController.text.isEmpty
            || controller.postalController.text.isEmpty
            || controller.countryController.text.isEmpty
            || controller.phoneController.text.isEmpty
            ){
          VxToast.show(context, msg: "Please fill the form");
        }else{
          Get.to(()=> PaymentMethodScreen());
        }
      }),
      body: Center(
        child: Column(
          children: [
            5.heightBox,
            CustomTextField(context: context, hint: 'Address', type: "", icon: Icons.location_pin, controller: controller.addressController),
            5.heightBox,
            CustomTextField(context: context, hint: 'City', type: "", icon: Icons.location_pin, controller: controller.cityController),
            5.heightBox,
            CustomTextField(context: context, hint: 'State', type: "", icon: Icons.location_pin, controller: controller.stateController),
            5.heightBox,
            CustomTextField(context: context, hint: 'Postal Code', type: "", icon: Icons.location_pin, controller: controller.postalController),
            5.heightBox,
            CustomTextField(context: context, hint: 'Country', type: "", icon: Icons.location_pin, controller: controller.countryController),
            5.heightBox,
            CustomTextField(context: context, hint: 'Phone Number', type: "", icon: Icons.location_pin, controller: controller.phoneController)
          ],
        ),
      ),
    );
  }
}
