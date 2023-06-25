import 'package:ecommerce_app/constants/lists.dart';
import 'package:ecommerce_app/controllers/product_controller.dart';
import 'package:ecommerce_app/views/category_screens/category_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(Color(0xffC0C0C0).value);
    print(Color(0xffFFD700).value);
    print(Colors.black.value);
    var controller = Get.put(ProductController());
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20,top: 15),
        color: Colors.orange,
        child: GridView.builder(
          itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 15, mainAxisExtent: 200), itemBuilder: (context, index){
          return GestureDetector(
            onTap: ()async{
               controller.getSubCategories(categoryName[index]);
              Get.to(()=>CategoryDetailScreen(categoryTitle: categoryName[index]));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                // borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), topLeft: Radius.circular(10),
                // topRight: Radius.circular(10), bottomLeft: Radius.circular(10))
                borderRadius: BorderRadius.circular(5)
              ),
              // height: 180,
              // width: 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(5),
                      topRight: const Radius.circular(5),
                    ),
                    child: Image(image: AssetImage(categoryImage[index],
                    ),
                        height: 100,
                      // width: 150,
                      fit: BoxFit.cover,

              ),
                  ),
                  20.heightBox,
                  Align(
                    alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.only(left: 5, right: 5),
                          child: Text(
                              categoryName[index],
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),),
                      )
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
