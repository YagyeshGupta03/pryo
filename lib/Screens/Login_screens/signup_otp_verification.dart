// ignore_for_file: use_build_context_synchronously

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Constants/colors.dart';
import 'package:pryo_app/Screens/Login_screens/Login_screen.dart';
import 'package:pryo_app/Screens/Profile_screens/user_profile_screen.dart';
import 'package:pryo_app/Widgets/common_widgets.dart';
import '../../Constants/sizes.dart';
import '../../Constants/theme_data.dart';
import '../../Controllers/Login_controller.dart';
import '../../Controllers/global_controllers.dart';
import '../../generated/l10n.dart';

class SignUpVerify extends StatefulWidget {
  const SignUpVerify(
      {Key? key,
      required this.fullName,
      required this.userName,
      required this.email,
      required this.phone,
      required this.password,
      required this.city,
      required this.address,
      required this.latitude,
      required this.longitude,
      required this.countryCode,
      required this.userType,
      required this.otp,
      required this.image,
      required this.time})
      : super(key: key);

  final String fullName;
  final String userName;
  final String email;
  final String phone;
  final String password;
  final String city;
  final String address;
  final String latitude;
  final String longitude;
  final String countryCode;
  final String userType;
  final String otp;
  final XFile image;
  final DateTime time;

  @override
  State<SignUpVerify> createState() => _SignUpVerifyState();
}

class _SignUpVerifyState extends State<SignUpVerify> {
  final _otp = TextEditingController();
  final LoginController _loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.to(() => const LoginScreen());
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Provider.of<ThemeProvider>(context)
                .currentTheme
                .iconTheme
                .color,
          ),
        ),
        title: Text(
          S.of(context).otp,
          style: Provider.of<ThemeProvider>(context)
              .currentTheme
              .textTheme
              .bodyMedium,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserFields(
                    text: S.of(context).enterOtp,
                    hintText: S.of(context).enterOtpSendToYourMail,
                    controller: _otp,
                    enable: true,
                    fieldLabel: 'number',
                    keyboard: TextInputType.number),
                const SizedBox(height: 20),
                Text(
                  S.of(context).enterOtpSendToYourMailToRegisterSuccessfully,
                  style: const TextStyle(color: primaryColor, fontSize: 13),
                ),
                const SizedBox(height: 20),
                LoginButton(
                    onTap: () async {
                      await loadingController.updateLoading(true);
                      await Future.delayed(const Duration(milliseconds: 1500), () {
                      });
                      if (_otp.text.isNotEmpty) {
                        if (DateTime.now().isBefore(
                          widget.time.add(
                            const Duration(minutes: 20),
                          ),
                        )) {
                          if (_otp.text == widget.otp) {

                          } else {
                            AnimatedSnackBar.material(
                              S.of(context).invalidOtp,
                              type: AnimatedSnackBarType.error,
                              mobilePositionSettings:
                                  const MobilePositionSettings(
                                topOnAppearance: 50,
                              ),
                              mobileSnackBarPosition:
                                  MobileSnackBarPosition.top,
                            ).show(context);
                            loadingController.updateLoading(false);
                          }
                        } else {
                          AnimatedSnackBar.material(
                            S.of(context).otpExpired,
                            type: AnimatedSnackBarType.error,
                            mobilePositionSettings:
                                const MobilePositionSettings(
                              topOnAppearance: 50,
                            ),
                            mobileSnackBarPosition: MobileSnackBarPosition.top,
                          ).show(context);
                          loadingController.updateLoading(false);
                        }
                      } else {
                        AnimatedSnackBar.material(
                          S.of(context).fieldIsEmpty,
                          type: AnimatedSnackBarType.error,
                          mobilePositionSettings: const MobilePositionSettings(
                            topOnAppearance: 50,
                          ),
                          mobileSnackBarPosition: MobileSnackBarPosition.top,
                        ).show(context);
                        loadingController.updateLoading(false);
                      }
                    },
                    title: S.of(context).verifyOtp,
                    txtColor: Colors.white,
                    btnColor: primaryColor)
              ],
            ),
          ),
          Obx(
                () => loadingController.loading.value
                ? Center(
              child: Container(
                height: screenHeight(context),
                width: screenWidth(context),
                color: Colors.black12,
                child: LoadingAnimationWidget.threeArchedCircle(
                  color: primaryColor,
                  size: 50,
                ),
              ),
            )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}

