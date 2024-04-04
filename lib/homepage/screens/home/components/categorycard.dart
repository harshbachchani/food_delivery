import 'package:flutter/material.dart';
import 'package:food_delivery/homepage/screens/restaurant/restraurants.dart';

class CardListViewCategory extends StatelessWidget {
  final List<dynamic> categorieslist;
  final double lat;
  final double long;
  const CardListViewCategory(
      {super.key,
      required this.categorieslist,
      required this.lat,
      required this.long});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 175,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categorieslist.length,
          itemBuilder: (context, index) {
            String url = categorieslist[index]["action"]["link"];
            return CardCategory(
                categorieslist[index]["imageId"], url, lat, long);
          },
        ),
      ),
    );
  }
}

class CardCategory extends StatelessWidget {
  final String imageUrl;
  final String url;
  final double lat;
  final double long;
  final String imageheader =
      "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/";
  const CardCategory(this.imageUrl, this.url, this.lat, this.long, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Uri uri = Uri.parse(url);
        String? tags = uri.queryParameters['tags'];
        String? collectionId = uri.queryParameters['collection_id'];
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Restaurant(
                url: url,
                tags: tags!,
                collectionId: collectionId!,
                lat: lat,
                long: long,
              ),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 25, bottom: 25),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          width: 150,
          height: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    offset: const Offset(12, 26),
                    blurRadius: 50,
                    spreadRadius: 0,
                    color: const Color.fromARGB(255, 117, 116, 116)
                        .withOpacity(.15))
              ]),
          child: Image.network(imageheader + imageUrl,
              height: 100,
              fit: BoxFit.contain, frameBuilder: (BuildContext context,
                  Widget child, int? frame, bool? wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded!) {
              return child;
            }
            return AnimatedOpacity(
              opacity: frame == null ? 0 : 1,
              duration: const Duration(seconds: 1),
              curve: Curves.easeOut,
              child: child,
            );
          }),
        ),
      ),
    );
  }
}
