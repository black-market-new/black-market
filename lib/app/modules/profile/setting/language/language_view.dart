import 'package:black_market/app/core/constants/app_colors.dart';
import 'package:black_market/app/core/constants/app_strings.dart';
import 'package:black_market/app/core/plugin/plugin_media_que.dart';
import 'package:black_market/app/core/widgets/custom_app_bar.dart';
import 'package:black_market/app/modules/profile/setting/language/language_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageView extends GetView<LanguagegController> {
  const LanguageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackNormalHover,
      appBar: CustomAppBar(
        text: AppStrings.setting,
        onTap: () => Get.back(),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(context.screenWidth * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: context.screenHeight * 0.05,
              ),
              Text(
                AppStrings.selectLanguage,
                style: TextStyle(
                  fontSize: 16 * context.textScale,
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: context.screenHeight * 0.05,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.languages.length,
                  itemBuilder: (context, index) {
                    String currencyName = controller.languages[index];

                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(context.screenWidth * 0.05),
                          height: context.screenHeight * 0.08,
                          decoration: BoxDecoration(
                            color: AppColors.gray,
                            border: Border.all(color: AppColors.gray),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(
                                () => Radio<bool>(
                                  value:
                                      true, // ربما ترغب في تغيير هذا استنادًا إلى منطق التطبيق الخاص بك
                                  groupValue: controller.rememberLanguage.value,
                                  onChanged: (value) {
                                    controller.rememberLanguage.value = value!;
                                  },
                                  fillColor: MaterialStateColor.resolveWith(
                                    (states) {
                                      if (states.contains(
                                              MaterialState.disabled) ||
                                          !controller.rememberLanguage.value) {
                                        return AppColors.white;
                                      }
                                      return AppColors.yellowDark;
                                    },
                                  ),
                                ),
                              ),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(
                                  currencyName,
                                  style: TextStyle(
                                    color: AppColors.whiteLight,
                                    fontSize: 14 * context.textScale,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: context.screenHeight * 0.03,
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}