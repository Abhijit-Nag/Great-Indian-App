import 'package:ecommerce_app/views/category_screens/components/order_place_details.dart';
import 'package:ecommerce_app/views/category_screens/components/order_status.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatelessWidget {
  String orderId;
  final dynamic data;
  OrderDetails({Key? key, required this.orderId, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('data of order detail screen : ${data['order_placed']}}');
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
          backgroundColor: Colors.green, title: const Text('Order Details')),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            orderStatus(
                icon: Icons.done_all_rounded,
                color: Colors.green,
                title: "Order placed",
                showDone: data['order_placed']),
            orderStatus(
                icon: Icons.thumb_up,
                color: Colors.blue,
                title: "Order confirmed",
                showDone: data['order_confirmed']),
            orderStatus(
                icon: Icons.local_shipping,
                color: Colors.green,
                title: "On delivery",
                showDone: data['order_on_delivery']),
            orderStatus(
                icon: Icons.done,
                color: Colors.purple,
                title: "Delivered",
                showDone: data['order_delivered']),
            10.heightBox,
            const Divider(
              thickness: 0.5,
            ),

            10.heightBox,
            const Text('Ordered Products'),
            ListView(
              shrinkWrap: true,
              children: List.generate(data['orders'].length, (index) {
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(5.0),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: ListTile(
                    leading: Image.network(data['orders'][index]['image']),
                    title: Center(child: Text(data['orders'][index]['title'])),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Color :'),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(
                                  int.parse(data['orders'][index]['color']))),
                        )
                      ],
                    ),
                    trailing: SizedBox(
                      width: 60,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(5.0)),
                            padding: const EdgeInsets.all(2.0),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Qty',
                                ),
                                Icon(Icons.arrow_drop_down)
                              ],
                            ),
                          ),
                          Text(data['orders'][index]['qty'].toString())
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
            const Divider(),
            Container(
              padding: const EdgeInsets.all(15.0),
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2.0),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.21),
                    offset: Offset(1, 2),
                    blurRadius: 5,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  orderPlaceDetails(
                      d1: data['order_code'],
                      d2: data['shipping_method'],
                      title1: "Order Code",
                      title2: "Shipping Method"),
                  10.heightBox,
                  orderPlaceDetails(
                      d1: '${intl.DateFormat.yMMMMd('en_US').format(data['order_date'].toDate())}\n ${intl.DateFormat("h:mma").format(data['order_date'].toDate())}',
                      d2: data['payment_method'].toString(),
                      title1: "Order Date",
                      title2: "Payment Method"),
                  10.heightBox,
                  orderPlaceDetails(
                      d1: "Paid",
                      d2: "Order Placed",
                      title1: "Payment Status",
                      title2: "Delivery Status"),
                  25.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['order_by_name'],
                            style: GoogleFonts.firaSans(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            data['order_by_email'],
                            style: GoogleFonts.firaSans(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            data['order_by_phone'],
                            style: GoogleFonts.firaSans(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            data['order_by_address'],
                            style: GoogleFonts.firaSans(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            data['order_by_city'],
                            style: GoogleFonts.firaSans(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            data['order_by_postal'],
                            style: GoogleFonts.firaSans(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            data['order_by_state'],
                            style: GoogleFonts.firaSans(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            data['order_by_country'],
                            style: GoogleFonts.firaSans(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Total Amount',
                            style: GoogleFonts.firaSans(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          5.heightBox,
                          Row(
                            children: [
                              const Icon(
                                Icons.currency_rupee,
                                color: Colors.green,
                              ),
                              Text(
                                data['total_amount'].toString().numCurrency,
                                style: GoogleFonts.firaSans(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.green),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
