import 'package:ecommerce_app/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomTextField extends StatelessWidget {
  BuildContext context;
  String? hint, type;
  TextEditingController controller;
  IconData icon;
   CustomTextField({Key? key,
     required this.context,
     required this.hint,
     required this.type,
     required this.icon,
     required this.controller
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.8,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(icon),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(
                      color: Colors.green,
                    )
                )
            ),
            width: MediaQuery.of(context).size.width*0.6,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  hintText: hint,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// Widget customTextField(String hint, String type){
//   print('textfield');
//   return Container(
//     width: MediaQuery.of(context).size.width*0.8,
//     decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10)
//     ),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         Icon(type == "email" ? Icons.email_outlined : Icons.lock_outline_rounded),
//         Container(
//           decoration: BoxDecoration(
//               border: Border(
//                   left: BorderSide(
//                     color: Colors.green,
//                   )
//               )
//           ),
//           width: MediaQuery.of(context).size.width*0.6,
//           child: TextField(
//             decoration: InputDecoration(
//                 hintText: hint,
//                 focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide.none
//                 ),
//                 border: OutlineInputBorder(
//                   borderSide: BorderSide.none,
//                 )
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }