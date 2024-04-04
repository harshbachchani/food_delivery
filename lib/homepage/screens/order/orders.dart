import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/assets/fonts/app_font.dart';
import 'package:food_delivery/homepage/controller/bottom_navigation_controller.dart';
import 'package:food_delivery/homepage/controller/user_details.dart';
import 'package:food_delivery/homepage/screens/home/homepage.dart';
import 'package:food_delivery/homepage/screens/order/components/cardorderitem.dart';
import 'package:get/get.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    UserDetails userDetails = Get.put(UserDetails());
    DatabaseReference dref = FirebaseDatabase.instance
        .ref('Users')
        .child(userDetails.getuid().toString())
        .child('Orders');
    Future<Map<dynamic, dynamic>> getdata() async {
      try {
        DataSnapshot snapshot = await dref.get();
        if (snapshot.value != null) {
          return snapshot.value as Map<dynamic, dynamic>;
        } else {
          throw Exception("null and empty");
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
          "My Orders",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                if (snapshot.error.toString().contains("null and empty")) {
                  BottomNavigationController controller = Get.find();
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: he.width,
                        child: Text(
                          "No Orders!! Click to explore restaurants",
                          textAlign: TextAlign.center,
                          style: AppFont.mediumText(20),
                        ),
                      ),
                      SizedBox(height: he.height * 0.03),
                      SizedBox(
                          width: he.width * 0.4,
                          child: ElevatedButton(
                              onPressed: () {
                                controller.changeicon(0);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomePage(),
                                    ));
                              },
                              child: Text(
                                "Explore",
                                style:
                                    AppFont.mediumText(15, color: Colors.white),
                              )))
                    ],
                  );
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Error in getting data...",
                        style: AppFont.mediumText(20),
                      ),
                      SizedBox(height: he.height * 0.02),
                      SizedBox(
                        width: he.width * 0.3,
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {});
                            },
                            child: Text(
                              "Try again",
                              style:
                                  AppFont.mediumText(15, color: Colors.white),
                            )),
                      )
                    ],
                  ),
                );
              } else {
                Map<dynamic, dynamic> mydata = snapshot.data!;
                List<Map<dynamic, dynamic>> x = <Map<dynamic, dynamic>>[];
                mydata.forEach((key, value) {
                  x.add(value);
                });
                return ListView.builder(
                    itemCount: x.length,
                    itemBuilder: (context, index) {
                      return CardOrderItem(data: x[index]);
                    });
              }
            },
          )),
    );
  }
}
