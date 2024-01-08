// ignore_for_file: use_build_context_synchronously

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pryo_app/Models/UserModel.dart';
import 'package:pryo_app/Screens/IntroScreens/new_password_screen.dart';
import 'package:pryo_app/Screens/IntroScreens/otp_verification_screen.dart';
import 'package:pryo_app/Screens/Login_screens/Login_screen.dart';
import 'package:pryo_app/Screens/Sp_screens/sp_dashboard.dart';
import '../Constants/all_urls.dart';
import '../Helpers/http_helper.dart';
import '../Screens/Login_screens/signup_otp_verification.dart';
import '../Screens/UserMemberScreens/HomeScreens/homeScreen.dart';
import '../generated/l10n.dart';
import 'global_controllers.dart';

class LoginController extends GetxController {
  RxString otp = ''.obs;
  RxString title = ''.obs;
  RxString description = ''.obs;
  RxString pTitle = ''.obs;
  RxString pDescription = ''.obs;

  Future signUp(
      BuildContext context,
      fullName,
      userName,
      email,
      phone,
      password,
      city,
      address,
      countryCode,
      usertype,
      id) async {
    await loadingController.updateLoading(true);
    final NetworkHelper networkHelper = NetworkHelper(url: signupUrl);
    var reply = await networkHelper.postMultiPartData(
      {
        "full_name": fullName,
        "user_name": userName,
        "email": email,
        "phone": phone,
        "password": password,
        "address": address,
        "city": city,
        "latitude": locationController.latitude.value.toString(),
        "longitude": locationController.longitude.value.toString(),
        "country_code": countryCode,
        "user_type": usertype
      },
      [id],
      "govt_issued_id",

      // "experience_certificate": experienceCertificate,
    );
    if (reply['status'] == 1) {
      bool done = await firebase.firebaseSignUp(email, password, context);
      if (done) {
        if (credentialController.word == 'en') {
          AnimatedSnackBar.material(
            '${reply['message_eng']}',
            type: AnimatedSnackBarType.success,
            mobilePositionSettings: const MobilePositionSettings(
              topOnAppearance: 50,
            ),
            mobileSnackBarPosition: MobileSnackBarPosition.top,
          ).show(context);
          loadingController.updateLoading(false);
        }
        else {
          AnimatedSnackBar.material(
            '${reply['message_sv']}',
            type: AnimatedSnackBarType.success,
            mobilePositionSettings: const MobilePositionSettings(
              topOnAppearance: 50,
            ),
            mobileSnackBarPosition: MobileSnackBarPosition.top,
          ).show(context);
          loadingController.updateLoading(false);
        }
        loadingController.updateLoading(false);
        Get.offAll(() => const LoginScreen());
      } else {
        loadingController.updateLoading(false);
      }
    } else {
      if (credentialController.word == 'en') {
        AnimatedSnackBar.material(
          '${reply['message_eng']}',
          type: AnimatedSnackBarType.error,
          mobilePositionSettings: const MobilePositionSettings(
            topOnAppearance: 50,
          ),
          mobileSnackBarPosition: MobileSnackBarPosition.top,
        ).show(context);
        loadingController.updateLoading(false);
      }
      else {
        AnimatedSnackBar.material(
          '${reply['message_sv']}',
          type: AnimatedSnackBarType.error,
          mobilePositionSettings: const MobilePositionSettings(
            topOnAppearance: 50,
          ),
          mobileSnackBarPosition: MobileSnackBarPosition.top,
        ).show(context);
        loadingController.updateLoading(false);
      }
      loadingController.updateLoading(false);
    }
    loadingController.updateLoading(false);
  }

