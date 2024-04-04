import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  RxInt iconnum = 0.obs;
  changeicon(int val) {
    iconnum.value = val;
  }
}
