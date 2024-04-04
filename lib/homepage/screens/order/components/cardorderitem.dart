import 'package:flutter/material.dart';
import 'package:food_delivery/assets/fonts/app_font.dart';

class CardOrderItem extends StatelessWidget {
  final Map<dynamic, dynamic> data;

  const CardOrderItem({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    var he = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Material(
        elevation: 4,
        color: Colors.transparent,
        child: Container(
          height: he.height * 0.33,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 75, 53, 165).withOpacity(.4),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  data['name'],
                  overflow: TextOverflow.ellipsis,
                  style: AppFont.mediumText(25),
                ),
              ),
              SizedBox(height: he.height * 0.014),
              SizedBox(
                height: he.height * 0.03,
                width: he.width,
                child: Text(
                  data['area'],
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: AppFont.krpimaryText(20,
                      color: Colors.grey.withOpacity(0.8)),
                ),
              ),
              SizedBox(height: he.height * 0.014),
              SizedBox(
                height: he.height * 0.03,
                width: he.width,
                child: Text(
                  "₹${data['price'].toString()}",
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: AppFont.krpimaryText(20,
                      color: Colors.grey.withOpacity(0.8)),
                ),
              ),
              SizedBox(height: he.height * 0.01),
              Divider(color: Colors.grey.withOpacity(0.4), thickness: 1),
              Flexible(
                child: Text(
                  data['order'],
                  softWrap: true,
                  style: AppFont.krpimaryText(20,
                      color: Colors.grey.withOpacity(0.8)),
                ),
              ),
              SizedBox(height: he.height * 0.01),
              SizedBox(
                height: he.height * 0.04,
                width: he.width,
                child: Text(
                  data['date'],
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: AppFont.regularText(17,
                      color: Colors.grey.withOpacity(0.8)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
