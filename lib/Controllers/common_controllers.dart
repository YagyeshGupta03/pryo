import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:get/get.dart';
import 'package:pryo_app/Constants/all_urls.dart';
import 'package:pryo_app/Controllers/global_controllers.dart';
import 'package:pryo_app/Controllers/user_dashboard_controller.dart';
import 'package:pryo_app/Models/models.dart';
import 'package:pryo_app/Screens/Sp_screens/sp_settings.dart';
import 'package:pryo_app/Screens/UserMemberScreens/USettingScreens/uSetting_screen.dart';
import '../Helpers/http_helper.dart';
import '../generated/l10n.dart';

class BnbController extends GetxController {
  RxInt currentIndex = 0.obs;

  void changeIndex(int val) {
    currentIndex.value = val;
  }
}

//
//
//
//
//
class ThemeController extends GetxController {
  RxBool light = true.obs;

  void changeTheme(val) {
    light.value = val;
    update();
  }
}

//
//
//
//
//
class LoadingController extends GetxController {
  RxBool loading = false.obs;

  updateLoading(val) {
    loading.value = val;
    update();
  }
}

//
//
//
//
//
class UserInfoController extends GetxController {
  RxList<ReviewModel> reviewList = <ReviewModel>[].obs;

  //Main user info variables
  RxString fullName = ''.obs;
  RxString userName = ''.obs;
  RxString address = ''.obs;
  RxString email = ''.obs;
  RxString phone = ''.obs;
  RxString password = ''.obs;
  RxString categoryId = ''.obs;
  RxString about = ''.obs;
  RxString city = ''.obs;
  RxString categoryName = ''.obs;
  RxString subCategoryName = ''.obs;
  RxString workExperience = ''.obs;
  RxString averageRatings = ''.obs;
  RxString profileImage = ''.obs;
  RxList galleryImages = [].obs;
  RxString uPositiveRatings = ''.obs;
  RxString uTotalFiveRating = ''.obs;


  //Worker info variables
  RxString wId = ''.obs;
  RxString wFullName = ''.obs;
  RxString wUserName = ''.obs;
  RxString wAddress = ''.obs;
  RxString wEmail = ''.obs;
  RxString wPhone = ''.obs;
  RxString wPassword = ''.obs;
  RxString wCategoryId = ''.obs;
  RxString wSubCategoryId = ''.obs;
  RxString wCity = ''.obs;
  RxString wProfileImage = ''.obs;
  RxString wAverageRatings = ''.obs;
  RxList wGalleryImages = [].obs;
  RxString wCategoryName = ''.obs;
  RxString wSubCategoryName = ''.obs;
  RxString wWorkExperience = ''.obs;
  RxString wAbout = ''.obs;
  RxString wCountryCode = ''.obs;

  RxString positiveRatings = ''.obs;
  RxString totalFiveRating = ''.obs;

