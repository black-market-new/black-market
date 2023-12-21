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
    await getBanks();
    // await getBanks().then((value) => getSortedBanks());
    // await getLatestCurrency().then((value) => getLatestCurrencySorted());
    await getLatestCurrency();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    bool? rememberMe = prefs.getBool("rememberMe");

    if (token != null && token.isNotEmpty && rememberMe == true) {
      await getUserSetting();
      Get.offAllNamed("/main_home");
    } else {
      Get.offAllNamed("/main_home");
      //   Get.offAllNamed("/login");
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
      List<LatestCurrency> latestCurrencies =
          await currencyRepo.getLatestCurrencies();
      List<LatestCurrency> sortedLatestCurrencies =
          await SharedStorage.getCurrenciesSorted();
      if (sortedLatestCurrencies.isNotEmpty) {
        List<LatestCurrency> sortedList = await sortingLatestCurrency(
            latestCurrencies, sortedLatestCurrencies);
        await SharedStorage.saveCurrenciesSorted(sortedList);
      } else {
        await SharedStorage.saveCurrencies(latestCurrencies);
        await SharedStorage.saveCurrenciesSorted(latestCurrencies);
      }
      // getLatestCurrencySorted();
    } on ExceptionHandler catch (e) {
      log("Error: $e");
    }
  }

  Future<List<LatestCurrency>> sortingLatestCurrency(
      List<LatestCurrency> latestCurrencies,
      List<LatestCurrency> latestCurrenciesSorted) async {

      // List<LatestCurrency> latestCurrencies =
      //     await SharedStorage.getCurrencies();
      // List<LatestCurrency> latestCurrenciesSorted =
      //     await SharedStorage.getCurrenciesSorted();
      for (var element1 in latestCurrencies) {
        for (var element2 in latestCurrenciesSorted) {
          if (element1.name == element2.name) {
            if (element1.sort != element2.sort) {
              element2.bankPrices = element1.bankPrices;
              element2.banner = element1.banner;
              element2.blackMarketPrices = element1.blackMarketPrices;
              element2.canBeMain = element1.canBeMain;
              element2.code = element1.code;
              element2.createdAt = element1.createdAt;
              element2.icon = element1.icon;
              element2.id = element1.id;
              element2.lastUpdate = element1.lastUpdate;
              element2.livePrices = element1.livePrices;
              element2.showNetworkImage = element1.showNetworkImage;
              element2.updatedAt = element1.updatedAt;
              element2.name = element1.name;
            }
          }
        }
      }
      return latestCurrenciesSorted;
      // for (var element in latestCurrencies) {
      //   log("Sorting: ${element.name! + element.sort.toString()}");
      // }
  
  }

  // Future<void> getSortedBanks() async {
  //   try {
  //     List<Bank> banks = await SharedStorage.getBanks();
  //     List<Bank> sortedBanks = await SharedStorage.getSortedBanks();
  //     for (var element1 in banks) {
  //       for (var element2 in sortedBanks) {
  //         if (element1.sort != element2.sort) {
  //           element1.sort = element2.sort;
  //         }
  //       }
  //     }
  //   } on ExceptionHandler catch (e) {
  //     log("Error: $e");
  //   }
  // }
}
