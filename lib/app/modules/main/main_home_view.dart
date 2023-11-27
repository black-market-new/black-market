import 'package:black_market/app/core/constants/app_asset_icons.dart';
import 'package:black_market/app/core/constants/app_colors.dart';
import 'package:black_market/app/core/constants/app_strings.dart';
import 'package:black_market/app/modules/currencies/currencies_view.dart';
import 'package:black_market/app/modules/favourite/favourite_view.dart';
import 'package:black_market/app/modules/gold/main_gold_view.dart';
import 'package:black_market/app/modules/main/main_home_controller.dart';
import 'package:black_market/app/modules/profile/main_profile/main_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainHomeView extends GetView<MainHomeController> {
  const MainHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        children: const [
          CurrenciesView(),
          MainGoldView(),
          FavouriteView(),
          MainProfileView(),
        ],
      ),
      bottomNavigationBar: GetBuilder<MainHomeController>(
        id: "MainHomeViewGetBuilder",
        builder: (_) {
          //  ClipRRect(
          //   borderRadius: const BorderRadius.only(
          //     topRight: Radius.circular(18),
          //     topLeft: Radius.circular(18),
          //   ),
          //   child:
          return BottomNavigationBar(
            onTap: controller.changePage,

            currentIndex: controller.pageIndex,

            //  selectedLabelStyle: ,
            selectedItemColor: AppColors.yellowNormalActive,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(AppAssetIcons.dollar),
                label: AppStrings.coins,
                activeIcon: Image.asset(AppAssetIcons.yellowDollar),
                backgroundColor: AppColors.gray,
              ),
              BottomNavigationBarItem(
                icon: Image.asset(AppAssetIcons.gold),
                label: AppStrings.gold,
                activeIcon: Image.asset(AppAssetIcons.yellowGold),
                backgroundColor: AppColors.gray,
              ),
              BottomNavigationBarItem(
                icon: Image.asset(AppAssetIcons.heart),
                label: AppStrings.favourite,
                activeIcon: Image.asset(AppAssetIcons.yellowHeart),
                backgroundColor: AppColors.gray,
              ),
              BottomNavigationBarItem(
                  icon: Image.asset(AppAssetIcons.profile),
                  label: AppStrings.profile,
                  backgroundColor: AppColors.gray,
                  activeIcon: Image.asset(AppAssetIcons.yellowProfile)),
            ],
          );
        },
      ),
    );
  }
}
