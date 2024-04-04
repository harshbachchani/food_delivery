import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_delivery/assets/fonts/app_font.dart';
import 'package:food_delivery/homepage/controller/location_controller.dart';
import 'package:food_delivery/homepage/screens/restaurant/components/search.dart';
import 'package:get/get.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class Restaurant extends StatefulWidget {
  final double lat;
  final double long;
  final String collectionId;
  final String tags;
  final String url;
  const Restaurant(
      {super.key,
      required this.url,
      required this.lat,
      required this.long,
      required this.collectionId,
      required this.tags});

  @override
  State<Restaurant> createState() => _RestaurantState();
}

class _RestaurantState extends State<Restaurant> {
  Future? _data;
  LocationController controller = Get.find();
  Future<Map<String, dynamic>> apiCall(double lat, double long) async {
    var url = Uri.parse(
        "https://www.swiggy.com/dapi/restaurants/list/v5?lat=$lat&lng=$long&collection=${widget.collectionId}&tags=${widget.tags}&sortBy=&filters=&type=rcv2&offset=0&page_type=null");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception("Failed to load data");
    }
  }

  @override
  void initState() {
    super.initState();
    _data = apiCall(controller.getlat(), controller.getlong());
  }

  @override
  Widget build(BuildContext context) {
    var he = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.only(top: 25),
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
                  const Color(0xFF6F35A5).withOpacity(.25)
                ]),
          ),
          child: FutureBuilder(
            future: _data,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("Error loading data try again"),
                );
              }
              Map<String, dynamic> d = snapshot.data! as Map<String, dynamic>;
              List<dynamic> mydata = d["data"]["cards"];
              String title = mydata[0]["card"]["card"]["title"];
              String description = mydata[0]["card"]["card"]["description"];
              String imageid = mydata[0]["card"]["card"]["imageId"];
              String imageheader =
                  "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/";
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                      backgroundColor: Colors.transparent,
                      automaticallyImplyLeading: false,
                      elevation: 0,
                      pinned: true,
                      centerTitle: false,
                      expandedHeight: he.height * 0.13,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Image.network(imageheader + imageid,
                            fit: BoxFit.contain, scale: 1.6),
                      )),
                  SliverToBoxAdapter(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 15),
                          child: Text(title, style: AppFont.mediumText(20)),
                        ),
                        SizedBox(
                          width: he.width * 0.9,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, top: 15),
                            child: Text(
                              description,
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: AppFont.mediumText(12,
                                  color: Colors.black.withOpacity(0.8)),
                            ),
                          ),
                        ),
                        SizedBox(height: he.height * 0.02),
                        Center(
                            child: Text("Restaurants to Explore",
                                style: AppFont.krpimaryText(20,
                                    color: Colors.black))),
                        SizedBox(height: he.height * 0.02),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SearchInput(mydata: mydata, controller: controller),
                  ),
                ],
              );
            },
          )),
    );
  }
}
