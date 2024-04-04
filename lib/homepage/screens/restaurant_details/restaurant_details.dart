import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/assets/fonts/app_font.dart';
import 'package:food_delivery/constanst.dart';
import 'package:food_delivery/homepage/screens/cart/cartpage.dart';

import 'package:food_delivery/homepage/controller/mymenucontroller.dart';
import 'package:food_delivery/homepage/controller/user_details.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

String imageheader =
    "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/";
String imageheader2 =
    "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_208,h_208,c_fit/";

DatabaseReference databaseuser =
    FirebaseDatabase.instance.ref('Users').child(userDetails.getuid());
Map<String, dynamic> trestauinf = {};
List<dynamic> menuinfo = [];
List<Map<String, dynamic>> menulist = <Map<String, dynamic>>[];
MyMenuController menuController = Get.put(MyMenuController());
UserDetails userDetails = Get.find();

class RestaurantDetails extends StatefulWidget {
  final double lat;
  final double long;
  final int id;
  const RestaurantDetails(
      {super.key, required this.lat, required this.long, required this.id});

  @override
  State<RestaurantDetails> createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantDetails> {
  Future<Map<String, dynamic>> apiCall(double lat, double long, int id) async {
    var url = Uri.parse(
        "https://www.swiggy.com/dapi/menu/pl?page-type=REGULAR_MENU&complete-menu=true&lat=$lat&lng=$long&restaurantId=$id&catalog_qa=undefined&submitAction=ENTER");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception("Failed to load data");
    }
  }

  @override
  void dispose() {
    menuinfo.clear();
    menulist.clear();
    trestauinf.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        height: 90,
        color: const Color(0xFF6F35A5).withOpacity(.25),
        elevation: 0,
        child: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              color: kprimaryColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 50,
                    color: kprimaryColor.withOpacity(.25))
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(),
                      ));
                },
                child: Text(
                  "Order Now",
                  style: AppFont.mediumText(20, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
      body: FutureBuilder(
        future: apiCall(widget.lat, widget.long, widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error in loading data..."));
          }
          List<dynamic> carddata = snapshot.data!["data"]["cards"];
          initializedata(carddata);
          return const MainScreen();
        },
      ),
    );
  }
}

void initializedata(List<dynamic> carddata) {
  if (carddata[4]["groupedCard"]["cardGroupMap"]["REGULAR"]["cards"][1]["card"]
          ["card"]["itemCards"] ==
      null) {
    menuinfo = carddata[4]["groupedCard"]["cardGroupMap"]["REGULAR"]["cards"][2]
        ["card"]["card"]["itemCards"];
  } else {
    menuinfo = carddata[4]["groupedCard"]["cardGroupMap"]["REGULAR"]["cards"][1]
        ["card"]["card"]["itemCards"];
  }
  Map<String, dynamic> restaurantinfo = carddata[2]["card"]["card"]["info"];
  trestauinf["imageid"] = restaurantinfo["cloudinaryImageId"] ?? "";
  trestauinf["name"] = restaurantinfo["name"] ?? "Barbeque Nation";
  trestauinf["costfortwo"] =
      restaurantinfo["costForTwoMessage"] ?? "200 for two";
  trestauinf["rating"] = restaurantinfo["avgRatingString"] ?? "4.3";
  trestauinf["ratingcnt"] =
      restaurantinfo["totalRatingsString"] ?? "1K+ ratings";
  trestauinf["locality"] = restaurantinfo["locality"] ?? "";
  trestauinf["distance"] = restaurantinfo["sla"]["lastMileTravelString"] ?? "";
  trestauinf["area"] = restaurantinfo["areaName"] ?? "";
  List<dynamic> a = restaurantinfo["cuisines"] ?? "";
  trestauinf["cuisines"] = a.join(',');
  trestauinf["deliverymsg"] = restaurantinfo["feeDetails"]["message"] ?? "";
  String b = restaurantinfo["feeDetails"]["totalFee"].toString();
  trestauinf["deliveryfee"] = b.substring(0, b.length - 2);
  trestauinf["id"] = restaurantinfo["id"];

  for (int i = 0; i < menuinfo.length; i++) {
    Map<String, dynamic> x = menuinfo[i]["card"]["info"];
    String imageid = x["imageId"] ?? "";
    String name = x["name"] ?? "";
    String price = "249";
    String rating = "4.2";
    String ratingCnt = "245";
    int isVeg = x["isVeg"] ?? 0;
    if (x["ratings"] != null &&
        x["ratings"]["aggregatedRating"] != null &&
        x["ratings"]["aggregatedRating"]["rating"] != null) {
      rating = x["ratings"]["aggregatedRating"]["rating"];
      ratingCnt =
          x["ratings"]["aggregatedRating"]["ratingCountV2"] ?? ratingCnt;
    }
    if (x["price"] != null) {
      price = x["price"].toString();
      price = price.substring(0, price.length - 2);
    }
    Map<String, dynamic> mymap = {};
    mymap["quantity"] = 0;
    mymap["orderid"] = 1001 + i;
    mymap["imageid"] = imageid;
    mymap["name"] = name;
    mymap["rating"] = rating;
    mymap["ratingcnt"] = ratingCnt;
    mymap["isveg"] = isVeg;
    mymap["price"] = price;
    menulist.add(mymap);
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.only(top: 40),
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(255, 83, 69, 164),
              const Color.fromARGB(255, 66, 53, 165).withOpacity(.8),
              const Color.fromARGB(255, 75, 53, 165).withOpacity(.6),
              const Color.fromARGB(255, 121, 112, 159).withOpacity(.4),
              const Color.fromARGB(255, 70, 53, 165).withOpacity(.2),
              const Color(0xFF6F35A5).withOpacity(.1),
              const Color(0xFF6F35A5).withOpacity(.05),
              const Color(0xFF6F35A5).withOpacity(.25)
            ]),
      ),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            centerTitle: false,
            floating: true,
            expandedHeight: size.height * 0.35,
            flexibleSpace: const TopImage(),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.03),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("Recommended", style: AppFont.mediumText(20)),
                ),
              ],
            ),
          ),
          SliverList.builder(
            itemCount: menuinfo.length,
            itemBuilder: (context, index) {
              return RestaurantMenu(index);
            },
          )
        ],
      ),
    );
  }
}

