import 'package:black_market/app/core/constants/app_asset_icons.dart';
import 'package:black_market/app/core/constants/app_asset_image.dart';
import 'package:black_market/app/core/constants/app_colors.dart';
import 'package:black_market/app/core/constants/app_strings.dart';
import 'package:black_market/app/core/constants/base_urls.dart';
import 'package:black_market/app/core/plugin/plugin_media_que.dart';
import 'package:black_market/app/core/widgets/card_item.dart';
import 'package:black_market/app/core/widgets/line_chart.dart';
import 'package:black_market/app/core/widgets/select_currency_dialog.dart';
import 'package:black_market/app/modules/currencies/currencies_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CurrenciesView extends GetView<CurrenciesController> {
  const CurrenciesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.blackDarkActive,
        body: SafeArea(
          child: ListView(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.gray,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.elliptical(120, 20),
                            bottomRight: Radius.elliptical(120, 20))),
                    height: context.screenHeight * 0.35,
                    child: Padding(
                      padding: EdgeInsets.all(context.screenWidth * 0.03),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(context.screenWidth * 0.02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () => controller.goToNotification(),
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.blackDarkHover,
                                    child: Icon(
                                      Icons.notifications_none_outlined,
                                      color: AppColors.blackLight,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          AppStrings.hello,
                                          style: TextStyle(
                                            color: AppColors.blackLightActive,
                                          ),
                                        ),
                                        GetBuilder<CurrenciesController>(
                                            builder: (_) {
                                          return Text(
                                            controller.name,
                                            style: TextStyle(
                                              color: AppColors.white,
                                            ),
                                          );
                                        })
                                      ],
                                    ),
                                    SizedBox(
                                      width: context.screenWidth * 0.02,
                                    ),
                                    CircleAvatar(
                                      radius: 24,
                                      child: Image.asset(AppAssetImage.avatar),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: context.screenHeight * 0.02,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                AppStrings.blackMarketInEng,
                                style: TextStyle(
                                    fontSize: 28,
                                    color: AppColors.yellowNormal,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: context.screenHeight * 0.01,
                              ),
                              Text(
                                AppStrings.howMuchInBlackMarket,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.yellowLightActive,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: context.screenHeight * 0.01,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: context.screenHeight * 0.12,
                    width: context.screenWidth * 0.87,
                    decoration: BoxDecoration(
                      color: AppColors.yellowLight,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 12.h,
                        ),
                        SizedBox(
                          height: 15.h,
                          child: GetBuilder<CurrenciesController>(
                              id: "currencies",
                              builder: (_) {
                                return GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SelectCurrencyDialog(
                                          latestCurrencyList:
                                              controller.latestCurrencyList,
                                          onTap: (currencyId) {
                                            controller.selectedCurrencyId =
                                                currencyId;
                                            controller
                                                .currenyAccordingToBankInfo(
                                                    controller
                                                        .selectedCurrencyId);
                                            Get.back();
                                          },
                                          //   onTap: () {
                                          //   Get.back;
                                          // }
                                        );
                                      },
                                    );
                                  },
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.arrow_drop_down_sharp),
                                        Text(controller
                                                .currencyInBankList.isNotEmpty
                                            ? controller.currencyInBankList[0]
                                                .currencyName
                                            : ""),
                                        controller.currencyInBankList.isNotEmpty
                                            ? Image.network(
                                                BaseUrls.storageUrl +
                                                    controller
                                                        .currencyInBankList[0]
                                                        .currencyIcon)
                                            : Image.asset(
                                                AppAssetImage.bankMasr)
                                      ]),
                                );
                              }),
                        ),
                        SizedBox(
                          height: context.screenHeight * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppStrings.blackMarket,
                                    style:
                                        TextStyle(color: AppColors.lightGrey),
                                  ),
                                  Text(
                                    "40 ج.م ",
                                    style:
                                        TextStyle(color: AppColors.yellowDark),
                                  )
                                ],
                              ),
                              Container(
                                height: context.screenHeight * 0.04,
                                width: 1,
                                color: AppColors.lighterGrey,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppStrings.lastUpdate,
                                    style:
                                        TextStyle(color: AppColors.lightGrey),
                                  ),
                                  Text(
                                    "منذ 15 دقيقة",
                                    style: TextStyle(
                                        color: AppColors.darkGrey,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                              Container(
                                height: context.screenHeight * 0.04,
                                width: 1,
                                color: AppColors.lighterGrey,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppStrings.bankPrice,
                                    style:
                                        TextStyle(color: AppColors.lightGrey),
                                  ),
                                  Text(
                                    "30.25 ج.م ",
                                    style: TextStyle(
                                        color: AppColors.darkGrey,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: context.screenHeight * 0.02,
              ),
              const LineChartSample2(),
              Container(
                height: context.screenHeight * 0.12,
                width: context.screenWidth * 0.87,
                decoration: BoxDecoration(
                  color: AppColors.yellowNormal,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: context.screenHeight * 0.01,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Image.asset(AppAssetIcons.calculator),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppStrings.sell,
                                style: TextStyle(
                                    color: AppColors.darkBlack,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "40 ج.م ",
                                style: TextStyle(
                                    color: AppColors.darkBlack,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                          Container(
                            height: context.screenHeight * 0.04,
                            width: 1,
                            color: AppColors.yellowDark,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppStrings.buy,
                                style: TextStyle(
                                    color: AppColors.darkBlack,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "40 ج.م ",
                                style: TextStyle(
                                    color: AppColors.darkBlack,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                          Container(
                            height: context.screenHeight * 0.04,
                            width: 1,
                            color: AppColors.yellowDark,
                          ),
                          Text(
                            AppStrings.avgPrice,
                            style: TextStyle(
                                color: AppColors.darkBlack,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: context.screenHeight * 0.02,
              ),
              Padding(
                padding: EdgeInsets.all(context.screenHeight * 0.01),
                child: GetBuilder<CurrenciesController>(
                    id: "bankList",
                    builder: (_) {
                      return GridView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 15),
                          itemCount: controller.currencyInBankList.length,
                          itemBuilder: (ctx, i) => GestureDetector(
                              child: CardItem(
                                bankName: controller
                                    .currencyInBankList[i].bankName
                                    .toString(),
                                bankImage: controller
                                    .currencyInBankList[i].bankIcon
                                    .toString(),
                                sellPrice:
                                    controller.currencyInBankList[i].sellPrice,
                                buyPrice:
                                    controller.currencyInBankList[i].buyPrice,
                              ),
                              onTap: () => controller.goToBankDetails(
                                  controller.currencyInBankList[i].bankId)));
                    }),
              )
            ],
          ),
        ));
  }
}
