import 'package:get/get.dart';

class MainProfileController extends GetxController {
  void goToEditProfile() {
    Get.offNamed("/edit_profile");
  }

  void goToHome() {
    Get.offNamed("/main_home");
  }

  ///storage.saveUser(user);
  // Get.to(Home());
}
