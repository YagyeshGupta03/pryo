import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Constants/sizes.dart';
import 'package:pryo_app/Constants/theme_data.dart';
import 'package:pryo_app/Screens/worker_profile_screen.dart';
import '../Controllers/global_controllers.dart';
import '../Controllers/user_dashboard_controller.dart';
import '../Widgets/dashboard_widgets.dart';
import '../generated/l10n.dart';

class SubCategoryDescription extends StatefulWidget {
  const SubCategoryDescription(
      {Key? key,
      required this.image,
      required this.title,
      required this.description,
      required this.subCatId})
      : super(key: key);

  final String image;
  final String subCatId;
  final String title;
  final String description;

  @override
  State<SubCategoryDescription> createState() => _SubCategoryDescriptionState();
}

class _SubCategoryDescriptionState extends State<SubCategoryDescription> {
  final UserDashboardController _userDashboardController =
      Get.put(UserDashboardController());
  bool filled1 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 605,
                  child: Column(
                    children: [
                      Container(
                        width: screenWidth(context),
                        height: 255,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(widget.image),
                              fit: BoxFit.fill),
                        ),
                      ),
                      SizedBox(
                        height: 350,
                        width: screenWidth(context),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 120, left: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.title,
                      style: Provider.of<ThemeProvider>(context)
                          .currentTheme
                          .textTheme
                          .headlineLarge,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: screenWidth(context),
                    height: 370,
                    margin:
                        const EdgeInsets.only(right: 20, left: 20, top: 220),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 25),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Provider.of<ThemeProvider>(context)
                            .currentTheme
                            .cardColor),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).description,
                            style: Provider.of<ThemeProvider>(context)
                                .currentTheme
                                .textTheme
                                .bodyMedium,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            widget.description,
                            style: Provider.of<ThemeProvider>(context)
                                .currentTheme
                                .textTheme
                                .labelMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).ourServiceProvider,
                        style: Provider.of<ThemeProvider>(context)
                            .currentTheme
                            .textTheme
                            .bodyMedium,
                      ),
                      TextButton(
                        onPressed: () {
                          // Get.to(()=> ServiceProviderScreen(heading: '', child: child))
                        },
                        child: Text(
                          S.of(context).viewAll,
                          style: Provider.of<ThemeProvider>(context)
                              .currentTheme
                              .textTheme
                              .bodySmall,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Obx(
                    () => _userDashboardController.serviceBySubCatList.length
                            .isEqual(0)
                        ? Text(
                            S
                                .of(context)
                                .noServiceProviderForThisCategoryInYourArea,
                            style: Provider.of<ThemeProvider>(context)
                                .currentTheme
                                .textTheme
                                .bodySmall,
                          )
                        : SizedBox(
                            height: 275,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _userDashboardController
                                          .serviceBySubCatList.length <
                                      5
                                  ? _userDashboardController
                                      .serviceBySubCatList.length
                                  : 5,
                              itemBuilder: (context, index) {
                                return ScrollCard(
                                  id: _userDashboardController
                                      .serviceBySubCatList[index].id,
                                  image: Container(
                                    height: 120,
                                    width: 160,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.blue,
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/profile.jpg'),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                  name: _userDashboardController
                                      .serviceBySubCatList[index].title,
                                  ratings: _userDashboardController
                                      .serviceBySubCatList[index].ratings,
                                  chat: () {
                                    firebase.createChatRoom(
                                        context,
                                        _userDashboardController
                                            .serviceBySubCatList[index].id,
                                        _userDashboardController
                                            .serviceBySubCatList[index].title,
                                        _userDashboardController
                                            .serviceBySubCatList[index].email,
                                        _userDashboardController
                                            .serviceBySubCatList[index].phone);
                                  },
                                  call: () {
                                    makePhoneCall(
                                        "${_userDashboardController.serviceBySubCatList[index].countryCode}${_userDashboardController.serviceBySubCatList[index].phone}");
                                  },
                                  profession: _userDashboardController
                                      .serviceBySubCatList[index].categoryName,
                                  onTap: () {
                                    Get.to(() => WorkerProfileScreen(
                                        userID: _userDashboardController
                                            .serviceBySubCatList[index].id));
                                  },
                                );
                              },
                            ),
                          ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
