import 'package:flutter/material.dart';
import 'package:food_delivery/assets/fonts/app_font.dart';
import 'package:food_delivery/constanst.dart';
import 'package:food_delivery/homepage/screens/home/homepage.dart';

class CartEmpty extends StatelessWidget {
  const CartEmpty({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            "Your Cart Is Empty",
            style: AppFont.mediumText(20),
          )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          const Icon(
            Icons.shopping_cart_outlined,
            color: kprimaryColor,
            size: 40,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Text(
            "Click to Explore Restaurants",
            style: AppFont.mediumText(20),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.2,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ));
              },
              child: Text(
                "click",
                style: AppFont.regularText(15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
