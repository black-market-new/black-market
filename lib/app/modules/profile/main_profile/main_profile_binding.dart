import 'package:black_market/app/core/repo/setting_repo.dart';
import 'package:black_market/app/modules/profile/main_profile/main_profile_controller.dart';
import 'package:get/get.dart';

class MainProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainProfileController(
      settingRepo: Get.find<SettingRepo>(),
    )
    );
  }

  void deleteController() {
    Get.delete<MainProfileController>();
  }
}
