import 'package:flutter/material.dart';
import 'package:food_delivery/assets/fonts/app_font.dart';
import 'package:food_delivery/homepage/screens/restaurant_details/restaurant_details.dart';

class MyCard extends StatelessWidget {
  final double lat;
  final double long;
  final String id;
  final String title;
  final String imageid;
  final String dtime;
  final String locality;
  final String rating;
  final String discount;
  final String imageheader =
      "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/";
  const MyCard(this.title, this.imageid, this.rating, this.dtime, this.locality,
      this.discount, this.lat, this.long, this.id,
      {super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                RestaurantDetails(lat: lat, long: long, id: int.parse(id)),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 25, bottom: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              width: size.width * 0.7,
              height: size.height * 0.22,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(12, 26),
                      blurRadius: 50,
                      spreadRadius: 0,
                      color: const Color.fromARGB(255, 117, 116, 116)
                          .withOpacity(.15),
                    ),
                  ],
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      scale: 1.1,
                      image: NetworkImage(imageheader + imageid))),
              child: Stack(
                children: [
                  Positioned(
                      bottom: 0,
                      left: 20,
                      child: Text(
                        discount == "" ? "50% OFF UPTO ₹150" : discount,
                        style: AppFont.mediumText(16, color: Colors.white),
                      ))
                ],
              ),
            ),
            Container(
              height: size.height * 0.17,
              width: size.width * 0.7,
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                children: [
                  Text(
                    title,
                    style: AppFont.mediumText(20),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 25,
                        width: MediaQuery.of(context).size.width / 7,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.01),
                            Text(
                              rating,
                              style:
                                  AppFont.mediumText(14, color: Colors.white),
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.01),
                            const Icon(Icons.star,
                                size: 20, color: Colors.white),
                          ],
                        ),
                      ),
                      Text("   $dtime away", style: AppFont.mediumText(17))
                    ],
                  ),
                  Text(
                    locality,
                    style: AppFont.mediumText(17),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