  //
  //
  //
  //
  //
  Future userSignUp(
      BuildContext context,
      fullName,
      userName,
      email,
      phone,
      password,
      city,
      address,
      countryCode,
      usertype) async {
    await loadingController.updateLoading(true);
    final NetworkHelper networkHelper = NetworkHelper(url: signupUrl);
    var reply = await networkHelper.postData({
      "full_name": fullName,
      "user_name": userName,
      "email": email,
      "phone": phone,
      "password": password,
      "address": address,
      "city": city,
      "latitude": locationController.latitude.value.toString(),
      "longitude": locationController.longitude.value.toString(),
      "country_code": countryCode,
      "user_type": usertype
    });

      if (reply['status'] == 1) {
        bool done = await firebase.firebaseSignUp(email, password, context);
        if (done) {
          if(credentialController.word == 'en'){
            AnimatedSnackBar.material(
              '${reply['message_eng']}',
              type: AnimatedSnackBarType.success,
              mobilePositionSettings: const MobilePositionSettings(
                topOnAppearance: 50,
              ),
              mobileSnackBarPosition: MobileSnackBarPosition.top,
            ).show(context);
          }
         else {
            AnimatedSnackBar.material(
              '${reply['message_sv']}',
              type: AnimatedSnackBarType.success,
              mobilePositionSettings: const MobilePositionSettings(
                topOnAppearance: 50,
              ),
              mobileSnackBarPosition: MobileSnackBarPosition.top,
            ).show(context);
          }
          loadingController.updateLoading(false);
          Get.offAll(() => const LoginScreen());
        } else {
          loadingController.updateLoading(false);
        }
      } else {
        if(credentialController.word == 'en'){
          AnimatedSnackBar.material(
            '${reply['message_eng']}',
            type: AnimatedSnackBarType.error,
            mobilePositionSettings: const MobilePositionSettings(
              topOnAppearance: 50,
            ),
            mobileSnackBarPosition: MobileSnackBarPosition.top,
          ).show(context);
        }
        else {
          AnimatedSnackBar.material(
            '${reply['message_sv']}',
            type: AnimatedSnackBarType.error,
            mobilePositionSettings: const MobilePositionSettings(
              topOnAppearance: 50,
            ),
            mobileSnackBarPosition: MobileSnackBarPosition.top,
          ).show(context);
        }
        loadingController.updateLoading(false);
      }
    loadingController.updateLoading(false);
  }

  //
  //
  //
  //
  //
  Future<UserModel?> logInMail(BuildContext context, email, password) async {
    loadingController.updateLoading(true);
    final NetworkHelper networkHelper = NetworkHelper(url: emailLoginUrl);
    var reply = await networkHelper.postData({
      "email": email,
      "password": password,
    });

    if (reply['status'] == 1) {
      loadingController.updateLoading(true);
      bool done = await firebase.firebaseSignIn(email, password, context);
      if (done) {
        credentialController.setData(
          reply['data']['id'],
          reply['data']['user_type'],
        );
        userInfoController.logInUserInfo(reply['data']['id'].toString());
        if (reply['data']['user_type'] == '1') {
          await Future.delayed(const Duration(milliseconds: 1000), () {
            loadingController.updateLoading(false);
            Get.offAll(() => const HomeScreen());
          });
        } else {
          await Future.delayed(const Duration(milliseconds: 1000), () {
            loadingController.updateLoading(false);
            Get.offAll(
              () => SpDashboardScreen(
                userID: reply['data']['id'],
              ),
            );
          });
        }
      }
      // return UserModel.fromJson(reply);
    } else {
      print(reply);
      loadingController.updateLoading(false);
      if (credentialController.word == 'en') {
        AnimatedSnackBar.material(
          '${reply['message_eng']}',
          type: AnimatedSnackBarType.error,
          mobilePositionSettings: const MobilePositionSettings(
            topOnAppearance: 50,
          ),
          mobileSnackBarPosition: MobileSnackBarPosition.top,
        ).show(context);
      } else {
        AnimatedSnackBar.material(
          '${reply['message_sv']}',
          type: AnimatedSnackBarType.error,
          mobilePositionSettings: const MobilePositionSettings(
            topOnAppearance: 50,
          ),
          mobileSnackBarPosition: MobileSnackBarPosition.top,
        ).show(context);
      }
    }
    loadingController.updateLoading(false);
  }

