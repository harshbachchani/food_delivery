import 'package:get/get.dart';

class MyMenuController extends GetxController {
  RxBool isloading = false.obs;
  RxInt ind = 0.obs;
  updateloading(bool a) {
    isloading.value = a;
  }

  void updateind(int i) {
    ind.value = i;
  }

  getindex() {
    return ind.value;
  }

  getloading() {
    return isloading.value;
  }
}
