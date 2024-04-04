import 'package:flutter/material.dart';
import 'package:food_delivery/assets/fonts/app_font.dart';
import 'package:food_delivery/homepage/screens/restaurant_details/restaurant_details.dart';

class RestaurantItem extends StatelessWidget {
  final Map<dynamic, dynamic> mylist;
  final double lat;
  final double long;
  const RestaurantItem(
      {super.key, required this.mylist, required this.lat, required this.long});

  @override
  Widget build(BuildContext context) {
    String name = mylist["name"];
    int id = int.parse(mylist["id"]);
    String locality = mylist["areaName"];
    String rating = mylist["avgRatingString"];
    String deliverytime = mylist["sla"]["slaString"];
    String? distance = mylist["sla"]["lastMileTravelString"];
    distance ??= "4.0 km";
    String discount = "50% OFF ABOVE ₹299";
    if (mylist["aggregatedDiscountInfoV3"] != null) {
      discount = mylist["aggregatedDiscountInfoV3"]["header"] + " ";
      String? a = mylist["aggregatedDiscountInfoV3"]["subheader"];
      if (a != null) {
        discount += a;
      } else {
        discount += "UPTO ₹299";
      }
    }
    String cuisines = mylist["cuisines"].join(', ');
    String imageid = mylist["cloudinaryImageId"];
    String imageheader =
        "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/";
    var he = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      RestaurantDetails(lat: lat, long: long, id: id)));
        },
        child: Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: he.height / 4.5,
                width: he.width / 1.1,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                  image: DecorationImage(
                      scale: 1.1,
                      image: NetworkImage(imageheader + imageid),
                      fit: BoxFit.cover),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Text(
                        discount,
                        style: AppFont.mediumText(18, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      name,
                      style: AppFont.mediumText(15),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: he.height * 0.04,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: he.height * 0.03,
                            width: he.width * 0.07,
                            child: const CircleAvatar(
                              backgroundColor: Colors.green,
                              child: Icon(
                                Icons.star,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: he.width * 0.01),
                          Text(rating, style: AppFont.mediumText(15)),
                          SizedBox(width: he.width * 0.02),
                          Text(". $deliverytime", style: AppFont.mediumText(15))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        cuisines,
                        overflow: TextOverflow.ellipsis,
                        style: AppFont.krpimaryText(15,
                            color: Colors.grey.withOpacity(0.8)),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(locality,
                            style: AppFont.krpimaryText(15,
                                color: Colors.grey.withOpacity(0.8))),
                        SizedBox(width: he.width * 0.02),
                        Text(distance,
                            style: AppFont.krpimaryText(15,
                                color: Colors.grey.withOpacity(0.8))),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
