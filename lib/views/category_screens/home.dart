import 'package:ecommerce_app/constants/lists.dart';
import 'package:ecommerce_app/widgets_common/featured_buttons.dart';
import 'package:ecommerce_app/widgets_common/home_buttons.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      color: Colors.white.withOpacity(0.88),
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              child: Container(
                height: 50,
                // color: Colors.grey.withOpacity(0.5),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(
                          0, 3), // changes the position of the shadow
                    ),
                  ],
                ),
                // height: 62,
                // alignment: Alignment.center,
                child: TextFormField(
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Search anything ..',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        height: 150,
                        autoPlay: true,
                        itemCount: slidersList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Image.asset(
                              slidersList[index],
                              fit: BoxFit.fill,
                            )
                                .box
                                .rounded
                                .clip(Clip.antiAlias)
                                .margin(EdgeInsets.symmetric(horizontal: 8))
                                .make(),
                          );
                        }),
                    const SizedBox(
                      height: 20,
                    ),

                    Row(
                      children: [
                        homeButtons("Today's Deal", Icons.checklist_rounded,
                            () {
                          print("Today's Deal");
                        }, 15),
                        homeButtons("Flash Sale", Icons.flash_on_outlined, () {
                          print("Flash Sale");
                        }, 15),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        height: 150,
                        autoPlay: true,
                        itemCount: slidersList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Image.asset(
                              slidersList[index],
                              fit: BoxFit.fill,
                            )
                                .box
                                .rounded
                                .clip(Clip.antiAlias)
                                .margin(EdgeInsets.symmetric(horizontal: 8))
                                .make(),
                          );
                        }),
                    const SizedBox(
                      height: 20,
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        homeButtons("Top Categories", Icons.category_outlined,
                            () {}, 11),
                        homeButtons("Brand", Icons.lightbulb, () {}, 11),
                        homeButtons("Top Categories",
                            Icons.emoji_events_outlined, () {}, 11),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Featured Categories',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            2,
                            (index) => Column(
                                  children: [
                                    featuredButtons(featuredTitle1[index],
                                        featuredImages1[index], () {}),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    featuredButtons(featuredTitle2[index],
                                        featuredImages2[index], () {})
                                  ],
                                )).toList(),
                      ),
                    ),

                    //  all products section

                    20.heightBox,
                    
                    //Featured Products section
                    
                    
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: List.generate(featuredProductTitle.length, (index){
                          return Container(
                            height: 250,
                            width: 250,
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white
                            ),
                            child: Column(
                              children: [
                            Image(image: AssetImage(featuredProductImage[index]),
                            height: 150,
                            width: 150,),
                            Center(
                            child: Container(
                              child: Text(featuredProductTitle[index],
                              style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.justify,),
                              padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
                            ),
                            ),
                            Text(featuredProductPrice[index], style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green
                            )),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),

                    20.heightBox,
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        height: 150,
                        autoPlay: true,
                        itemCount: slidersList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Image.asset(
                              slidersList[index],
                              fit: BoxFit.fill,
                            )
                                .box
                                .rounded
                                .clip(Clip.antiAlias)
                                .margin(EdgeInsets.symmetric(horizontal: 8))
                                .make(),
                          );
                        }),

                    20.heightBox,
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 6,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  mainAxisExtent: 300),
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.only(bottom: 20, left: 10, right: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image(image: AssetImage(featuredProductImage[index]),
                                  fit: BoxFit.fill,),
                                  Center(
                                    child: Text(featuredProductTitle[index],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500
                                    ),),
                                  ),
                                  Text(featuredProductPrice[index], style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green
                                  ),)
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            )

            //  swiper brands
          ],
        ),
      ),
    );
  }
}