class TopImage extends StatefulWidget {
  const TopImage({super.key});

  @override
  State<TopImage> createState() => _TopImageState();
}

class _TopImageState extends State<TopImage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.4,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(imageheader + trestauinf["imageid"]),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: size.height * 0.02,
            top: size.height * 0.08,
            left: size.width * 0.05,
            right: size.width * 0.05,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return constraints.maxHeight <= size.height * 0.03
                    ? const Center()
                    : Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 40,
                              color: Colors.grey.withOpacity(0.6),
                            )
                          ],
                        ),
                        child: const RestaurantCard(),
                      );
              },
            ),
          )
        ],
      ),
    );
  }
}

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({super.key});

  @override
  Widget build(BuildContext context) {
    var he = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (context, constraints) {
        double height = constraints.maxHeight;
        return height <= he.height * 0.1
            ? Center(
                child: Text(
                trestauinf["name"],
                softWrap: true,
                style: GoogleFonts.notoSans(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  height <= he.height * 0.12
                      ? const Center()
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: he.width * 0.6,
                              child: Text(
                                trestauinf["name"],
                                softWrap: true,
                                style: GoogleFonts.notoSans(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.favorite_outline,
                                  color: Colors.red,
                                )),
                          ],
                        ),
                  SizedBox(height: he.height * 0.01),
                  height <= he.height * 0.17
                      ? const Center()
                      : Row(
                          children: [
                            CircleAvatar(
                              maxRadius: 10,
                              backgroundColor: Colors.green.shade800,
                              child: const Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                            SizedBox(width: he.width * 0.02),
                            Text(trestauinf["rating"],
                                style: AppFont.krpimaryText(15,
                                    color: Colors.black)),
                            SizedBox(width: he.width * 0.02),
                            Text("(${trestauinf["ratingcnt"]})",
                                style: AppFont.krpimaryText(15,
                                    color: Colors.black)),
                            SizedBox(width: he.width * 0.03),
                            Text(trestauinf["costfortwo"],
                                style: AppFont.krpimaryText(15,
                                    color: Colors.black))
                          ],
                        ),
                  SizedBox(height: he.height * 0.01),
                  height <= he.height * 0.2
                      ? const Center()
                      : Text(
                          trestauinf["cuisines"],
                          style: AppFont.krpimaryText(13,
                              color: Colors.black.withOpacity(0.5)),
                        ),
                  SizedBox(height: he.height * 0.01),
                  height <= he.height * 0.22
                      ? const Center()
                      : Text(
                          "${trestauinf["locality"]} , ${trestauinf["area"]}",
                          style: AppFont.krpimaryText(13,
                              color: Colors.black.withOpacity(0.5)),
                        ),
                  height <= he.height * 0.25
                      ? const Center()
                      : Divider(color: Colors.grey.withOpacity(0.4)),
                  SizedBox(height: he.height * 0.02),
                  height <= he.height * 0.26
                      ? const Center()
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(
                              'https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/v1648635511/Delivery_fee_new_cjxumu',
                              height: 20,
                              width: 20,
                            ),
                            SizedBox(width: he.width * 0.01),
                            SizedBox(
                              width: constraints.maxWidth * 0.9,
                              child: Text(
                                "${trestauinf["distance"]} | ₹${trestauinf["deliveryfee"]} ${trestauinf["deliverymsg"]}",
                                softWrap: true,
                                textAlign: TextAlign.center,
                                style: AppFont.krpimaryText(13,
                                    color: Colors.black.withOpacity(0.7)),
                              ),
                            ),
                          ],
                        )
                ],
              );
      },
    );
  }
}

