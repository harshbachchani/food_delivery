import 'package:flutter/material.dart';
import 'package:food_delivery/homepage/screens/home/components/mycard.dart';

class CardListView extends StatelessWidget {
  final double lat;
  final double long;
  final List<dynamic> restaurantlist;
  const CardListView(
      {super.key,
      required this.lat,
      required this.long,
      required this.restaurantlist});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.45,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: restaurantlist.length,
          itemBuilder: (context, index) {
            String name = restaurantlist[index]["info"]["name"];
            String locality = restaurantlist[index]["info"]["locality"];
            String rating = restaurantlist[index]["info"]["avgRatingString"];
            String deliverytime =
                restaurantlist[index]["info"]["sla"]["slaString"];
            String imageid = restaurantlist[index]["info"]["cloudinaryImageId"];
            String discount = "";
            String id = restaurantlist[index]["info"]["id"];
            if (restaurantlist[index]["info"]["aggregatedDiscountInfoV3"] !=
                null) {
              discount = restaurantlist[index]["info"]
                      ["aggregatedDiscountInfoV3"]["header"] +
                  " ";
              String? a = restaurantlist[index]["info"]
                  ["aggregatedDiscountInfoV3"]["subHeader"];
              if (a != null) {
                discount += a;
              } else {
                discount += "ABOVE ₹299";
              }
            }
            return MyCard(name, imageid, rating, deliverytime, locality,
                discount, lat, long, id);
          },
        ),
      ),
    );
  }
}
