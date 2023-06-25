import 'package:ecommerce_app/constants/lists.dart';
import 'package:ecommerce_app/controllers/product_controller.dart';
import 'package:ecommerce_app/views/chat_screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductDetailScreen extends StatelessWidget {
  // String image, productName, price;
  String productName;
  final dynamic data;
  ProductDetailScreen({Key? key, required this.productName, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              controller.resetValues();
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text(data['p_name']),
          backgroundColor: Colors.green,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
            Obx(() => IconButton(
                onPressed: () async {
                  if (controller.isFavorite.value == false) {
                    await controller.addToWishlist(data.id, context);
                  } else {
                    await controller.removeWishlist(data.id, context);
                  }
                  controller.isFavorite(!controller.isFavorite.value);
                },
                icon: controller.isFavorite.value
                    ? const Icon(
                        Icons.favorite_rounded,
                      )
                    : const Icon(Icons.favorite_outline_rounded)))
          ],
        ),
        body: Container(
          color: Colors.white.withOpacity(0.95),
          child: Container(
            height: context.height,
            width: context.width,
            color: Colors.white.withOpacity(0.95),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VxSwiper.builder(
                      itemCount: data['p_images'].length,
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 350,
                      viewportFraction: 1.0,
                      itemBuilder: (context, index) {
                        return Image.network(data['p_images'][index],
                            width: double.infinity, fit: BoxFit.cover);
                      }),
                  20.heightBox,
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      '${data['p_name']}',
                      style: GoogleFonts.lato(
                          fontSize: 25, fontWeight: FontWeight.w800),
                    ),
                  ),
                  20.heightBox,
                  VxRating(
                    onRatingUpdate: (value) {},
                    isSelectable: false,
                    value: double.parse(data['p_rating']),
                    normalColor: Colors.grey,
                    selectionColor: const Color(0xffFFD700),
                    count: 5,
                    size: 25,
                    // stepInt: true,
                    maxRating: 5,
                  ).paddingOnly(left: 10),
                  10.heightBox,
                  Text(
                    '₹ ${data['p_price']}',
                    style: GoogleFonts.lato(
                        fontWeight: FontWeight.w800,
                        fontSize: 21,
                        color: Colors.green),
                  ).paddingOnly(left: 10, bottom: 10),
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${data['p_seller']}'),
                            const Text('In House Brand')
                          ],
                        )),
                        const CircleAvatar(
                          child: Icon(Icons.message_rounded),
                        ).onTap(() {
                          Get.to(() => ChatScreen(),
                              arguments: [data['p_seller'], data['vendor_id']]);
                        })
                      ],
                    )
                        .box
                        .color(Colors.black.withOpacity(0.2))
                        .padding(const EdgeInsets.all(10.0))
                        .make(),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Color :',
                              style: GoogleFonts.lato(
                                  fontSize: 15, color: Colors.grey),
                            ),
                            50.widthBox,
                            Row(
                              children: List.generate(
                                  3,
                                  (index) => Obx(() => Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          VxBox()
                                              .size(35, 35)
                                              .roundedFull
                                              .color(Color(int.parse(
                                                  data['p_colors'][index])))
                                              .margin(
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5))
                                              .make()
                                              .onTap(() {
                                            controller.colorIndex(index);
                                          }),
                                          (index == controller.colorIndex.value)
                                              ? const Icon(
                                                  Icons.done,
                                                  color: Colors.white,
                                                )
                                              : Container()
                                        ],
                                      ))),
                            )
                          ],
                        ),
                        20.heightBox,
                        Row(
                          children: [
                            Text(
                              'Quantity :',
                              style: GoogleFonts.lato(
                                  fontSize: 15, color: Colors.grey),
                            ),
                            50.widthBox,
                            Obx(() => Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          if (controller.quantity.value > 1) {
                                            controller.quantity.value--;
                                          }
                                        },
                                        icon: Icon(
                                          Icons.remove,
                                          color: controller.quantity.value > 1
                                              ? Colors.black
                                              : Colors.grey.withOpacity(0.5),
                                        )),
                                    Text(
                                      '${controller.quantity}',
                                      style: GoogleFonts.lato(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          if (int.parse(data['p_quantity']) >
                                              controller.quantity.value) {
                                            controller.quantity.value++;
                                          }
                                        },
                                        icon: Icon(
                                          Icons.add,
                                          color: controller.quantity.value < 50
                                              ? Colors.black
                                              : Colors.grey.withOpacity(0.5),
                                        )),
                                  ],
                                )),
                            Text(
                              '(${data['p_quantity']} available)',
                              style: GoogleFonts.lato(color: Colors.grey),
                            )
                          ],
                        ),
                        20.heightBox,
                        Row(
                          children: [
                            Text(
                              'Total :',
                              style: GoogleFonts.lato(
                                  fontSize: 15, color: Colors.grey),
                            ),
                            50.widthBox,
                            Obx(() => Text(
                                  '₹ ${controller.totalPrice(data['p_price'])}',
                                  style: GoogleFonts.lato(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 21,
                                      color: Colors.green),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  20.heightBox,
                  Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Description',
                            style: GoogleFonts.lato(
                                fontSize: 18, color: Colors.grey),
                          ),
                        ),
                        20.heightBox,
                        Text(
                          "Enjoy the slick operations and powerful performance of this HP laptop, which is stuffed with exceptional features. You can easily operate at your optimum with a graphics card and CPU from Intel's 11th generation. You can complete your tasks swiftly thanks to this laptop's integrated 4G LTE configuration and USB connectors. You can bring everything you need with you thanks to this laptop's fast booting technology. It is also lightweight, making it handy and a great travel companion.",
                          style: GoogleFonts.lato(fontSize: 15),
                          textAlign: TextAlign.justify,
                        )
                      ],
                    ),
                  ),
                  20.heightBox,
                  ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children:
                        List.generate(categoryDetailIcons.length, (index) {
                      return Container(
                        padding: const EdgeInsets.only(
                            left: 35, right: 55, top: 23, bottom: 23),
                        margin: const EdgeInsets.only(left: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              categoryDetailIcons[index],
                              style: GoogleFonts.lato(
                                  fontSize: 18,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w800),
                            ),
                            const Icon(Icons.forward)
                          ],
                        ),
                      );
                    }),
                  ),
                  Text(
                    'Products you may also like',
                    style: GoogleFonts.lato(fontSize: 18, color: Colors.grey),
                  ).marginAll(10).paddingOnly(left: 10),
                  20.heightBox,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children:
                          List.generate(featuredProductTitle.length, (index) {
                        return Container(
                          height: 280,
                          width: 200,
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Image(
                                image: AssetImage(featuredProductImage[index]),
                                height: 150,
                                width: 150,
                              ),
                              Center(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 30, top: 10, bottom: 10),
                                  child: Text(
                                    featuredProductTitle[index],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ),
                              Text(featuredProductPrice[index],
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green)),
                            ],
                          ),
                        );
                      }),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
            color: Colors.orange,
          ),
          child: InkWell(
            onTap: () {
              print('added to cart!');
              controller.addToCart(
                  title: data['p_name'],
                  color: data['p_colors'][controller.colorIndex.value],
                  img: data['p_images'][0],
                  productPrice: data['p_price'],
                  qty: controller.quantity.value,
                  seller: data['p_seller'],
                  vendorId: data['vendor_id'],
                  tPrice: controller.totalPrice(data['p_price']));
              VxToast.show(context, msg: "Added to Cart");
            },
            child: Text(
              'Add to Cart',
              style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
