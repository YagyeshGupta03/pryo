import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Screens/UserMemberScreens/HomeScreens/homeScreen.dart';
import 'package:pryo_app/Screens/ac_repair_description.dart';
import '../Constants/all_urls.dart';
import '../Constants/theme_data.dart';
import '../Controllers/category_controller.dart';
import '../Controllers/user_dashboard_controller.dart';

class SubCategoryOptions extends StatefulWidget {
  const SubCategoryOptions({Key? key, required this.categoryName})
      : super(key: key);

  final String categoryName;

  @override
  State<SubCategoryOptions> createState() => _SubCategoryOptionsState();
}

class _SubCategoryOptionsState extends State<SubCategoryOptions> {
  final CategoryController _categoryController = Get.put(CategoryController());
  final UserDashboardController _userDashboardController =
      Get.put(UserDashboardController());
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Timer(Duration(milliseconds: 1000), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.to(() => const HomeScreen());
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Provider.of<ThemeProvider>(context)
                .currentTheme
                .iconTheme
                .color,
          ),
        ),
        title: Center(
          child: Text(
            widget.categoryName,
            style: Provider.of<ThemeProvider>(context)
                .currentTheme
                .textTheme
                .bodyMedium,
          ),
        ),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: _categoryController.subCategoryList.length,
          itemBuilder: (context, index) {
            return CustomTile(
              image:
                  '$subCategoryUrl${_categoryController.subCategoryList[index].image}',
              title: _categoryController.subCategoryList[index].title,
              description: _categoryController
                  .subCategoryList[index].description,
              onTap: () {
                _userDashboardController
                    .getSpBySubCat(
                        _categoryController.subCategoryList[index].id)
                    .whenComplete(
                      () => Get.to(
                        () => SubCategoryDescription(
                          subCatId:
                              _categoryController.subCategoryList[index].id,
                          title:
                              _categoryController.subCategoryList[index].title,
                          image:
                              '$subCategoryUrl${_categoryController.subCategoryList[index].image}',
                          description: _categoryController
                              .subCategoryList[index].description,
                        ),
                      ),
                    );
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => SubCategoryDescription(
                //       subCatId: _categoryController.subCategoryList[index].id,
                //       title: _categoryController.subCategoryList[index].title,
                //       image:
                //           '$subCategoryUrl${_categoryController.subCategoryList[index].image}',
                //       description: _categoryController
                //           .subCategoryList[index].description,
                //     ),
                //   ),
                // );
              },
            );
          },
        ),
      ),
    );
  }
}
//
//
//
//
//
class CustomTile extends StatelessWidget {
  const CustomTile({
    super.key,
    required this.image,
    required this.title,
    required this.onTap, required this.description,
  });

  final String image;
  final String title;
  final Function onTap;
  final String description;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Provider.of<ThemeProvider>(context).currentTheme.cardColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            image == ''
                ? Expanded(
                    flex: 0,
                    child: Container(
                      height: 115,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Provider.of<ThemeProvider>(context)
                                .currentTheme
                                .cardColor),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(11),
                          bottomLeft: Radius.circular(11),
                        ),
                        image: const DecorationImage(
                          image: AssetImage(
                              'assets/images/ac_repair/acCheckup.png'),
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    flex: 0,
                    child: Container(
                      height: 115,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Provider.of<ThemeProvider>(context)
                                .currentTheme
                                .cardColor),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(11),
                          bottomLeft: Radius.circular(11),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(image),
                        ),
                      ),
                    ),
                  ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(left: 10, top: 15, bottom: 11),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Provider.of<ThemeProvider>(context)
                              .currentTheme
                              .textTheme
                              .bodyLarge,
                        ),
                        Container(
                          width: 180,
                          child: Text(
                            description,
                            style: Provider.of<ThemeProvider>(context)
                                .currentTheme
                                .textTheme
                                .titleSmall,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 25),
                  ],
                ),
              ),
            ),
            // Align(
            //   alignment: Alignment.topRight,
            //   child: Padding(
            //     padding: const EdgeInsets.only(top: 5, right: 5),
            //     child: PopupMenuButton(
            //       color: whiteColor,
            //       itemBuilder: (context) => [],
            //       child: const Icon(
            //         Icons.more_horiz,
            //         color: blackColor,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
