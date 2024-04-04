import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/assets/fonts/app_font.dart';
import 'package:food_delivery/constanst.dart';
import 'package:food_delivery/homepage/controller/cartpage_controller.dart';
import 'package:food_delivery/homepage/controller/user_details.dart';
import 'package:food_delivery/homepage/screens/restaurant_details/restaurant_details.dart';
import 'package:get/get.dart';

class OrderItems extends StatelessWidget {
  final int index;
  final CartPageController cartPageController;
  final UserDetails controller;
  final DatabaseReference databaseReference;
  const OrderItems(
      {super.key,
      required this.index,
      required this.cartPageController,
      required this.databaseReference,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    Map<dynamic, dynamic> data = cartPageController.getorder(index);
    var he = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: he.height * 0.01),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 70, 53, 165).withOpacity(.1),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: he.height * 0.1,
      width: he.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              SizedBox(
                height: he.height * 0.05,
                width: he.width * 0.05,
                child: data["isveg"] == 1
                    ? Image.asset(
                        'assets/images/veg_png.png',
                        fit: BoxFit.contain,
                      )
                    : Image.asset(
                        'assets/images/nonveg_png.png',
                        fit: BoxFit.contain,
                      ),
              ),
              SizedBox(width: he.width * 0.02),
              SizedBox(
                width: he.width * 0.42,
                child: Text(
                  data["name"],
                  softWrap: true,
                  style: AppFont.krpimaryText(18, color: Colors.black),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Material(
                color: const Color.fromARGB(255, 70, 53, 165).withOpacity(.2),
                elevation: 1,
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: he.height * 0.04,
                  width: he.width * 0.3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () async {
                            await cartPageController
                                .updatedatabase(databaseReference, true, index)
                                .then((value) {
                              if (value) {
                                cartPageController.addquantity(index);
                              } else {
                                getsnackbar("Failed",
                                    "Error in increasing quatity try after some time");
                              }
                            });
                          },
                          icon: const Icon(
                            Icons.add,
                            size: 17,
                            color: Colors.white,
                          )),
                      Obx(() {
                        if (cartPageController.getload()) {
                          return const CircularProgressIndicator();
                        } else {
                          return Text(
                            cartPageController.getquantity(index).toString(),
                            style:
                                AppFont.krpimaryText(15, color: Colors.white),
                          );
                        }
                      }),
                      IconButton(
                          onPressed: () async {
                            if (data['quantity'] == 1) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return giveDialog(context, index,
                                      cartPageController, controller);
                                },
                              );
                            } else {
                              await cartPageController
                                  .updatedatabase(
                                      databaseReference, false, index)
                                  .then((value) {
                                if (value) {
                                  cartPageController.deletequantity(index);
                                } else {
                                  getsnackbar("Failed",
                                      "Error in decreasing quatity try after some time");
                                }
                              });
                            }
                          },
                          icon: const Icon(
                            Icons.remove,
                            size: 17,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(width: he.width * 0.05),
              Obx(
                () => Text(
                  cartPageController.getprice(index).toString(),
                  style: AppFont.krpimaryText(18, color: Colors.black),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

AlertDialog giveDialog(BuildContext context, int index,
    CartPageController cartPageController, UserDetails controller) {
  return AlertDialog(
    title: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Center(
          child: Text(
            "Are You want to remove Item from Cart?",
            style: AppFont.mediumText(20),
            softWrap: true,
          ),
        ),
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      kprimaryColor.withOpacity(0.4)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "No",
                  style: AppFont.regularText(15),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.02,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      kprimaryColor.withOpacity(0.6)),
                ),
                onPressed: () {
                  int id = cartPageController.getorder(index)["orderid"];
                  removeorder(userDetails, id, index, cartPageController);
                  Navigator.pop(context);
                },
                child: Text(
                  "Yes",
                  style: AppFont.regularText(15),
                ),
              ),
            ),
          ],
        ),
      )
    ],
  );
}

Future<void> removeorder(UserDetails userDetails, int orderid, int index,
    CartPageController cartPageController) async {
  DatabaseReference dref = FirebaseDatabase.instance
      .ref('Users')
      .child(userDetails.getuid().toString())
      .child("CartOrder");
  await dref.child("orders").get().then((value) async {
    Map<dynamic, dynamic> data = value.value as Map<dynamic, dynamic>;
    String oid = "";
    data.forEach((key, value) {
      if (value["orderid"] == orderid) {
        oid = key.toString();
        return;
      }
    });
    if (data.length == 1) {
      await dref.remove().then((value) {
        cartPageController.removeitem(index);
        getsnackbar("Successful", "Order deleted successfully Cart is empty");
      }).onError((error, stackTrace) {
        getsnackbar("Failed", "Error in removing item");
      });
    } else {
      DatabaseReference node = dref.child("orders").child(oid);
      await node.remove().then((value) {
        cartPageController.removeitem(index);
        getsnackbar("Successful", "Order deleted successfully");
      }).onError((error, stackTrace) {
        getsnackbar("Error on removing Item", "Try again after some time");
      });
    }
  }).onError((error, stackTrace) {
    getsnackbar("Error on getting order", "Try again after some time");
  });
}
