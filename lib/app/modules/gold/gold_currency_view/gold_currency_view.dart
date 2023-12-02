import 'package:black_market/app/core/constants/app_asset_image.dart';
import 'package:black_market/app/core/constants/app_colors.dart';
import 'package:black_market/app/core/constants/app_strings.dart';
import 'package:black_market/app/core/constants/base_urls.dart';
import 'package:black_market/app/core/plugin/plugin_media_que.dart';
import 'package:black_market/app/modules/gold/main_gold/main_gold_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GoldCurrencyView extends GetView<MainGoldController> {
  const GoldCurrencyView({super.key});

  @override
  Widget build(BuildContext context) {
    bool filteredByCompany = false;

    return Scaffold(
      backgroundColor: AppColors.blackNormal,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
          children: [
            SizedBox(
              height: context.screenHeight * 0.12,
              child: GetBuilder<MainGoldController>(
                  id: "goldCompany",
                  builder: (_) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.goldCompanyList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    filteredByCompany = true;
                                    controller
                                        .updateCoinsWidgetOnClickingOnCompany(
                                            controller
                                                .goldCompanyList[index].id);
                                    print(controller.goldCompanyList[index].id);
                                  },
                                  child: CircleAvatar(
                                      radius: 30,
                                      child: Image.network(BaseUrls.storageUrl +
                                          controller
                                              .goldCompanyList[index].image)),
                                ),
                                SizedBox(
                                  height: context.screenHeight * 0.005,
                                ),
                                Text(
                                  controller.goldCompanyList[index].name,
                                  style: TextStyle(
                                      fontSize: 12 * context.textScale,
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          );
                        });
                  }),
            ),
            GetBuilder<MainGoldController>(
                id: "coinsListView",
                builder: (_) {
                  return ListView.builder(
                    key: Key('builder ${controller.selected.toString()}'),
                    scrollDirection: Axis.vertical,
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.gray,
                                borderRadius: BorderRadius.circular(12)),
                            child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: ExpansionTile(
                                    key: Key(index.toString()), //attention

                                    initiallyExpanded: index ==
                                        controller.selected, //attention

                                    onExpansionChanged: (value) =>
                                        controller.selectTile(value, index),
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: AppColors.yellowNormal),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12))),
                                    iconColor: AppColors.white,
                                    collapsedIconColor: AppColors.white,
                                    title: Text(
                                      filteredByCompany
                                          ? controller
                                              .filteredCoinsByCompany[index]!
                                              .name
                                              .toString()
                                          : controller.btcCoinsInfo[index].name
                                              .toString(),
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    children: [
                                      _buildTileDetails(
                                          AppStrings.gramPrice,
                                          filteredByCompany
                                              ? "${controller.filteredCoinsByCompany[index]!.sellPrice.toString()} ج.م"
                                              : "${controller.btcCoinsInfo[index].sellPrice.toString()} ج.م",
                                          AppColors.white),
                                      _buildTileDetails(
                                          AppStrings.gramManufacturing,
                                          filteredByCompany
                                              ? "${controller.filteredCoinsByCompany[index]!.workManShip.toString()} ج.م"
                                              : "${controller.btcCoinsInfo[index].workManShip.toString()} ج.م",
                                          AppColors.white),
                                      _buildTileDetails(
                                          AppStrings.totalTax,
                                          filteredByCompany
                                              ? "${controller.filteredCoinsByCompany[index]!.tax.toString()} ج.م"
                                              : "${controller.btcCoinsInfo[index].tax.toString()} ج.م",
                                          AppColors.white),
                                      _buildTileDetails(
                                          AppStrings
                                              .totalPriceWithManufacturingAndTax,
                                          filteredByCompany
                                              ? "${controller.filteredCoinsByCompany[index]!.totalPriceIncludingtaxAndWorkmanship.toString()} ج.م"
                                              : "${controller.btcCoinsInfo[index].totalPriceIncludingtaxAndWorkmanship.toString()} ج.م",
                                          AppColors.yellowNormal),
                                      _buildTileDetails(
                                          AppStrings.importAmount,
                                          filteredByCompany
                                              ? "${controller.filteredCoinsByCompany[index]!.returnFees.toString()} ج.م"
                                              : "${controller.btcCoinsInfo[index].returnFees.toString()} ج.م",
                                          AppColors.white),
                                      _buildTileDetails(
                                          AppStrings.difference,
                                          filteredByCompany
                                              ? "${controller.filteredCoinsByCompany[index]!.difference.toString()} ج.م"
                                              : "${controller.btcCoinsInfo[index].difference.toString()} ج.م",
                                          AppColors.white),
                                    ]))),
                      );
                    },
                    itemCount: filteredByCompany
                        ? controller.filteredCoinsByCompany.length
                        : controller.btcCoinsInfo.length,
                  );
                }),
          ],
        ),
      )),
    );
  }

  Widget _buildTileDetails(String text, String price, Color textColor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(color: textColor, fontWeight: FontWeight.w700),
          ),
          Text(
            price,
            style: TextStyle(color: textColor, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
