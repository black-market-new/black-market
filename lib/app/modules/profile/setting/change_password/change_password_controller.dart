import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  void goToMainSetting() {
    Get.offNamed("/main_setting");
  }

  void goToMainHome() {
    Get.offNamed("/main_home");
  }
  //   void goToMainProfile() {
  //   Get.offNamed("/main_profile");
  // }

  ///storage.saveUser(user);
  // Get.to(Home());
}
