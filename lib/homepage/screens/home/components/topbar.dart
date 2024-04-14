import 'package:flutter/material.dart';
import 'package:food_delivery/assets/fonts/app_font.dart';
import 'package:food_delivery/constanst.dart';
import 'package:food_delivery/homepage/components/cities.dart';
import 'package:food_delivery/homepage/controller/location_controller.dart';
import 'package:food_delivery/homepage/screens/cart/cartpage.dart';
import 'package:get/get.dart';

class TopBar extends StatelessWidget {
  final String city;
  final Function func;
  const TopBar({super.key, required this.city, required this.func});
  @override
  Widget build(BuildContext context) {
    LocationController controller = Get.find();
    TextEditingController addresscontroller =
        TextEditingController(text: controller.getaddress());
    TextEditingController citycontroller =
        TextEditingController(text: controller.getcity());
    var size = MediaQuery.of(context).size;
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.all(25),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Icon(Icons.navigation, color: kprimaryColor),
                    SizedBox(width: size.width * 0.02),
                    Text(
                      controller.getcity(),
                      style: AppFont.mediumText(25),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_drop_down_outlined,
                          color: Colors.black, size: 30),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CityPage(call: func)));
                      },
                    )
                  ],
                ),
                Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        offset: const Offset(12, 26),
                        blurRadius: 50,
                        spreadRadius: 0,
                        color: Colors.grey.withOpacity(.25))
                  ]),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartPage(),
                          ));
                    },
                    child: const CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.shopping_cart,
                          size: 30, color: kprimaryColor),
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: size.width * 0.35,
                  child: Text(
                    controller.getaddress(),
                    softWrap: true,
                    style: AppFont.krpimaryText(13,
                        color: Colors.grey.withOpacity(0.8)),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return AlertDialog(
                          title: Center(
                            child: Text(
                              "Update Address",
                              style: AppFont.mediumText(20),
                            ),
                          ),
                          actions: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Column(
                                children: [
                                  TextField(
                                    autofocus: true,
                                    controller: citycontroller,
                                    decoration: InputDecoration(
                                      labelText: "City",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: addresscontroller,
                              decoration: InputDecoration(
                                labelText: "Address",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Cancel",
                                      style: AppFont.regularText(15,
                                          color: kprimaryColor),
                                    )),
                                TextButton(
                                    onPressed: () async {
                                      await controller.updateaddress(
                                          addresscontroller.text,
                                          citycontroller.text);
                                      func();
                                      // ignore: use_build_context_synchronously
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Update",
                                      style: AppFont.regularText(15,
                                          color: kprimaryColor),
                                    )),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.black,
                    size: 15,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