  //
  //
  //
  //
  //
  //////////Currently working function
  // Future<UserModel?> logInPhone(BuildContext context, phone) async {
  //   loadingController.updateLoading(true);
  //   final NetworkHelper networkHelper = NetworkHelper(url: phoneLoginUrl);
  //   var reply = await networkHelper.postData({
  //     "phone": phone,
  //   });
  //
  //   if (reply['status'] == 1) {
  //     loadingController.updateLoading(true);
  //     bool done = await firebase.firebaseSignIn(
  //         reply['status']['email'], reply['status']['password'], context);
  //     if (done) {
  //       credentialController.setData(
  //         reply['data']['id'],
  //         reply['data']['user_type'],
  //       );
  //       Get.to(
  //         () => OtpScreen(
  //           otp: '${reply["otp"]}',
  //           id: '${reply['data']['id']}',
  //           userType: '${reply['data']['user_type']}',
  //         ),
  //       );
  //     } else {
  //       AnimatedSnackBar.material(
  //         '${reply['message']}',
  //         type: AnimatedSnackBarType.error,
  //         mobilePositionSettings: const MobilePositionSettings(
  //           topOnAppearance: 50,
  //         ),
  //         mobileSnackBarPosition: MobileSnackBarPosition.top,
  //       ).show(context);
  //     }
  //     loadingController.updateLoading(false);
  //   }
  //   // Future logInPhone(BuildContext context, phone) async {
  //   //   final NetworkHelper networkHelper = NetworkHelper(url: phoneLoginUrl);
  //   //   var reply = await networkHelper.postData({
  //   //     "phone": phone,
  //   //   });
  //   //
  //   //   try {
  //   //     if (reply['status'] == 1) {
  //   //       Get.to(
  //   //         () => OtpScreen(
  //   //           otp: '${reply["otp"]}',
  //   //           userType: '${reply['data']['user_type']}',
  //   //         ),
  //   //       );
  //   //     } else {
  //   //       AnimatedSnackBar.material(
  //   //         '${reply['message']}',
  //   //         type: AnimatedSnackBarType.error,
  //   //         mobilePositionSettings: const MobilePositionSettings(
  //   //           topOnAppearance: 50,
  //   //         ),
  //   //         mobileSnackBarPosition: MobileSnackBarPosition.top,
  //   //       ).show(context);
  //   //     }
  //   //   } catch (e) {}
  //   // }
  //   //
  //   //
  //   //
  //   //
  //   //
  //   // Future forgotPassword(BuildContext context, email) async {
  //   //   final NetworkHelper networkHelper = NetworkHelper(url: forgotPasswordApi);
  //   //   var reply = await networkHelper.postData({
  //   //     "email": email,
  //   //   });
  //   //
  //   //   try {
  //   //     if (reply['status'] == 1) {
  //   //       Get.to(() => const LoginScreen());
  //   //       AnimatedSnackBar.material(
  //   //         'New password sent to your mail',
  //   //         type: AnimatedSnackBarType.success,
  //   //         mobilePositionSettings: const MobilePositionSettings(
  //   //           topOnAppearance: 50,
  //   //         ),
  //   //         mobileSnackBarPosition: MobileSnackBarPosition.top,
  //   //       ).show(context);
  //   //     } else {
  //   //       AnimatedSnackBar.material(
  //   //         '${reply['message']}',
  //   //         type: AnimatedSnackBarType.error,
  //   //         mobilePositionSettings: const MobilePositionSettings(
  //   //           topOnAppearance: 50,
  //   //         ),
  //   //         mobileSnackBarPosition: MobileSnackBarPosition.top,
  //   //       ).show(context);
  //   //     }
  //   //   } catch (e) {}
  //   // }
  // }

  //
  //
  //
  //
  //
  //
  // Future termsCondition() async {
  //   final NetworkHelper networkHelper = NetworkHelper(url: termsApi);
  //   var reply = await networkHelper.postData({});
  //
  //   if (reply['status'] == 1) {
  //     if(credentialController.word == 'en'){
  //       title.value = reply['data']['title'];
  //       description.value = reply['data']['description'];
  //       update();
  //     }
  //    else{
  //       title.value = reply['data']['title_s'];
  //       description.value = reply['data']['description_s'];
  //       update();
  //     }
  //   }
  // }
  //


  // Future privacyPolicy() async {
  //   final NetworkHelper networkHelper = NetworkHelper(url: privacy);
  //   var reply = await networkHelper.getData();
  //   if (reply['status'] == 1) {
  //     if(credentialController.word == 'en'){
  //       pTitle.value = reply['data']['title'];
  //       pDescription.value = reply['data']['description'];
  //       update();
  //     } else {
  //       pTitle.value = reply['data']['title_s'];
  //       pDescription.value = reply['data']['description_s'];
  //       update();
  //     }
  //   }
  // }

  //
  //
  //
  //
  //
  Future forgotPassword(BuildContext context, email) async {
    final NetworkHelper networkHelper = NetworkHelper(url: sendOTP);
    var reply = await networkHelper.postData({
      "email": email,
    });

    print(reply);

    if (reply['status'] == 1) {
      Get.to(() => OtpVerification(
            mail: email,
            oldPassword: reply['old_password'].toString(),
          ));
      AnimatedSnackBar.material(
        S.of(context).anOtpIsSendToYourMail,
        type: AnimatedSnackBarType.success,
        mobilePositionSettings: const MobilePositionSettings(
          topOnAppearance: 50,
        ),
        mobileSnackBarPosition: MobileSnackBarPosition.top,
      ).show(context);
    } else {
      if(credentialController.word == 'en'){
        AnimatedSnackBar.material(
          '${reply['message_eng']}',
          type: AnimatedSnackBarType.success,
          mobilePositionSettings: const MobilePositionSettings(
            topOnAppearance: 50,
          ),
          mobileSnackBarPosition: MobileSnackBarPosition.top,
        ).show(context);
      } else {
        AnimatedSnackBar.material(
          '${reply['message_sv']}',
          type: AnimatedSnackBarType.success,
          mobilePositionSettings: const MobilePositionSettings(
            topOnAppearance: 50,
          ),
          mobileSnackBarPosition: MobileSnackBarPosition.top,
        ).show(context);
      }
    }
  }

