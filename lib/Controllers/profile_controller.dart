
// ignore_for_file: use_build_context_synchronously

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pryo_app/Constants/all_urls.dart';
import 'package:pryo_app/Controllers/text_controllers.dart';
import 'package:pryo_app/Models/models.dart';
import 'package:pryo_app/Screens/Profile_screens/user_profile_screen.dart';
import 'package:pryo_app/Screens/Sp_screens/sp_settings.dart';
import 'package:pryo_app/Screens/UserMemberScreens/USettingScreens/uSetting_screen.dart';
import 'package:pryo_app/Screens/worker_profile_screen.dart';
import '../Helpers/http_helper.dart';
import '../Screens/Sp_screens/SpProfileScreens/sp_profile_screen.dart';
import '../generated/l10n.dart';
import 'global_controllers.dart';

class ProfileController extends GetxController {
  final TextController _textController = Get.put(TextController());
  RxList<SubCategory> subCategoryList = <SubCategory>[].obs;

  //Profile updates
  Future userProfile(BuildContext context, fullName, city, address) async {
    final NetworkHelper networkHelper = NetworkHelper(url: userProfileUpdate);
    var reply = await networkHelper.postData({
      "user_id": credentialController.id,
      "user_type": credentialController.userType,
      "full_name": fullName,
      "address":address,
      "city":city,
    });
    try {
      if (reply['status'] == 1) {
        userInfoController.getUserInfo();
        Get.to(() => const UserProfileScreen());
        _textController.editFullName.value.clear();
        _textController.editMail.value.clear();
        _textController.editPhone.value.clear();
        _textController.editCity.value.clear();
        _textController.editAddress.value.clear();
      }
    } catch (e) {
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
  Future serviceProfile(BuildContext context, categoryId, subCategoryId, fullName, address, city, bio) async {
    final NetworkHelper networkHelper = NetworkHelper(url: spProfileUpdate);
    var reply = await networkHelper.postData({
      "user_id": credentialController.id,
      "user_type": credentialController.userType,
      "category_id": categoryId,
      "full_name": fullName,
      "address": address,
      "city": city,
      "sub_category_id": subCategoryId,
      "about": bio ?? '',
    });
    try {
      if (reply['status'] == 1) {
        userInfoController.getUserInfo();
        Get.to(() => const SpProfileScreen());
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
        _textController.editFullName.value.clear();
        _textController.editMail.value.clear();
        _textController.editPhone.value.clear();
        _textController.editCity.value.clear();
        _textController.editAddress.value.clear();
      }
    } catch (e) {
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
  ///
  //
  Future addReview(BuildContext context, productId, ratings, review) async {
    final NetworkHelper networkHelper = NetworkHelper(url: addReviewApi);
    var reply = await networkHelper.postData({
      "user_id": credentialController.id,
      "product_id": productId,
      "rating": ratings,
      "review": review,
    });

    try {
      if (reply['status'] == 1) {
        Get.to(()=> WorkerProfileScreen(userID: productId));
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
    }} catch (e) {
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
  //Image updates
  Future profileImageUpdate(BuildContext context, image) async {
    final NetworkHelper networkHelper = NetworkHelper(url: profileImage);
    var reply = await networkHelper.postMultiPartData(
        {"user_id": credentialController.id.toString()},
        [image] , "profile_image");
    userInfoController.getUserInfo();
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

  Future spGalleryUpdate(BuildContext context, image) async {
    final NetworkHelper networkHelper = NetworkHelper(url: galleryImages);
    var reply = await networkHelper.postMultiPartData(
        {"user_id": credentialController.id.toString()},
        image , "gallery_images[]");

    if(reply['status'] == 1){
      userInfoController.getUserInfo();
      Get.to(()=> const SpSettings());
      AnimatedSnackBar.material(
        S.of(context).imageUploadedSuccessfully,
        type: AnimatedSnackBarType.success,
        mobilePositionSettings: const MobilePositionSettings(
          topOnAppearance: 50,
        ),
        mobileSnackBarPosition: MobileSnackBarPosition.top,
      ).show(context);
    }
  }



  //Form update
  Future getSubCategoryForm(BuildContext context, categoryId) async {
    final NetworkHelper networkHelper = NetworkHelper(url: getSubCategoryByCategoryId);
    var reply = await networkHelper.postData({
      "category_id": categoryId,
    });
      subCategoryList.clear();
      if (reply['status'] == 1) {
        for (int i = 0; i < reply['data'].length; i++) {
          subCategoryList.add(
            SubCategory(
              id: reply['data'][i]['id'],
              title: reply['data'][i]['name'],
              description: reply['data'][i]['description'],
              image: reply['data'][i]['image'],
            ),
          );
      }
  }
}
//
//
//
//
//
  Future addWork(BuildContext context, work, certificate) async {
    final NetworkHelper networkHelper = NetworkHelper(url: updateWorkExp);
    var reply = await networkHelper.postMultiPartData(
      { "user_id": credentialController.id.toString(),
        "work_experience": work},
        [certificate], "experience_certificate"
    );

    try {
      if (reply['status'] == 1) {
        Get.to(()=> const SpSettings());
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
      }} catch (e) {
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
  Future updateLocation(BuildContext context) async {
    final NetworkHelper networkHelper = NetworkHelper(url: updateLocationApi);
    var reply = await networkHelper.postData({
      "user_id": credentialController.id,
      "latitude": locationController.latitude.value.toString(),
      "longitude": locationController.longitude.value.toString(),
    });
    try {
      if (reply['status'] == 1) {
        return true;
      }
    } catch (e) {
      return false;
    }
  }
  //
  //
  //
  //
  //
  Future changePassword(BuildContext context, oldPassword, newPassword, confirmPassword) async {
    final NetworkHelper networkHelper = NetworkHelper(url: changePasswordApi);
    var reply = await networkHelper.postData({
      "user_id": credentialController.id,
      "password": oldPassword,
      "new_password": newPassword,
      "confirm_password": confirmPassword,
    });

      if (reply['status'] == 1) {
        if(credentialController.userType == '1'){
          Get.to(()=> const USettingScreen());
        } else{
          Get.to(()=> const SpSettings());
        }
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
      else{
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
//
  String cReview = '';
  String cRating = '';

  Future checkLastReview(BuildContext context, productID) async {
    final NetworkHelper networkHelper = NetworkHelper(url: checkReview);
    var reply = await networkHelper.postData({
      "user_id": credentialController.id,
      "product_id": productID,
    });
    cReview = '';
    cRating = '';
      if (reply['status'] == true) {
        cReview = reply['data'][0]['review'].toString();
        cRating = reply['data'][0]['rating'].toString();
      } else {
        print('Some error faced');
      }
      update();
    }


}
