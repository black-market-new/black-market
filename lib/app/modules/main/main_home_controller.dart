import 'dart:developer';

import 'package:black_market/app/core/repo/setting_repo.dart';
import 'package:black_market/app/modules/currencies/currencies_binding.dart';
import 'package:black_market/app/modules/favourite/favourite_binding.dart';
import 'package:black_market/app/modules/gold/main_gold/main_gold_binding.dart';
import 'package:black_market/app/modules/profile/main_profile/main_profile_binding.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainHomeController extends GetxController {
  // PageController pageController = PageController();
  final SettingRepo settingRepo;

  int pageIndex = 3;
  bool tokenChecked = false;

  MainHomeController({required this.settingRepo});
  @override
  Future<void> onInit() async {
    super.onInit();
    pageIndex = 3;
    await changePage(pageIndex);
    // tokenChecked = await checkToken();
  }

  Future<void> changePage(int pageIndex) async {
    this.pageIndex = pageIndex;
    // pageController.jumpToPage(pageIndex);

    update(["MainHomeViewGetBuilder", "MainHomeViewScreenGetBuilder"]);

    if (pageIndex == 1) {
      log("Favourite");
      FavouriteBinding().dependencies();
      // MainGoldBinding().deleteController();
      // CurrenciesBinding().deleteController();
      // MainProfileBinding().deleteController();
      update(["MainHomeViewGetBuilder", "MainHomeViewScreenGetBuilder"]);
    } else if (pageIndex == 2) {
      log("gold");
      MainGoldBinding().dependencies();
      // MainProfileBinding().deleteController();
      // FavouriteBinding().deleteController();
      // CurrenciesBinding().deleteController();
      update(["MainHomeViewGetBuilder", "MainHomeViewScreenGetBuilder"]);
    } else if (pageIndex == 3) {
      log("currencies");
      CurrenciesBinding().dependencies();
      // MainProfileBinding().deleteController();
      // MainGoldBinding().deleteController();
      FavouriteBinding().deleteController();
      update(["MainHomeViewGetBuilder", "MainHomeViewScreenGetBuilder"]);
    } else if (pageIndex == 0) {
      log("Profile");
      // CurrenciesBinding().deleteController();
      // MainGoldBinding().deleteController();
      // FavouriteBinding().deleteController();
      MainProfileBinding().dependencies();
      update(["MainHomeViewGetBuilder", "MainHomeViewScreenGetBuilder"]);

      // log("token $tokenChecked");
      // if (tokenChecked) {
      //   LoginBinding().dependencies();
      //   //     CurrenciesBinding().dependencies();
      // } else {
      //   MainProfileBinding().dependencies();
      //   log("Profile");
      // }
    }
  }

  Future<bool> checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      return false;
    } else {
      return true;
    }
  }
}
