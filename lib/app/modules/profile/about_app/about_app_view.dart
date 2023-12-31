import 'package:black_market/app/core/constants/app_colors.dart';
import 'package:black_market/app/core/constants/app_strings.dart';
import 'package:black_market/app/core/widgets/custom_app_bar.dart';
import 'package:black_market/app/modules/profile/about_app/about_app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

class AboutAppView extends GetView<AboutAppController> {
  const AboutAppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackNormalHover,
      appBar: CustomAppBar(
        text: AppStrings.aboutApp,
        onTap: () => Get.back(),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0.w),
        child: Column(
          children: [
            SizedBox(
              height: 25.h,
            ),
            GetBuilder<AboutAppController>(
              id: "AboutAppController",
              builder: (_) {
                return Expanded(
                  child: SingleChildScrollView(
                    child: HtmlWidget(
                      controller.text,
                      textStyle: TextStyle(
                        fontSize: 15.sp,
                        color: AppColors.lighterGrey,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
