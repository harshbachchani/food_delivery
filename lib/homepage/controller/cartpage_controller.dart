import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class CartPageController extends GetxController {
  RxInt total = 0.obs;
  RxInt fee = 0.obs;
  RxString resname = "".obs;
  RxString rearea = "".obs;
  RxString address = "".obs;
  RxString city = "".obs;
  RxList<Map<dynamic, dynamic>> orders = <Map<dynamic, dynamic>>[].obs;
  RxList<int> quantity = <int>[].obs;
  RxList<int> price = <int>[].obs;
  RxBool isloading = false.obs;
  RxBool flag = false.obs;

  getresname() {
    return resname.value;
  }

  getareaname() {
    return rearea.value;
  }

  getcity() {
    return city.value;
  }

  getaddress() {
    return address.value;
  }

  updateaddress(String a, String b) {
    address.value = a;
    city.value = b;
  }

  updatea(String a) {
    address.value = a;
  }

  updateresd(String a, String b) {
    resname.value = a;
    rearea.value = b;
  }

  updateloading(bool a) {
    isloading.value = a;
  }

  getload() {
    return flag.value;
  }

  updateload(bool a) {
    flag.value = a;
  }

  getloading() {
    return isloading.value;
  }

  getfee() {
    if (total.value > 500) return 0;
    return fee.value;
  }

  updatefee(int a) {
    fee.value = a;
  }

  gettotal() {
    total.value = 0;
    for (var x in orders) {
      int a = int.parse(x['price']);
      total.value = (x['quantity'] * a) + total.value;
    }
    if (fee.value < 500) total.value += fee.value;
    return total.value;
  }

  getquantity(int index) {
    return quantity[index];
  }

  getprice(int index) {
    return price[index];
  }

  addorder(Map<dynamic, dynamic> a) {
    orders.add(a);
    quantity.add(a['quantity']);
    int x = a['quantity'] * int.parse(a['price']);
    price.add(x);
    total.value = (a['quantity'] * x) + total.value;
  }

  String getordersstring() {
    List<String> list = <String>[];
    for (int i = 0; i < orders.length; i++) {
      list.add(orders[i]['name']);
    }
    return list.join(', ');
  }

  addquantity(int index) {
    orders[index]["quantity"] += 1;
    quantity[index] = quantity[index] + 1;
    price[index] = quantity[index] * int.parse(orders[index]['price']);
    gettotal();
  }

  Future<bool> updatedatabase(
      DatabaseReference mydb, bool add, int index) async {
    updateload(true);
    Completer<bool> completer = Completer<bool>();
    int orderid = orders[index]["orderid"];
    mydb.child("orders").get().then((val) async {
      Map<dynamic, dynamic> data = val.value as Map<dynamic, dynamic>;
      String oid = "";
      data.forEach((key, value) {
        if (value["orderid"] == orderid) {
          oid = key.toString();
          return;
        }
      });
      mydb.child("orders").child(oid).update({
        "quantity": add ? quantity[index] + 1 : quantity[index] - 1,
      }).onError((error, stackTrace) {
        completer.complete(false);
      }).then((value) {
        completer.complete(true);
      });
    }).onError((error, stackTrace) {
      completer.complete(false);
    });
    updateload(false);
    return completer.future;
  }

  deletequantity(int index) {
    orders[index]['quantity'] -= 1;
    quantity[index] = quantity[index] - 1;
    price[index] = quantity[index] * int.parse(orders[index]['price']);
    gettotal();
  }

  removeitem(int index) {
    price.removeAt(index);
    quantity.removeAt(index);
    orders.removeAt(index);
    gettotal();
  }

  removeallt() {
    price.clear();
    quantity.clear();
    orders.clear();
    total.value = 0;
  }

  Map<dynamic, dynamic> getorder(int index) {
    return orders[index];
  }
}
