// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:food_delivery/assets/fonts/app_font.dart';
import 'package:food_delivery/constanst.dart';
import 'package:food_delivery/homepage/controller/location_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

class CityPage extends StatefulWidget {
  final Function call;
  const CityPage({super.key, required this.call});

  @override
  State<CityPage> createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  List<CityInfo> cities = mycities;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    LocationController controller = Get.put(LocationController());
    Future<void> getCity(double lat, double long) async {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        String address =
            "${placemark.thoroughfare} ${placemark.subLocality} ${placemark.locality},${placemark.postalCode}, ${placemark.country}";
        String cityName = placemark.locality!;
        controller.updateaddress(address, cityName);
      }
    }

    return Scaffold(
      body: Container(
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
                const Color.fromARGB(255, 121, 112, 159).withOpacity(.4),
                const Color.fromARGB(255, 70, 53, 165).withOpacity(.2),
                const Color(0xFF6F35A5).withOpacity(.1),
                const Color(0xFF6F35A5).withOpacity(.05),
                const Color(0xFF6F35A5).withOpacity(.25)
              ]),
        ),
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          offset: const Offset(12, 26),
                          blurRadius: 50,
                          spreadRadius: 8,
                          color: Colors.grey.withOpacity(.15)),
                    ]),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          cities = mycities.where((element) {
                            return element.name
                                .toLowerCase()
                                .contains(value.toLowerCase());
                          }).toList();
                        });
                      },
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Search",
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 232, 230, 230),
                                width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 214, 211, 211),
                                width: 2.5),
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.8,
                  child: ListView.builder(
                    itemCount: cities.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          await getCity(cities[index].lat, cities[index].long);
                          controller.updatelocation(
                              cities[index].lat, cities[index].long);
                          widget.call();
                          Navigator.pop(context);
                        },
                        child: ListTile(
                          title: Text(cities[index].name,
                              style: AppFont.mediumText(
                                15,
                                color: Colors.black54,
                              )),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
