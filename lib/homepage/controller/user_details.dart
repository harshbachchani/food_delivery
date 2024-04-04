import 'package:get/get.dart';

class UserDetails extends GetxController {
  RxString name = "".obs;
  RxString email = "".obs;
  RxString number = "".obs;
  RxString uid = "".obs;
  updatename(String a) {
    name.value = a;
  }

  updatemail(String a) {
    email.value = a;
  }

  updatenumber(String a) {
    number.value = a;
  }

  updateuid(String a) {
    uid.value = a;
  }

  getnumber() {
    return number.value;
  }

  getname() {
    return name.value;
  }

  getuid() {
    return uid.value;
  }

  getemail() {
    return email.value;
  }
}