  Future getUserInfo() async {
    final NetworkHelper networkHelper = NetworkHelper(url: userInfo);
    var reply = await networkHelper.postData({
      "user_id": credentialController.id,
    });
    if (reply['status'] == 1) {
      fullName.value = reply['data']['full_name'];
      userName.value = reply['data']['user_name'] ?? '';
      email.value = reply['data']['email'];
      city.value = reply['data']['city'];
      address.value = reply['data']['address'];
      phone.value = reply['data']['phone'];
      workExperience.value = reply['data']['work_experience'] ?? '0';
      about.value = reply['data']['about'] ?? '';
      averageRatings.value = reply['data']['avg_ratings']??'';
      categoryId.value = reply['data']['category_id'] ?? '';
      profileImage.value = reply['data']['profile_image'] ?? '';
      password.value = reply['data']['password'];
      await firebase.createFirebaseChat(
          fullName, email, credentialController.id, phone);
      categoryName.value = reply['data']['cat_name'] ?? '';
      subCategoryName.value = reply['data']['sub_cat_name'] ?? '';
      String galleryImagesString = reply['data']['gallery_images'] ?? '';
      galleryImages.value = galleryImagesString.split(',');
      update();
    }
  }

//
  //
  //
  //
  Future logInUserInfo(userId) async {
    final NetworkHelper networkHelper = NetworkHelper(url: userInfo);
    var reply = await networkHelper.postData({
      "user_id": userId,
    });
    if (reply['status'] == 1) {
      fullName.value = reply['data']['full_name'];
      userName.value = reply['data']['user_name']??'';
      email.value = reply['data']['email'];
      city.value = reply['data']['city'];
      address.value = reply['data']['address'];
      workExperience.value = reply['data']['work_experience'] ?? '0';
      profileImage.value = reply['data']['profile_image'] ?? '';
      phone.value = reply['data']['phone'];
      password.value = reply['data']['password'];
      await firebase.createFirebaseChat(
          fullName, email, credentialController.id, phone);
      String galleryImagesString = reply['data']['gallery_images']??'';
      galleryImages.value = galleryImagesString.split(',');
      update();
    }
  }

//
  //
  //
  //
  Future getWorkerInfo(userId) async {
    final NetworkHelper networkHelper = NetworkHelper(url: userInfo);
    var reply = await networkHelper.postData({
      "user_id": userId,
    });
    if (reply['status'] == 1) {
      wId.value = reply['data']['id'];
      wFullName.value = reply['data']['full_name'];
      wUserName.value = reply['data']['user_name'] ?? '';
      wEmail.value = reply['data']['email'];
      wAddress.value = reply['data']['address'];
      wPhone.value = reply['data']['phone'];
      wWorkExperience.value = reply['data']['work_experience'] ?? '0';
      wProfileImage.value = reply['data']['profile_image'] ?? '';
      wSubCategoryId.value = reply['data']['sub_category_id'];
      wCategoryId.value = reply['data']['category_id'];
      wCategoryName.value = reply['data']['cat_name'] ?? '';
      wSubCategoryName.value = reply['data']['cat_name'] ?? '';
      wCountryCode.value = reply['data']['country_code'] ?? '';
      wAverageRatings.value = reply['data']['avg_ratings'] ?? '';
      wAbout.value = reply['data']['about'] ?? '';
      wCity.value = reply['data']['city'];
      String wGalleryImagesString = reply['data']['gallery_images'] ?? '';
      wGalleryImages.value = wGalleryImagesString.split(',');
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
  }

//
  //
  //
  //
  Future getReviewAndExperience(productId) async {
    final NetworkHelper networkHelper = NetworkHelper(url: reviewAndWork);
    var reply = await networkHelper.postData({
      "product_id": productId,
    });
    if (reply['status'] == 1) {
      // workExp.value = reply['data']['highest_review_user']??'0';
      positiveRatings.value = reply["highest_review_user"].toString() ?? '0';
      totalFiveRating.value = reply["five_star_user"].toString() ?? '0';
    } else {
      positiveRatings.value = '0';
      totalFiveRating.value = '0';
    }
  }

  //
  //
  //
  //
  //
  //
  Future getReviews(productId) async {
    final NetworkHelper networkHelper = NetworkHelper(url: getReviewList);
    var reply = await networkHelper.postData({
      "product_id": productId,
    });
    if (reply['status'] == 1) {
      reviewList.clear();
      for (int i = 0; i < reply['data'].length; i++) {
        reviewList.add(
          ReviewModel(
              image: reply['data'][i]['profile_image'] ?? '',
              name: reply['data'][i]['full_name'],
              review: reply['data'][i]['review'],
              rating: reply['data'][i]['rating']),
        );
      }
    }
  }
}

//
//
//
//
//
class FavoriteController extends GetxController {
  final UserDashboardController _userDashboardController =
      Get.put(UserDashboardController());

  Future favUpdate(sId) async {
    final NetworkHelper networkHelper = NetworkHelper(url: addFavorite);
    var reply = await networkHelper.postData({
      "user_id": credentialController.id,
      "product_id": sId,
    });
    if (reply['status'] == 1) {
      return true;
    } else {
      return false;
    }
  }
}

//
//
//
//
//
class AdminSupport extends GetxController {
  Future adminEnquiry(title, description, context) async {
    final NetworkHelper networkHelper = NetworkHelper(url: adminSupportApi);
    var reply = await networkHelper.postData({
      "user_id": credentialController.id,
      "subject": title,
      "comments": description,
    });

    AnimatedSnackBar.material(
      S.of(context).enquirySubmittedSuccessfully,
      type: AnimatedSnackBarType.success,
      mobilePositionSettings: const MobilePositionSettings(
        topOnAppearance: 50,
      ),
      mobileSnackBarPosition: MobileSnackBarPosition.top,
    ).show(context);
    if (credentialController.userType == '1') {
      Get.to(() => const USettingScreen());
    } else {
      Get.to(() => const SpSettings());
    }
  }
}

//
//
//
//
//

class OnboardController extends GetxController {

  String image1 = '';
  String image2 = '';
  String image3 = '';
  String title1 = '';
  String title2 = '';
  String title3 = '';
  String description1 = '';
  String description2 = '';
  String description3 = '';

  Future onboardUpdate() async {
    final NetworkHelper networkHelper = NetworkHelper(url: onboardingUrl);
    var reply = await networkHelper.postData({});
    print(reply);
    if (reply['status'] == 1) {
      image1 = reply['data'][0]['image'];
      image2 = reply['data'][1]['image'];
      image3 = reply['data'][2]['image'];
      title1 = reply['data'][0]['title'];
      title2 = reply['data'][1]['title'];
      title3 = reply['data'][2]['title'];
      description1 = reply['data'][0]['sub_title'];
      description2 = reply['data'][1]['sub_title'];
      description3 = reply['data'][2]['sub_title'];
      update();
    } else {
      return false;
    }
  }
}
