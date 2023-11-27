import 'package:black_market/app/core/constants/app_colors.dart';
import 'package:black_market/app/core/constants/app_strings.dart';
import 'package:black_market/app/core/plugin/plugin_media_que.dart';
import 'package:black_market/app/core/widgets/custom_app_bar.dart';
import 'package:black_market/app/core/widgets/state_button.dart';
import 'package:black_market/app/modules/password/insert_otp/insert_otp%20controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:otp_timer_button/otp_timer_button.dart';

class InsertOtpView extends GetView<InsertOtpController> {
  const InsertOtpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackNormalHover,
      appBar: CustomAppBar(
        text: AppStrings.resetPassword,
        onTap: () => controller.goToLogin(),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(context.screenWidth * 0.01),
          children: [
            SizedBox(
              height: context.screenHeight * 0.05,
            ),
            SizedBox(
              height: context.screenHeight * 0.1,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.insertOtp,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: context.screenHeight * 0.04,
                ),
                Text(
                  AppStrings.weSendOtp,
                  style: TextStyle(
                    color: AppColors.yellowLightHover,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: context.screenHeight * 0.01,
                ),
                Text(
                  AppStrings.emailFake,
                  style: TextStyle(
                    color: AppColors.yellowNormal,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: context.screenHeight * 0.05,
            ),
            OtpTextField(
              fieldWidth: 65,
              numberOfFields: 4,
              showFieldAsBox: true,
              margin: const EdgeInsets.all(12),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderWidth: 0,
              enabledBorderColor: AppColors.gray,
              filled: true,
              cursorColor: AppColors.yellowDarker,
              focusedBorderColor: AppColors.yellowNormal,
              borderColor: AppColors.yellowLight,
              textStyle: TextStyle(
                color: AppColors.blackLightHover,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              fillColor: AppColors.gray,
              //runs when a code is typed in
              onCodeChanged: (String code) {
                //handle validation or checks here if necessary
              },
              //runs when every textfield is filled
              onSubmit: (String verificationCode) {},
            ),
            SizedBox(
              height: context.screenHeight * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OtpTimerButton(
                  backgroundColor: AppColors.gray,
                  height: 48,
                  onPressed: () {},
                  text: Text(
                    AppStrings.reSendOtp,
                    style: TextStyle(
                      color: AppColors.yellowNormal,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  duration: 3,
                ),
                Text(
                  AppStrings.dontReciveOtp,
                  style: TextStyle(
                    color: AppColors.lighterGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(context.screenWidth * 0.06),
        color: AppColors.blackNormalHover,
        child: StateButton(
          textColor: AppColors.blackDark,
          isLoading: false,
          text: AppStrings.complete,
          onPressed: () => controller.goToResetPassword(),
          buttonColor: AppColors.yellowNormal,
          radius: 14,
        ),
      ),
    );
  }
}
