import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/assets/fonts/app_font.dart';
import 'package:food_delivery/constanst.dart';
import 'package:food_delivery/homepage/controller/cartpage_controller.dart';
import 'package:food_delivery/homepage/controller/user_details.dart';
import 'package:get/get.dart';

class PriceCard extends StatelessWidget {
  final CartPageController cartPageController;
  final UserDetails controller;
  const PriceCard(
      {super.key, required this.cartPageController, required this.controller});

  @override
  Widget build(BuildContext context) {
    var he = MediaQuery.of(context).size;
    return Container(
      height: he.height * 0.3,
      width: he.width,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Obx(
        () => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sub Total",
                  style: AppFont.mediumText(17),
                ),
                Text(
                  "₹${cartPageController.gettotal()}",
                  style: AppFont.krpimaryText(15),
                ),
              ],
            ),
            SizedBox(height: he.height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Delivery Cost",
                  style: AppFont.mediumText(17),
                ),
                Text(
                  "₹${cartPageController.getfee()}",
                  style: AppFont.krpimaryText(15),
                ),
              ],
            ),
            SizedBox(
              height: he.height * 0.01,
            ),
            Divider(color: Colors.grey.withOpacity(0.4)),
            SizedBox(height: he.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: AppFont.mediumText(19),
                ),
                Text(
                  "₹${cartPageController.getfee() + cartPageController.gettotal()}",
                  style: AppFont.krpimaryText(23),
                ),
              ],
            ),
            SizedBox(height: he.height * 0.04),
            InkWell(
              onTap: () {
                saveorders(cartPageController, controller, context);
              },
              child: Center(
                child: Container(
                  width: he.width * 0.8,
                  height: he.height * 0.06,
                  decoration: BoxDecoration(
                    color: kprimaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "CheckOut",
                    textAlign: TextAlign.center,
                    style: AppFont.mediumText(25, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> saveorders(CartPageController cartPageController,
    UserDetails userDetails, BuildContext context) async {
  cartPageController.updateloading(true);
  final formkey = GlobalKey<FormState>();
  DatabaseReference orderref = FirebaseDatabase.instance
      .ref('Users')
      .child(userDetails.getuid().toString());
  String ordername = cartPageController.getordersstring();
  String ordertotal = cartPageController.gettotal().toString() +
      cartPageController.getfee().toString();
  String resname = cartPageController.getresname();
  String area = cartPageController.getareaname();
  String address = cartPageController.getaddress();
  String city = cartPageController.getcity();
  await showaddressDialog(context, cartPageController, formkey);
  await orderref.child("Orders").push().set({
    'order': ordername,
    'price': ordertotal,
    'name': resname,
    'area': area,
    'date': DateTime.now().toString(),
    'address': address,
    'city': city,
  }).then((value) {
    orderref.child("CartOrder").remove().then((value) {
      debugPrint("Orders deleted");
    });
    cartPageController.removeallt();
    getsnackbar("Order Created Successfully", "");
  }).onError((error, stackTrace) {
    debugPrint(error.toString());
    getsnackbar("Error in Creating Order", error.toString());
  }).onError((error, stackTrace) {
    getsnackbar("Network Error", "Please Check Your Internet Connection");
  });
  cartPageController.updateloading(true);
}

Future<void> showaddressDialog(BuildContext context,
    CartPageController cartPageController, GlobalKey<FormState> formkey) async {
  TextEditingController addresscontroller = TextEditingController();
  await showDialog<bool>(
      context: context,
      builder: (context) {
        var he = MediaQuery.of(context).size;
        return AlertDialog(
          title: SizedBox(
            width: he.width * 0.8,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: Center(
                child: Text(
                  "Do You Want to Update Address?",
                  softWrap: true,
                  style: AppFont.mediumText(20),
                ),
              ),
            ),
          ),
          content: SizedBox(
            height: he.height * 0.1,
            child: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      cursorColor: kprimaryColor,
                      controller: addresscontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Address field can't be empty";
                        }
                        return null;
                      },
                      onSaved: (address) {},
                      decoration: InputDecoration(
                        hintText: "Enter Address",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(kdefaultPadding),
                          child: Icon(Icons.home),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: he.width * 0.27,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          kprimaryColor.withOpacity(0.4)),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("No", style: AppFont.regularText(17)),
                  ),
                ),
                SizedBox(
                  width: he.width * 0.27,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          kprimaryColor.withOpacity(0.9)),
                    ),
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        cartPageController.updatea(addresscontroller.text);
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Update", style: AppFont.regularText(17)),
                  ),
                )
              ],
            )
          ],
        );
      });
}
