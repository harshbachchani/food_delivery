import 'package:get/get.dart';

class RestaurantDetailsController extends GetxController {
  RxBool ischecked = true.obs;
  toggleCheck() {
    ischecked.value = !ischecked.value;
  }

  bool getvalue() {
    return ischecked.value;
  }
}