Future<void> addorder(int index, BuildContext context) async {
  menuController.updateloading(true);
  String resid = trestauinf["id"];
  DatabaseReference cartref = databaseuser.child("CartOrder");
  Map<String, dynamic> orderdetail = menulist[index];
  orderdetail["quantity"] += 1;
  DataSnapshot cartorders = await cartref.get();
  if (cartorders.value != null) {
    Map<dynamic, dynamic> orderdata = cartorders.value as Map<dynamic, dynamic>;
    if (orderdata["id"] != resid) {
      showDialog(
        context: context,
        builder: (context) {
          return mydialog(context, orderdata, cartref, index);
        },
      );
    } else {
      DatabaseReference orderref = cartref.child("orders");

      Map<dynamic, dynamic> orders = orderdata["orders"];
      bool flag = false;
      String existingorderid = "";
      orders.forEach((key, value) {
        if (value["orderid"] == orderdetail["orderid"]) {
          flag = true;
          existingorderid = key;
          return;
        }
      });
      if (!flag) {
        await orderref.push().set(orderdetail).then((value) {
          getsnackbar("Added", "Item Added successfully");
        }).onError((error, stackTrace) {
          getsnackbar("Failed", "Error on adding item try after some time");
        });
      } else {
        int quantity = orders[existingorderid]["quantity"];
        await orderref
            .child(existingorderid)
            .update({"quantity": quantity + 1}).then((value) {
          getsnackbar(
              "Updated", "Already exist item quantity has been updated");
        }).onError((error, stackTrace) {
          getsnackbar("Failed", "Error on adding Item try after some time");
        });
      }
    }
  } else {
    await cartref.set(trestauinf);
    DatabaseReference orderref = cartref.child("orders");
    await orderref.push().set(orderdetail).then((value) {
      getsnackbar("Added", "Item Added Successfully");
    }).onError((error, stackTrace) {
      getsnackbar("failed", "Error on adding item try again later");
    });
  }

  menuController.updateloading(false);
}

AlertDialog mydialog(BuildContext context, Map<dynamic, dynamic> orderdata,
    DatabaseReference cartref, int index) {
  return AlertDialog(
    title: Center(
        child: Text('Replace Cart Item?', style: AppFont.mediumText(20))),
    content: Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Text(
          giveText(orderdata["name"], trestauinf["name"]),
          style: AppFont.regularText(14),
          softWrap: true,
        ),
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        kprimaryColor.withOpacity(0.4)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "No",
                    style: AppFont.mediumText(13),
                  )),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(kprimaryColor),
                  ),
                  onPressed: () {
                    cartref.remove().then((value) {
                      cartref.set(trestauinf).then((value) {
                        getsnackbar("Item replaced ", "Go to cart to check");
                      }).onError((error, stackTrace) {
                        getsnackbar("Failed", "Error in replacing data");
                      });
                      DatabaseReference orderref = cartref.child("orders");
                      orderref.push().set(menulist[index]);
                    }).onError((error, stackTrace) {
                      getsnackbar("Error in Replacing items",
                          "Try again after some time");
                    });
                    Navigator.pop(context);
                  },
                  child: Text("Replace", style: AppFont.mediumText(13))),
            )
          ],
        ),
      ),
    ],
  );
}

class RestaurantMenu extends StatelessWidget {
  final int index;
  const RestaurantMenu(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    var he = MediaQuery.of(context).size;
    return Container(
      height: he.height * 0.24,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: he.width * 0.5,
                      child: Text(menulist[index]["name"],
                          style: AppFont.mediumText(15), softWrap: true)),
                  SizedBox(height: he.height * 0.01),
                  Text("₹${menulist[index]["price"]}",
                      style: AppFont.regularText(14, color: Colors.black)),
                  SizedBox(height: he.height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color.fromARGB(255, 31, 91, 33),
                        size: 18,
                      ),
                      Text(
                        "${menulist[index]["rating"]}(${menulist[index]["ratingcnt"]})",
                        style: AppFont.regularText(14),
                      )
                    ],
                  )
                ],
              ),
              Container(
                  height: he.height * 0.15,
                  width: he.width * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
                          imageheader + menulist[index]["imageid"]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Obx(
                    () => Stack(
                      children: [
                        Positioned(
                          bottom: 2,
                          left: he.width * 0.02,
                          right: he.width * 0.02,
                          child: InkWell(
                            onTap: () {
                              if (!menuController.getloading()) {
                                menuController.updateind(index);
                                addorder(index, context);
                              }
                            },
                            child: Container(
                              height: he.height * 0.04,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 4,
                                    )
                                  ]),
                              child: Center(
                                child: menuController.getloading() &&
                                        menuController.getindex() == index
                                    ? const CircularProgressIndicator()
                                    : Text(
                                        "Add",
                                        style: AppFont.mediumText(10,
                                            color: Colors.green),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
          Divider(color: Colors.grey.withOpacity(0.5)),
        ],
      ),
    );
  }
}

String giveText(String a, String b) {
  return "Your Cart Contains dishes from $a. Do You want to replace the items and add dishes from $b?";
}
