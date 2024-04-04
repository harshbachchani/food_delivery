import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/homepage/controller/cartpage_controller.dart';
import 'package:food_delivery/homepage/controller/location_controller.dart';
import 'package:food_delivery/homepage/controller/user_details.dart';
import 'package:food_delivery/homepage/screens/cart/components/emptycart.dart';
import 'package:food_delivery/homepage/screens/cart/components/orderitem.dart';
import 'package:food_delivery/homepage/screens/cart/components/pricecard.dart';
import 'package:food_delivery/homepage/screens/cart/components/restaurantscard.dart';
import 'package:get/get.dart';

String imageheader =
    "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/";
String imageheader2 =
    "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_208,h_208,c_fit/";

// ignore: must_be_immutable
class CartPage extends StatelessWidget {
  CartPageController cartPageController = Get.put(CartPageController());
  LocationController location = Get.put(LocationController());

  UserDetails userDetails = Get.put(UserDetails());
  CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    DatabaseReference userref = FirebaseDatabase.instance
        .ref('Users')
        .child(userDetails.getuid())
        .child("CartOrder");
    Future<Map<dynamic, dynamic>> getdata() async {
      try {
        DataSnapshot snapshot = await userref.get();
        if (snapshot.value != null) {
          return snapshot.value as Map<dynamic, dynamic>;
        } else {
          throw Exception("Data is null");
        }
      } catch (error) {
        throw Exception(error.toString());
      }
    }

    var he = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 83, 69, 164),
        centerTitle: true,
        title: const Text(
          "My Cart",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
      ),
      body: Container(
        height: he.height,
        width: he.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color.fromARGB(255, 83, 69, 164),
                const Color.fromARGB(255, 66, 53, 165).withOpacity(.8),
                const Color.fromARGB(255, 75, 53, 165).withOpacity(.6),
                const Color.fromARGB(255, 121, 112, 159).withOpacity(.4),
                const Color.fromARGB(255, 70, 53, 165).withOpacity(.2),
                const Color(0xFF6F35A5).withOpacity(.1),
                const Color(0xFF6F35A5).withOpacity(.05),
                const Color(0xFF6F35A5).withOpacity(.25),
              ]),
        ),
        child: FutureBuilder(
          future: getdata(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const CartEmpty();
            }
            Map<dynamic, dynamic> mydata = snapshot.data!;

            List<int> q = <int>[];
            List<int> s = <int>[];
            cartPageController.orders.clear();
            cartPageController.total.value = 0;
            cartPageController.quantity.clear();
            cartPageController.price.clear();
            mydata["orders"].forEach((key, value) {
              q.add(value["quantity"]);
              s.add(int.parse(value["price"]));
              cartPageController.addorder(value);
            });

            cartPageController.updateaddress(
                location.getaddress(), location.getcity());
            cartPageController.updateresd(mydata['name'], mydata['area']);
            cartPageController.updatefee(int.parse(mydata["deliveryfee"]));
            return Obx(() {
              if (cartPageController.orders.isEmpty) return const CartEmpty();
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RestaurantCards(data: mydata),
                    Divider(color: Colors.grey.withOpacity(0.6)),
                    SizedBox(height: he.height * 0.02),
                    SizedBox(
                      height: he.height * 0.3,
                      child: Obx(() => ListView.builder(
                          itemCount: cartPageController.orders.length,
                          itemBuilder: (context, index) => OrderItems(
                                index: index,
                                cartPageController: cartPageController,
                                databaseReference: userref,
                                controller: userDetails,
                              ))),
                    ),
                    SizedBox(height: he.height * 0.01),
                    Divider(color: Colors.grey.withOpacity(0.6)),
                    SizedBox(height: he.height * 0.02),
                    PriceCard(
                      cartPageController: cartPageController,
                      controller: userDetails,
                    ),
                  ],
                ),
              );
            });
          },
        ),
      ),
    );
  }
}
