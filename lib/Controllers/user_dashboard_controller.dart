import 'package:get/get.dart';
import 'package:pryo_app/Constants/all_urls.dart';
import 'package:pryo_app/Controllers/global_controllers.dart';
import 'package:pryo_app/Models/models.dart';
import '../Helpers/http_helper.dart';
import '../Screens/UserMemberScreens/USettingScreens/favorite_screen.dart';

class UserDashboardController extends GetxController {
  RxList<ServiceProviderModel> serviceByLatLngList =
      <ServiceProviderModel>[].obs;

  RxList<ServiceProviderModel> serviceByCityList1 =
      <ServiceProviderModel>[].obs;

  RxList<ServiceProviderModel> serviceByCityList2 =
      <ServiceProviderModel>[].obs;

  RxList<ServiceProviderModel> serviceByFavList = <ServiceProviderModel>[].obs;

  RxList<ServiceProviderModel> serviceByRatings = <ServiceProviderModel>[].obs;

  RxList<ServiceProviderModel> searchList = <ServiceProviderModel>[].obs;

  RxList<AdvertisementModel> adsList = <AdvertisementModel>[].obs;

  RxList<ServiceProviderModel> serviceBySubCatList =
      <ServiceProviderModel>[].obs;

  String userName = '';
  String userImage = '';
  String ratings = '';
  String review = '';
  bool loading = false;
  // String result = 'No search data available';
  RxBool icon = false.obs;

  //
  //
  //
  //Service provider by latLng
  Future serviceByLatLng() async {
    final NetworkHelper networkHelper =
        NetworkHelper(url: serviceProviderByLatLng);
    var reply = await networkHelper.postData({
      "latitude": locationController.latitude.value.toString(),
      "longitude": locationController.longitude.value.toString(),
    });
    if (reply['status'] == 1) {
      serviceByLatLngList.clear();
      for (int i = 0; i < reply['data'].length; i++) {
        serviceByLatLngList.add(
          ServiceProviderModel(
            id: reply['data'][i]['id'],
            title: reply['data'][i]['full_name'],
            profileImage: reply['data'][i]['profile_image'] ?? '',
            email: reply['data'][i]['email'],
            phone: reply['data'][i]['phone'],
            countryCode: reply['data'][i]['country_code']??'',
            categoryId: reply['data'][i]['category_id'],
            categoryName: reply['data'][i]['cat_name'] ?? '',
            ratings: reply['data'][i]['avg_ratings'] ?? '',
          ),
        );
      }
    }
    if (serviceByLatLngList.isEmpty) {
      loading = true;
    }
    update();
  }

//
  //
  //
  //
  //
  //Service provider by city and category
  Future serviceByCityAndCategory1() async {
    final NetworkHelper networkHelper =
        NetworkHelper(url: serviceProviderByCity);
    var reply = await networkHelper.postData({
      "city": userInfoController.city.value,
      "category_id": '1',
    });
    if (reply['status'] == 1) {
      serviceByCityList1.clear();
      for (int i = 0; i < reply['data'].length; i++) {
        serviceByCityList1.add(
          ServiceProviderModel(
            id: reply['data'][i]['id'],
            title: reply['data'][i]['full_name'],
            email: reply['data'][i]['email'],
            profileImage: reply['data'][i]['profile_image'] ?? "",
            phone: reply['data'][i]['phone'],
            countryCode: reply['data'][i]['country_code']??"",
            categoryId: reply['data'][i]['category_id'],
            categoryName: reply['data'][i]['cat_name'] ?? '',
            ratings: reply['data'][i]['avg_ratings'] ?? '',
          ),
        );
      }
    }
    update();
  }

//
  //
  //
  //
//
  Future serviceByCityAndCategory2() async {
    final NetworkHelper networkHelper =
        NetworkHelper(url: serviceProviderByCity);
    var reply = await networkHelper.postData({
      "city": userInfoController.city.value,
      "category_id": '2',
    });
    if (reply['status'] == 1) {
      serviceByCityList2.clear();
      for (int i = 0; i < reply['data'].length; i++) {
        serviceByCityList2.add(
          ServiceProviderModel(
            id: reply['data'][i]['id'],
            title: reply['data'][i]['full_name'],
            email: reply['data'][i]['email'],
            profileImage: reply['data'][i]['profile_image'] ?? "",
            phone: reply['data'][i]['phone'],
            countryCode: reply['data'][i]['country_code']??'',
            categoryId: reply['data'][i]['category_id'],
            categoryName: reply['data'][i]['cat_name'] ?? '',
            ratings: reply['data'][i]['avg_ratings'] ?? '',
          ),
        );
      }
    }
    update();
  }

  //
  //
  //
  //
  //
  Future serviceByRatingsAndCity() async {
    final NetworkHelper networkHelper =
        NetworkHelper(url: serviceProviderByRatings);
    var reply = await networkHelper.postData({
      "city": userInfoController.city.value,
    });
    if (reply['status'] == 1) {
      serviceByRatings.clear();
      for (int i = 0; i < reply['data'].length; i++) {
        serviceByRatings.add(
          ServiceProviderModel(
            id: reply['data'][i]['id'],
            title: reply['data'][i]['full_name'],
            email: reply['data'][i]['email'],
            profileImage: reply['data'][i]['profile_image'] ?? "",
            phone: reply['data'][i]['phone'],
            countryCode: reply['data'][i]['country_code']??'',
            categoryId: reply['data'][i]['category_id'],
            categoryName: reply['data'][i]['cat_name'] ?? '',
            ratings: reply['data'][i]['avg_ratings'] ?? '',
          ),
        );
      }
    }
    update();
  }

