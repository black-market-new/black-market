import 'dart:developer';

import 'package:black_market/app/core/model/bank.dart';
import 'package:black_market/app/core/model/latest_currency.dart';
import 'package:black_market/app/core/model/setting.dart';
import 'package:black_market/app/core/model/user_setting.dart';
import 'package:black_market/app/core/plugin/shared_storage.dart';
import 'package:black_market/app/core/repo/bank_repo.dart';
import 'package:black_market/app/core/repo/setting_repo.dart';
import 'package:black_market/app/core/services/error_handler.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/repo/currency_repo.dart';

class SplashController extends GetxController {
  final SettingRepo settingRepo;
  final BankRepo bankRepo;
  final CurrencyRepo currencyRepo;
  bool isLoading = false;

  SplashController({
    required this.bankRepo,
    required this.currencyRepo,
    required this.settingRepo,
  });

  @override
  void onInit() {
    onStartSplash();
    super.onInit();
  }

  Future<void> onStartSplash() async {
    try {
      isLoading = true;
      update();
      await checkToken();
      isLoading = false;
      update();
    } on ExceptionHandler catch (e) {
      log("Error: $e");
      throw ExceptionHandler("Unknown error");
    }
  }

  Future<void> checkToken() async {
    await getSetting();
    await getBanks().then((value) => getSortedBanks());
    await getLatestCurrency();
    // .then((value) => getLatestCurrencySorted());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    bool? rememberMe = prefs.getBool("rememberMe");

    if (token != null && token.isNotEmpty && rememberMe == true) {
      await getUserSetting();
      Get.offAllNamed("/main_home");
    } else {
      Get.offAllNamed("/login");
    }
  }

  Future<void> getSetting() async {
    try {
      Setting setting = await settingRepo.getSetting();
      await SharedStorage.saveSetting(setting);
    } on ExceptionHandler catch (e) {
      log("Error: $e");
      throw ExceptionHandler("Unknown error");
    }
  }

  Future<UserSetting> getUserSetting() async {
    try {
      String? token = await SharedStorage.getToken();

      UserSetting userSetting = await settingRepo.getUserSetting(
        token: token.toString(),
      );

      await SharedStorage.saveUserSetting(userSetting);
      return userSetting;
    } on ExceptionHandler catch (e) {
      log("Error: $e");

      throw ExceptionHandler("Unknown error");
    }
  }

  Future<void> getBanks() async {
    try {
      List<Bank> banks = await bankRepo.getBanks();
      await SharedStorage.saveBanks(banks);
    } on ExceptionHandler catch (e) {
      log("Error: $e");
    }
  }

  Future<void> getLatestCurrency() async {
    try {
      await SharedStorage.deleteCurrencies();
      List<LatestCurrency> latestCurrencies =
          await currencyRepo.getLatestCurrencies();
      await SharedStorage.saveCurrencies(latestCurrencies);
      List<LatestCurrency> latestCurrenciesSorted =
          await SharedStorage.getCurrenciesSorted();
      List<LatestCurrency> temp = [];
      for (var element in latestCurrenciesSorted) {
        for (var element2 in latestCurrencies) {
          if (element.name == element2.name) {
            temp.add(LatestCurrency(
                id: element2.id,
                banner: element2.banner,
                icon: element2.icon,
                name: element2.name,
                code: element2.code,
                canBeMain: element2.canBeMain,
                sort: element.sort,
                showNetworkImage: element2.showNetworkImage,
                lastUpdate: element2.lastUpdate,
                createdAt: element2.createdAt,
                updatedAt: element2.updatedAt,
                livePrices: element2.livePrices,
                blackMarketPrices: element2.blackMarketPrices,
                bankPrices: element2.bankPrices));
          }
        }
        log(element.sort.toString());
      }
      for (var element in temp) {
        log(element.sort.toString() + element.name.toString());
      }
      await SharedStorage.saveCurrenciesSorted(temp);
    } on ExceptionHandler catch (e) {
      log("Error: $e");
    }
  }

  // Future<void> getLatestCurrencySorted() async {
  //   try {
  //     List<LatestCurrency> latestCurrencies =
  //         await SharedStorage.getCurrencies();
  //     List<LatestCurrency> latestCurrenciesSorted =
  //         await SharedStorage.getCurrenciesSorted();
  //     // for (var element1 in latestCurrencies) {
  //     //   for (var element2 in latestCurrenciesSorted) {
  //     //     if (element1.sort != element2.sort) {
  //     //       element1.sort = element2.sort;
  //     //     }
  //     //   }
  //     // }
  //     await SharedStorage.saveCurrenciesSorted(latestCurrencies);
  //   } on ExceptionHandler catch (e) {
  //     log("Error: $e");
  //   }
  // }

  Future<void> getSortedBanks() async {
    try {
      List<Bank> banks = await SharedStorage.getBanks();
      List<Bank> sortedBanks = await SharedStorage.getSortedBanks();
      for (var element1 in banks) {
        for (var element2 in sortedBanks) {
          if (element1.sort != element2.sort) {
            element1.sort = element2.sort;
          }
        }
      }
    } on ExceptionHandler catch (e) {
      log("Error: $e");
    }
  }
}