  //
//
//
//
//
  Future otpVerification(BuildContext context, email, otp, oldPass) async {
    final NetworkHelper networkHelper = NetworkHelper(url: verifyOTP);
    var reply = await networkHelper.postData({
      "email": email,
      'otp': otp,
    });

    print(reply);

    if (reply['status'] == 1) {
      Get.to(() => NewPasswordScreen(
            mail: email,
            otP: otp,
            oldPassword: oldPass,
          ));
    } else {
      if(credentialController.word == 'en'){
        AnimatedSnackBar.material(
          '${reply['message_eng']}',
          type: AnimatedSnackBarType.success,
          mobilePositionSettings: const MobilePositionSettings(
            topOnAppearance: 50,
          ),
          mobileSnackBarPosition: MobileSnackBarPosition.top,
        ).show(context);
      } else {
        AnimatedSnackBar.material(
          '${reply['message_sv']}',
          type: AnimatedSnackBarType.success,
          mobilePositionSettings: const MobilePositionSettings(
            topOnAppearance: 50,
          ),
          mobileSnackBarPosition: MobileSnackBarPosition.top,
        ).show(context);
      }
    }
  }

  //
  //
  //
  //
  //
  Future passwordEnter(
      BuildContext context, email, otp, password, oldPass) async {
    final NetworkHelper networkHelper = NetworkHelper(url: verifyOTP);
    var reply = await networkHelper
        .postData({"email": email, 'otp': otp, 'password': password});

    print(reply);

    if (reply['status'] == 1) {
      // bool done = await firebase.firebaseSignIn(email, oldPass, context);
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: oldPass)
          .then((value) async {
        await FirebaseAuth.instance.currentUser!
            .updatePassword(password)
            .then((value) async {
          await FirebaseAuth.instance.signOut();
          Get.to(() => const LoginScreen());
        }).onError((error, stackTrace) {
          AnimatedSnackBar.material(
            error.toString(),
            type: AnimatedSnackBarType.error,
            mobilePositionSettings: const MobilePositionSettings(
              topOnAppearance: 50,
            ),
            mobileSnackBarPosition: MobileSnackBarPosition.top,
          ).show(context);
        });
      });
    } else {
      if(credentialController.word == 'en'){
        AnimatedSnackBar.material(
          '${reply['message_eng']}',
          type: AnimatedSnackBarType.success,
          mobilePositionSettings: const MobilePositionSettings(
            topOnAppearance: 50,
          ),
          mobileSnackBarPosition: MobileSnackBarPosition.top,
        ).show(context);
      } else {
        AnimatedSnackBar.material(
          '${reply['message_sv']}',
          type: AnimatedSnackBarType.success,
          mobilePositionSettings: const MobilePositionSettings(
            topOnAppearance: 50,
          ),
          mobileSnackBarPosition: MobileSnackBarPosition.top,
        ).show(context);
      }
    }
  }

  //
  //
  //
  //
  //
  // Future sendOTPSignUp(BuildContext context, mail, name, usrName, contact, pass,
  //     cityy, addresss, country, type, timer) async {
  //   final NetworkHelper networkHelper = NetworkHelper(url: signUpOTP);
  //   var reply = await networkHelper.postData({
  //     "email": mail,
  //   });
  //
  //   print(reply);
  //
  //   if (reply['status'] == 1) {
  //     print('OTP send');
  //     Get.to(
  //       () => UserSignUpVerify(
  //         fullName: name,
  //         userName: usrName,
  //         email: mail,
  //         phone: contact,
  //         password: pass,
  //         city: cityy,
  //         address: addresss,
  //         latitude: locationController.latitude.value.toString(),
  //         longitude: locationController.latitude.value.toString(),
  //         countryCode: country,
  //         userType: type,
  //         otp: reply['otp'].toString(),
  //         time: timer,
  //       ),
  //     );
  //     AnimatedSnackBar.material(
  //       S.of(context).anOtpIsSendToYourMail,
  //       type: AnimatedSnackBarType.success,
  //       mobilePositionSettings: const MobilePositionSettings(
  //         topOnAppearance: 50,
  //       ),
  //       mobileSnackBarPosition: MobileSnackBarPosition.top,
  //     ).show(context);
  //   } else {
  //     if(credentialController.word == 'en'){
  //       AnimatedSnackBar.material(
  //         '${reply['message_eng']}',
  //         type: AnimatedSnackBarType.success,
  //         mobilePositionSettings: const MobilePositionSettings(
  //           topOnAppearance: 50,
  //         ),
  //         mobileSnackBarPosition: MobileSnackBarPosition.top,
  //       ).show(context);
  //     } else {
  //       AnimatedSnackBar.material(
  //         '${reply['message_sv']}',
  //         type: AnimatedSnackBarType.success,
  //         mobilePositionSettings: const MobilePositionSettings(
  //           topOnAppearance: 50,
  //         ),
  //         mobileSnackBarPosition: MobileSnackBarPosition.top,
  //       ).show(context);
  //     }
  //   }
  // }

