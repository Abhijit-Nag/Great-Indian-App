import 'package:ecommerce_app/controllers/cart_controlller.dart';
import 'package:ecommerce_app/views/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class PaymentMethodScreen extends StatelessWidget {
   PaymentMethodScreen({Key? key}) : super(key: key);

  var paymentImageData=[
    'assets/images/paypal.png',
    'assets/images/gpay.png',
    'assets/images/stripe.png',
    'assets/images/paytm.jpg',
    'assets/images/cash-on-delivery.png',
  ];
  var paymentMethod= [
    'paypal', 'google-pay', 'stripe','paytm','cash-on-delivery'
  ];
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();


    return Obx(() => Scaffold(
      backgroundColor: Colors.white.withOpacity(0.88),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Choose Payment Method'),
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(
            color: Colors.red
        ),
        child: Center(
          child: Text('Place my order', style: GoogleFonts.roboto(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18
          ),),
        ),
      ).onTap(() async{
        await controller.placeMyOrder(orderPaymentMethod: paymentMethod[controller.paymentIndex.value], totalAmount: controller.totalPrice.value);
        await controller.clearCart();
        VxToast.show(context, msg: "Order placed successfully..");
        Get.offAll(()=>HomeScreen());
      }),
      body:
      controller.placingOrder.value ? const Center(child: CircularProgressIndicator()) :
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Column(
            children: [
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: paymentImageData.length,
                  itemBuilder: (context, index){
                    return Obx(() => Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: controller.paymentIndex.value == index ? 8.0 : 15.0, vertical: 5.0),
                            width: MediaQuery.of(context).size.width * 1,
                            height: controller.paymentIndex.value == index ? 180 :150,
                            decoration: BoxDecoration(
                                color: controller.paymentIndex.value == index ? Colors.green.withOpacity(0.5) : Colors.white
                            ),
                            child: Image.asset(
                              paymentImageData[index],
                            )).onTap(() {
                          controller.paymentIndex(index);
                        }),
                        controller.paymentIndex.value == index?
                        Checkbox(
                            activeColor: Colors.green,
                            value: true, onChanged:(value){}): Container(),
                      ],
                    ));

                  })



            ],
          ),
        ),
      ),
    ));
  }
}


// Container(
//   margin: const EdgeInsets.symmetric(
//       horizontal: 15.0, vertical: 5.0),
//   width: MediaQuery.of(context).size.width * 1,
//   height: 150,
//   decoration: const BoxDecoration(color: Colors.white),
//   child: Image.asset(
//     'assets/images/gpay.png',
//     width: 150,
//   ),
// ),
// Container(
//   margin: const EdgeInsets.symmetric(
//       horizontal: 15.0, vertical: 5.0),
//   width: MediaQuery.of(context).size.width * 1,
//   height: 150,
//   decoration: const BoxDecoration(color: Colors.white),
//   child: Image.asset(
//     'assets/images/stripe.png',
//     width: 150,
//   ),
// ),
// Container(
//   margin: const EdgeInsets.symmetric(
//       horizontal: 15.0, vertical: 5.0),
//   width: MediaQuery.of(context).size.width * 1,
//   height: 150,
//   decoration: const BoxDecoration(color: Colors.white),
//   child: Image.asset(
//     'assets/images/paytm.jpg',
//     width: 150,
//   ),
// ),
// Container(
//   padding: const EdgeInsets.all(5.0),
//   margin: const EdgeInsets.symmetric(
//       horizontal: 15.0, vertical: 5.0),
//   width: MediaQuery.of(context).size.width * 1,
//   height: 150,
//   decoration: const BoxDecoration(color: Colors.white),
//   child: Image.asset(
//     'assets/images/cash-on-delivery.png',
//     width: 150,
//   ),
// ),
