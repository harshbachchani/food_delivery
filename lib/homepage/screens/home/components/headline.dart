import 'package:flutter/material.dart';
import 'package:food_delivery/assets/fonts/app_font.dart';

class HeadLine extends StatelessWidget {
  final List<dynamic> data;
  const HeadLine({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data[1]["card"]["card"]["header"]["title"],
              style: AppFont.mediumText(19)),
          Text("The best food close to you ",
              style: AppFont.regularText(12, color: Colors.grey)),
        ],
      ),
    );
  }
}