//
  //
  //
  //
  //
  //
  // bool verified = false;
  // Future verifyOTPSignUp(BuildContext context, mail, otp) async {
  //   final NetworkHelper networkHelper = NetworkHelper(url: signUpOTPVerify);
  //   var reply = await networkHelper
  //       .postData({"email": mail, "email_varification_otp": otp});
  //
  //   print(reply);
  //
  //   if (reply['status'] == 1) {
  //     AnimatedSnackBar.material(
  //       S.of(context).anOtpIsSendToYourMail,
  //       type: AnimatedSnackBarType.success,
  //       mobilePositionSettings: const MobilePositionSettings(
  //         topOnAppearance: 50,
  //       ),
  //       mobileSnackBarPosition: MobileSnackBarPosition.top,
  //     ).show(context);
  //     verified = true;
  //   } else {
  //     if(credentialController.word == 'en'){
  //       AnimatedSnackBar.material(
  //         '${reply['message_eng']}',
  //         type: AnimatedSnackBarType.success,
  //         mobilePositionSettings: const MobilePositionSettings(
  //           topOnAppearance: 50,
  //         ),
  //         mobileSnackBarPosition: MobileSnackBarPosition.top,
  //       ).show(context);
  //     } else {
  //       AnimatedSnackBar.material(
  //         '${reply['message_sv']}',
  //         type: AnimatedSnackBarType.success,
  //         mobilePositionSettings: const MobilePositionSettings(
  //           topOnAppearance: 50,
  //         ),
  //         mobileSnackBarPosition: MobileSnackBarPosition.top,
  //       ).show(context);
  //     }
  //     verified = false;
  //   }
  // }

  //
//
//
//
//
//   Future sendSPSignUP(BuildContext context, mail, name, usrName, contact, pass,
//       cityy, addresss, country,  imageID, timer) async {
//     final NetworkHelper networkHelper = NetworkHelper(url: signUpOTP);
//     var reply = await networkHelper.postData({
//       "email": mail,
//     });
//
//     print(reply);
//
//     if (reply['status'] == 1) {
//       Get.to(
//         () => SignUpVerify(
//           fullName: name,
//           userName: usrName,
//           email: mail,
//           phone: contact,
//           password: pass,
//           city: cityy,
//           address: addresss,
//           latitude: locationController.latitude.value.toString(),
//           longitude: locationController.latitude.value.toString(),
//           countryCode: country,
//           userType: type,
//           otp: reply['otp'].toString(),
//           image: imageID,
//           time: timer,
//         ),
//       );
//       AnimatedSnackBar.material(
//         S.of(context).anOtpIsSendToYourMail,
//         type: AnimatedSnackBarType.success,
//         mobilePositionSettings: const MobilePositionSettings(
//           topOnAppearance: 50,
//         ),
//         mobileSnackBarPosition: MobileSnackBarPosition.top,
//       ).show(context);
//     } else {
//       if(credentialController.word == 'en'){
//         AnimatedSnackBar.material(
//           '${reply['message_eng']}',
//           type: AnimatedSnackBarType.success,
//           mobilePositionSettings: const MobilePositionSettings(
//             topOnAppearance: 50,
//           ),
//           mobileSnackBarPosition: MobileSnackBarPosition.top,
//         ).show(context);
//       } else {
//         AnimatedSnackBar.material(
//           '${reply['message_sv']}',
//           type: AnimatedSnackBarType.success,
//           mobilePositionSettings: const MobilePositionSettings(
//             topOnAppearance: 50,
//           ),
//           mobileSnackBarPosition: MobileSnackBarPosition.top,
//         ).show(context);
//       }
//     }
//   }
}
