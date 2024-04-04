import 'package:flutter/material.dart';
import 'package:food_delivery/assets/fonts/app_font.dart';

String imageheader =
    "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/";

class RestaurantCards extends StatelessWidget {
  final Map<dynamic, dynamic> data;
  const RestaurantCards({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    var he = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: he.height * 0.25,
      width: he.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              height: he.height * 0.15,
              width: he.width * 0.35,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(imageheader + data['imageid'],
                    fit: BoxFit.cover),
              )),
          SizedBox(width: he.width * 0.05),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: he.height * 0.05),
                SizedBox(
                  width: he.width * 0.6,
                  child: Text(
                    data["name"],
                    softWrap: true,
                    style: AppFont.mediumText(18),
                  ),
                ),
                SizedBox(height: he.height * 0.01),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Color.fromARGB(255, 228, 161, 62),
                      size: 20,
                    ),
                    SizedBox(width: he.width * 0.02),
                    Text(data["rating"],
                        style: AppFont.krpimaryText(15,
                            color: const Color.fromARGB(255, 228, 161, 62))),
                    SizedBox(width: he.width * 0.02),
                    Text("(${data["ratingcnt"]})",
                        style: AppFont.krpimaryText(15,
                            color: Colors.black.withOpacity(0.8))),
                  ],
                ),
                SizedBox(height: he.height * 0.01),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on_outlined,
                        color: Color.fromARGB(255, 162, 162, 162)),
                    Expanded(
                      child: Text(
                        "${data["locality"]} , ${data["area"]}",
                        overflow: TextOverflow.ellipsis,
                        style: AppFont.krpimaryText(13,
                            color: Colors.black.withOpacity(0.8)),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
