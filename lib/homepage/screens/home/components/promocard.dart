import 'package:flutter/material.dart';
import 'package:food_delivery/assets/fonts/app_font.dart';

class PromoCard extends StatelessWidget {
  const PromoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.18,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
                colors: [Color.fromARGB(255, 52, 120, 78), Color(0xFF6F35A5)])),
        child: Stack(
          children: [
            Opacity(
              opacity: .7,
              child:
                  Image.asset("assets/images/delivery.png", fit: BoxFit.cover),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    const Text(
                      "GET MIN ₹125 OFF",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Text(
                      "& Free Delivery",
                      style: AppFont.mediumText(17, color: Colors.white),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Text("on your order",
                        style: AppFont.regularText(14, color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
