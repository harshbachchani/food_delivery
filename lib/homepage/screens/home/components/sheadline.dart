import 'package:flutter/material.dart';
import 'package:food_delivery/assets/fonts/app_font.dart';

class SHeadLine extends StatelessWidget {
  const SHeadLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("What's On your mind?", style: AppFont.mediumText(19)),
          Text("The best food for you ",
              style: AppFont.regularText(14, color: Colors.grey)),
        ],
      ),
    );
  }
}
