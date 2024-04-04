import 'package:flutter/material.dart';
import 'package:food_delivery/homepage/controller/location_controller.dart';
import 'package:food_delivery/homepage/screens/restaurant/components/restaurantcard.dart';

class SearchInput extends StatefulWidget {
  final List<dynamic> mydata;
  final LocationController controller;
  const SearchInput(
      {super.key, required this.mydata, required this.controller});

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  List<Map<dynamic, dynamic>> myres = <Map<dynamic, dynamic>>[];

  filllist(String contain) {
    for (int i = 3; i < widget.mydata.length; i++) {
      Map<dynamic, dynamic> a = widget.mydata[i]["card"]["card"]["info"];
      String name = a["name"];
      if (name.toLowerCase().contains(contain.toLowerCase())) {
        myres.add(a);
      } else if (contain == "") {
        debugPrint("Hello");
        myres.add(a);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    filllist("");
  }

  @override
  Widget build(BuildContext context) {
    var he = MediaQuery.of(context).size;
    double lat = widget.controller.getlat();
    double long = widget.controller.getlong();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  offset: const Offset(12, 26),
                  blurRadius: 50,
                  spreadRadius: 8,
                  color: Colors.grey.withOpacity(.15)),
            ]),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  myres.clear();
                  filllist(value);
                });
              },
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.grey),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 232, 230, 230), width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 214, 211, 211), width: 2.5),
                  )),
            ),
          ),
        ),
        SizedBox(
          height: he.height * 0.5,
          child: ListView.builder(
            itemCount: myres.length,
            itemBuilder: (context, index) {
              return RestaurantItem(mylist: myres[index], lat: lat, long: long);
            },
          ),
        ),
      ],
    );
  }
}
