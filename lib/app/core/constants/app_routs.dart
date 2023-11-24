import 'package:black_market/app/modules/home/home_view.dart';
import 'package:black_market/app/modules/login/login_binding.dart';
import 'package:black_market/app/modules/login/login_view.dart';
import 'package:black_market/app/modules/onBoarding/on_boarding_view.dart';
import 'package:black_market/app/modules/password/insert_otp/insert_otp%20controller_binding.dart';
import 'package:black_market/app/modules/password/insert_otp/insert_otp_view.dart';
import 'package:black_market/app/modules/password/send_otp/send_otp_binding.dart';
import 'package:black_market/app/modules/password/send_otp/send_otp_view.dart';
import 'package:black_market/app/modules/register/register_binding.dart';
import 'package:black_market/app/modules/register/register_view.dart';
import 'package:get/get.dart';

List<GetPage> approuts = [
  GetPage(
    name: "/onBoarding",
    page: () => const OnBoardingView(),
    //binding: WrapperBinding(),
  ),
  GetPage(
    name: "/login",
    page: () => const LoginView(),
    binding: LoginBinding(),
  ),
  GetPage(
    name: "/home",
    page: () => const HomeView(),
    //binding: (),
  ),
  GetPage(
    name: "/register",
    page: () => const RegisterView(),
    binding: RegisterBinding(),
  ),
  GetPage(
    name: "/send_otp",
    page: () => const SendOtpView(),
    binding: SendOtpBinding(),
  ),
  GetPage(
    name: "/insert",
    page: () => const InsertOtpView(),
    binding: InsertOtpBinding(),
  ),
];
