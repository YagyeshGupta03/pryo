import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pryo_app/Constants/all_urls.dart';
import 'package:pryo_app/Controllers/global_controllers.dart';
import 'package:pryo_app/Controllers/user_dashboard_controller.dart';
import '../Helpers/http_helper.dart';
import '../Models/models.dart';

class CategoryController extends GetxController {
  RxList<Category> categoryList = <Category>[].obs;
  RxList<SubCategory> subCategoryList = <SubCategory>[].obs;
  RxList<SubCategory> allSubCategoryList = <SubCategory>[].obs;

  final UserDashboardController _userDashboardController =
      Get.put(UserDashboardController());

  //
  //
  //
  Future serviceCategory() async {
    final NetworkHelper networkHelper = NetworkHelper(url: getAllCategory);
    var reply = await networkHelper.postData({});

    if (reply['status'] == 1) {
      categoryList.clear();
      if(credentialController.word == 'en'){
        for (int i = 0; i < reply['data'].length; i++) {
          categoryList.add(
            Category(
              id: reply['data'][i]['id'],
              title: reply['data'][i]['title'],
              image: reply['data'][i]['image'],
            ),
          );
        }
      }
     else {
        for (int i = 0; i < reply['data'].length; i++) {
          categoryList.add(
            Category(
              id: reply['data'][i]['id'],
              title: reply['data'][i]['title_s'],
              image: reply['data'][i]['image'],
            ),
          );
        }
      }
    }
    update();
  }
  //
  //
  //
  //
  Future getSubCategoryForm(BuildContext context, categoryId) async {
    final NetworkHelper networkHelper =
        NetworkHelper(url: getSubCategoryByCategoryId);
    var reply = await networkHelper.postData({
      "category_id": categoryId,
    });
    subCategoryList.clear();
    if (reply['status'] == 1) {
      if(credentialController.word == 'en'){
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
      } else {
        for (int i = 0; i < reply['data'].length; i++) {
          subCategoryList.add(
            SubCategory(
              id: reply['data'][i]['id'],
              title: reply['data'][i]['name_s'],
              description: reply['data'][i]['description'],
              image: reply['data'][i]['image'],
            ),
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
  Future getAllSubCategory(BuildContext context) async {
    final NetworkHelper networkHelper = NetworkHelper(url: getAllSubCategories);
    var reply = await networkHelper.postData({});
    try {
      if (reply['status'] == 1) {
        allSubCategoryList.clear();
        if(credentialController.word == 'en'){
          for (int i = 0; i < reply['data'].length; i++) {
            allSubCategoryList.add(
              SubCategory(
                id: reply['data'][i]['id'],
                title: reply['data'][i]['name'],
                description: reply['data'][i]['description'],
                image: reply['data'][i]['image'],
              ),
            );
          }
        }
       else {
          for (int i = 0; i < reply['data'].length; i++) {
            allSubCategoryList.add(
              SubCategory(
                id: reply['data'][i]['id'],
                title: reply['data'][i]['name_s'],
                description: reply['data'][i]['description'],
                image: reply['data'][i]['image'],
              ),
            );
          }
        }
      }
    } catch (e) {
      print('Something went wrong in getting subcategories');
    }
  }
}
