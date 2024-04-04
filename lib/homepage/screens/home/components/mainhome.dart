import 'package:flutter/material.dart';
import 'package:food_delivery/assets/fonts/app_font.dart';
import 'package:food_delivery/homepage/controller/location_controller.dart';
import 'package:food_delivery/homepage/screens/home/components/cardlist.dart';
import 'package:food_delivery/homepage/screens/home/components/categorycard.dart';
import 'package:food_delivery/homepage/screens/home/components/headline.dart';
import 'package:food_delivery/homepage/screens/home/components/promocard.dart';
import 'package:food_delivery/homepage/screens/home/components/sheadline.dart';
import 'package:food_delivery/homepage/screens/home/components/topbar.dart';
import 'package:get/get.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  late List<dynamic> mydata;
  Future? _data;
  LocationController controller = Get.find();

  @override
  void initState() {
    super.initState();
    _data = apiCall(controller.getlat(), controller.getlong());
  }

  Future<Map<String, dynamic>> apiCall(double lat, double long) async {
    var url = Uri.parse(
        "https://www.swiggy.com/dapi/restaurants/list/v5?lat=$lat&lng=$long&is-seo-homepage-enabled=true&page_type=DESKTOP_WEB_LISTING");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception("Failed to load data");
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
        setState(() {
          _data = apiCall(controller.getlat(), controller.getlong());
        });
      },
      child: FutureBuilder(
        future: _data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Error in getting data",
                    style: AppFont.mediumText(30),
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 100,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _data = apiCall(
                              controller.getlat(), controller.getlong());
                        });
                      },
                      child: Text(
                        "Refresh",
                        style: AppFont.mediumText(10),
                      )),
                ),
              ],
            ));
          } else if (snapshot.hasData) {
            mydata = snapshot.data!["data"]["cards"];

            if (mydata[0]["card"]["card"]["id"] == "swiggy_not_present") {
              return Container(
                padding: const EdgeInsets.only(top: 25, left: 15, right: 15),
                height: size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color.fromARGB(255, 83, 69, 164),
                        const Color.fromARGB(255, 66, 53, 165).withOpacity(.8),
                        const Color.fromARGB(255, 75, 53, 165).withOpacity(.6),
                        const Color.fromARGB(255, 121, 112, 159)
                            .withOpacity(.4),
                        const Color.fromARGB(255, 70, 53, 165).withOpacity(.2),
                        const Color(0xFF6F35A5).withOpacity(.1),
                        const Color(0xFF6F35A5).withOpacity(.05),
                        const Color(0xFF6F35A5).withOpacity(.25)
                      ]),
                ),
                child: Column(
                  children: [
                    TopBar(
                        city: controller.getcity(),
                        func: () {
                          setState(() {
                            _data = apiCall(
                                controller.getlat(), controller.getlong());
                            debugPrint("Hii");
                          });
                        }),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: size.height * 0.1),
                          Text(
                            "We're not there yet!",
                            style: AppFont.mediumText(25),
                          ),
                          SizedBox(height: size.height * 0.03),
                          Flexible(
                              child: Text(
                            "Sorry,our services are currently unavailabe at this location. We hope to serve you in future",
                            style: AppFont.krpimaryText(20,
                                color: Colors.black.withOpacity(.6)),
                          ))
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              List<dynamic>? categorylist =
                  mydata[0]["card"]["card"]["imageGridCards"]["info"];
              List<dynamic>? restaurantlists = mydata[1]["card"]["card"]
                  ["gridElements"]["infoWithStyle"]["restaurants"];

              return Container(
                padding: const EdgeInsets.only(top: 25),
                height: size.height,
                width: size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color.fromARGB(255, 83, 69, 164),
                        const Color.fromARGB(255, 66, 53, 165).withOpacity(.8),
                        const Color.fromARGB(255, 75, 53, 165).withOpacity(.6),
                        const Color.fromARGB(255, 121, 112, 159)
                            .withOpacity(.4),
                        const Color.fromARGB(255, 70, 53, 165).withOpacity(.2),
                        const Color(0xFF6F35A5).withOpacity(.1),
                        const Color(0xFF6F35A5).withOpacity(.05),
                        const Color(0xFF6F35A5).withOpacity(.25)
                      ]),
                ),
                child: SingleChildScrollView(
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TopBar(
                            city: controller.getcity(),
                            func: () {
                              debugPrint("Hello");
                              setState(() {
                                _data = apiCall(
                                    controller.getlat(), controller.getlong());
                              });
                            }),
                        const PromoCard(),
                        const SHeadLine(),
                        CardListViewCategory(
                            categorieslist: categorylist!,
                            lat: controller.getlat(),
                            long: controller.getlong()),
                        HeadLine(data: mydata),
                        CardListView(
                            lat: controller.getlat(),
                            long: controller.getlong(),
                            restaurantlist: restaurantlists!),
                      ],
                    ),
                  ),
                ),
              );
            }
          }
          return const Center(child: Text("Hello there"));
        },
      ),
    );
  }
}
