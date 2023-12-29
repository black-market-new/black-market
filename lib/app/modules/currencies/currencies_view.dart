import 'package:black_market/app/core/constants/app_colors.dart';
import 'package:black_market/app/core/constants/app_strings.dart';
import 'package:black_market/app/core/widgets/currencies_view_widgets/bank_list.dart';
import 'package:black_market/app/core/widgets/currencies_view_widgets/chart_stack.dart';
import 'package:black_market/app/core/widgets/currencies_view_widgets/home_average_container.dart';
import 'package:black_market/app/core/widgets/currencies_view_widgets/home_chart_tab_bar.dart';
import 'package:black_market/app/core/widgets/currencies_view_widgets/home_top_container.dart';
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
          child: RefreshIndicator(
            onRefresh: () async {
              await controller.getLatestCurrency();
              await controller.getBanks();
            },
            child: ListView(
              children: [
                const HomeTopContainer(),
                SizedBox(
                  height: 10.h,
                ),
                HomeChartTabBar(
                  length: 2,
                  tabs: [Text(AppStrings.live), Text(AppStrings.black)],
                ),
                ChartStack(),
                SizedBox(
                  height: 25.h,
                ),
                HomeChartTabBar(
                  length: 4,
                  tabs: [
                    Text(AppStrings.day),
                    Text(AppStrings.week),
                    Text(AppStrings.month),
                    Text(AppStrings.year)
                  ],
                ),
                SizedBox(
                  height: 25.h,
                ),
                const HomeAverageContainer(),
                SizedBox(
                  height: 20.h,
                ),
                const BankList()
              ],
            ),
          ),
        ));
  }
}