  //
  //
  //
  //
  //
  //
  //Service provider according to user favorite
  Future getUsersFavorite() async {
    final NetworkHelper networkHelper = NetworkHelper(url: getFavorite);
    var reply = await networkHelper.postData({
      "user_id": credentialController.id,
    });
    print(reply);
    serviceByFavList.clear();
    if (reply['status'] == 1) {
      for (int i = 0; i < reply['data'].length; i++) {
        serviceByFavList.add(
          ServiceProviderModel(
            id: reply['data'][i]['product_id'],
            title: reply['data'][i]['full_name'],
            email: reply['data'][i]['email'],
            profileImage: reply['data'][i]['profile_image'] ?? "",
            phone: reply['data'][i]['phone'],
            countryCode: reply['data'][i]['country_code']??"",
            categoryId: reply['data'][i]['category_id'],
            categoryName: reply['data'][i]['cat_name'] ?? '',
            ratings: reply['data'][i]['avg_ratings'] ?? '',
          ),
        );
      }
      update();
      // Get.to(() => const FavoriteScreen());
    } else {
      print('data is empty or null');
    }
  }

  //
  //
  //
  //
  //
  //
  //
  //Advertisements by admin to user
  Future getAdvertisements() async {
    final NetworkHelper networkHelper = NetworkHelper(url: getAds);
    var reply = await networkHelper.postData({});
    print(reply);

    adsList.clear();
      if (reply['status'] == 1) {
        adsList.clear();
        for (int i = 0; i < reply['data'].length; i++) {
          adsList.add(
            AdvertisementModel(
              id: reply['data'][i]['id'],
              image: reply['data'][i]['image'],
              link: reply['data'][i]['link'],
            ),
          );
        }
      }
      update();
  }

  //
  //
  //
  //
  //
  //
  Future getDashboardReviews() async {
    final NetworkHelper networkHelper = NetworkHelper(url: getAdminReview);
    var reply = await networkHelper.postData({});

    if (reply['status'] == 1) {
      userName = reply['data'][0]['full_name'];
      userImage = reply['data'][0]['profile_image'] ?? '';
      ratings = reply['data'][0]['rating'];
      review = reply['data'][0]['review'];
      update();
    }else {
      print('Something went wrong in dashboard reviews');
    }
  }

  //
  //
  //
  //
  //
  Future getSpBySubCat(subCatId) async {
    final NetworkHelper networkHelper =
        NetworkHelper(url: getServiceProviderBySubCatId);
    var reply = await networkHelper.postData({
      'sub_category_id': subCatId,
    });
    try {
      if (reply['status'] == 1) {
        serviceBySubCatList.clear();
        for (int i = 0; i < reply['data'].length; i++) {
          serviceBySubCatList.add(
            ServiceProviderModel(
              id: reply['data'][i]['id'],
              title: reply['data'][i]['full_name'],
              profileImage: reply['data'][i]['profile_image']??'',
              email: reply['data'][i]['email'],
              phone: reply['data'][i]['phone'],
              countryCode: reply['data'][i]['country_code'],
              categoryId: reply['data'][i]['category_id'],
              categoryName: reply['data'][i]['category_id'],
              ratings: reply['data'][i]['avg_ratings']??'',
            ),
          );
        }
      }
    } catch (e) {
      print('Something went wrong');
    }
  }

  //
  //
  //
  //
  //
  Future searchOnDashboard(search) async {
    final NetworkHelper networkHelper = NetworkHelper(url: searchBarApi);
    var reply = await networkHelper.postData({
      "search": search,
    });

    if (reply['status'] == 1) {
      for (int i = 0; i < reply['data'].length; i++) {
        searchList.add(
          ServiceProviderModel(
            id: reply['data'][i]['id'],
            title: reply['data'][i]['full_name'],
            email: reply['data'][i]['email'],
            profileImage: reply['data'][i]['profile_image'] ?? "",
            phone: reply['data'][i]['phone'],
            countryCode: reply['data'][i]['country_code'],
            categoryId: reply['data'][i]['category_id'],
            categoryName: reply['data'][i]['cat_name'] ?? '',
            ratings: reply['data'][i]['avg_ratings'] ?? '',
          ),
        );
      }
    }
    update();
  }

  //
  //
  //
  //
  //
  Future checkFavorite(productId) async {
    final NetworkHelper networkHelper = NetworkHelper(url: checkFav);
    var reply = await networkHelper.postData({
      "user_id": credentialController.id,
      "product_id": productId,
    });

    if (reply['status'] == true) {
      return true;
    } else if (reply['status'] == false) {
      return false;
    }
  }

  //
//
//
//
//
//
  Future favUpdate(sId) async {
    final NetworkHelper networkHelper = NetworkHelper(url: addFavorite);
    var reply = await networkHelper.postData({
      "user_id": credentialController.id,
      "product_id": sId,
    });
    if (reply['status'] == 1) {
      if (reply["message_eng"] == "Add Wishlist Successfully") {
        return true;
      } else if (reply["message_eng"] == "Wishlist Deleted Successfully") {
        return false;
      }

    } else {
      return false;
    }
  }
}