//
//
//
//
//
//
//
class UserSignUpVerify extends StatefulWidget {
  const UserSignUpVerify(
      {Key? key,
      required this.fullName,
      required this.userName,
      required this.email,
      required this.phone,
      required this.password,
      required this.city,
      required this.address,
      required this.latitude,
      required this.longitude,
      required this.countryCode,
      required this.userType,
      required this.otp,
      required this.time})
      : super(key: key);

  final String fullName;
  final String userName;
  final String email;
  final String phone;
  final String password;
  final String city;
  final String address;
  final String latitude;
  final String longitude;
  final String countryCode;
  final String userType;
  final String otp;
  final DateTime time;

  @override
  State<UserSignUpVerify> createState() => _UserSignUpVerifyState();
}

class _UserSignUpVerifyState extends State<UserSignUpVerify> {
  @override
  Widget build(BuildContext context) {
    final _otp = TextEditingController();
    final LoginController _loginController = Get.put(LoginController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.to(() => const LoginScreen());
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Provider.of<ThemeProvider>(context)
                .currentTheme
                .iconTheme
                .color,
          ),
        ),
        title: Text(
          S.of(context).otp,
          style: Provider.of<ThemeProvider>(context)
              .currentTheme
              .textTheme
              .bodyMedium,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserFields(
                    text: S.of(context).enterOtp,
                    hintText: S.of(context).enterOtpSendToYourMail,
                    controller: _otp,
                    enable: true,
                    fieldLabel: 'number',
                    keyboard: TextInputType.number),
                const SizedBox(height: 20),
                Text(
                  S.of(context).enterOtpSendToYourMailToRegisterSuccessfully,
                  style: const TextStyle(color: primaryColor, fontSize: 13),
                ),
                const SizedBox(height: 20),
                LoginButton(
                    onTap: () async {
                      await loadingController.updateLoading(true);
                      if (_otp.text.isNotEmpty) {
                        if (DateTime.now().isBefore(
                          widget.time.add(
                            const Duration(minutes: 20),
                          ),
                        )) {
                          if (_otp.text == widget.otp) {

                          } else {
                            AnimatedSnackBar.material(
                              S.of(context).invalidOtp,
                              type: AnimatedSnackBarType.error,
                              mobilePositionSettings:
                                  const MobilePositionSettings(
                                topOnAppearance: 50,
                              ),
                              mobileSnackBarPosition:
                                  MobileSnackBarPosition.top,
                            ).show(context);
                            loadingController.updateLoading(false);
                          }
                        } else {
                          AnimatedSnackBar.material(
                            S.of(context).otpExpired,
                            type: AnimatedSnackBarType.error,
                            mobilePositionSettings:
                                const MobilePositionSettings(
                              topOnAppearance: 50,
                            ),
                            mobileSnackBarPosition: MobileSnackBarPosition.top,
                          ).show(context);
                          loadingController.updateLoading(false);
                        }
                      } else {
                        AnimatedSnackBar.material(
                          S.of(context).fieldIsEmpty,
                          type: AnimatedSnackBarType.error,
                          mobilePositionSettings: const MobilePositionSettings(
                            topOnAppearance: 50,
                          ),
                          mobileSnackBarPosition: MobileSnackBarPosition.top,
                        ).show(context);
                        loadingController.updateLoading(false);
                      }
                    },
                    title: S.of(context).verifyOtp,
                    txtColor: Colors.white,
                    btnColor: primaryColor),
              ],
            ),
          ),
          Obx(
            () => loadingController.loading.value
                ? Center(
                    child: Container(
                      height: screenHeight(context),
                      width: screenWidth(context),
                      color: Colors.black12,
                      child: LoadingAnimationWidget.threeArchedCircle(
                        color: primaryColor,
                        size: 50,
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
