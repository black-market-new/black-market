import 'package:black_market/app/modules/login/login_controller.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // Get.put(AuthRepo(Get.find<Dio>()), permanent: true);
    Get.put(LoginController(
        //authRepo: Get.find<AuthRepo>(),
        // storageService: Get.find<StorageService>(),
        ));
  }
}
