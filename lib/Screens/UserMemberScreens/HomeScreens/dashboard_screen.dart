import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Constants/theme_data.dart';
import 'package:pryo_app/Controllers/user_dashboard_controller.dart';
import 'package:pryo_app/Screens/UserMemberScreens/HomeScreens/homeScreen.dart';
import 'package:pryo_app/Screens/UserMemberScreens/USettingScreens/uSetting_screen.dart';
import 'package:pryo_app/Widgets/dashboard_widgets.dart';
import '../../../Constants/all_urls.dart';
import '../../../Constants/colors.dart';
import '../../../Controllers/category_controller.dart';
import '../../../Controllers/global_controllers.dart';
import '../../../Controllers/notifications_controller.dart';
import '../../../generated/l10n.dart';
import '../../service_provider_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final UserDashboardController _userDashboardController =
      Get.put(UserDashboardController());
  final CategoryController _categoryController = Get.put(CategoryController());

  @override
  void initState() {
    super.initState();
    _categoryController.serviceCategory();
    _userDashboardController.serviceByLatLng();
    _userDashboardController.serviceByRatingsAndCity();
    _userDashboardController.serviceByCityAndCategory2();
    _userDashboardController.serviceByCityAndCategory1();
    _userDashboardController.getAdvertisements();
    // _categoryController.getAllSubCategory(context);
    // _userDashboardController.serviceByRatingsAndCity();
    _userDashboardController.getDashboardReviews();
    FCM().setNotifications(context);
    firebase.firebaseTokenUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Obx(
            () => CircleAvatar(
              radius: 32,
              backgroundColor: circleClr,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: userInfoController.profileImage.value == ''
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(500),
                        child: Image.asset(
                          'assets/images/profile.jpg',
                          fit: BoxFit.cover,
                          height: 45,
                          width: 45,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(500),
                        child: Image.network(
                          '$profileUrl${userInfoController.profileImage.value}',
                          fit: BoxFit.cover,
                          height: 45,
                          width: 45,
                        ),
                      ),
              ),
            ),
          ),
        ),
        title: ListTile(
          title: Obx(
            () => Text(
              userInfoController.city.value.toString(),
              style: Provider.of<ThemeProvider>(context)
                  .currentTheme
                  .textTheme
                  .displayMedium,
              maxLines: 1,
            ),
          ),
          subtitle: Obx(
            () => Text(
              userInfoController.fullName.value.toString(),
              style: Provider.of<ThemeProvider>(context)
                  .currentTheme
                  .textTheme
                  .titleSmall,
              maxLines: 1,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () {
                Get.to(() => const USettingScreen());
              },
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.menu,
                  color: Provider.of<ThemeProvider>(context)
                      .currentTheme
                      .focusColor,
                  size: 28,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              Container(
                height: 197,
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    color: Provider.of<ThemeProvider>(context)
                        .currentTheme
                        .primaryColor
                        .withOpacity(0.30)),
                child: Column(
                  children: [
                    Text(
                      S.of(context).whatWouldYouLikeToService,
                      style: Provider.of<ThemeProvider>(context)
                          .currentTheme
                          .textTheme
                          .titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const DashboardSearch(),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Categories(),
              const SizedBox(height: 20),
              const ServiceProvider(),
              const SizedBox(height: 20),
              const AcRepair(),
              const SizedBox(height: 20),
              const Plumber(),
              const SizedBox(height: 10),
              const AdContainer(),
              const SizedBox(height: 10),
              // const ServiceCategory(),
              // const SizedBox(height: 10),
              const TopServiceProvider(),
              const SizedBox(height: 40),
              const CustomerReview(),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchDashboard extends StatefulWidget {
  const SearchDashboard({Key? key}) : super(key: key);

  @override
  State<SearchDashboard> createState() => _SearchDashboardState();
}

class _SearchDashboardState extends State<SearchDashboard> {
  @override
  Widget build(BuildContext context) {
    final UserDashboardController _userDashboardController =
        Get.put(UserDashboardController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Get.to(() => const USettingScreen());
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Obx(
              () => CircleAvatar(
                radius: 32,
                backgroundColor: circleClr,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: userInfoController.profileImage.value == ''
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(500),
                          child: Image.asset(
                            'assets/images/profile.jpg',
                            fit: BoxFit.cover,
                            height: 45,
                            width: 45,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(500),
                          child: Image.network(
                            '$profileUrl${userInfoController.profileImage.value}',
                            fit: BoxFit.cover,
                            height: 45,
                            width: 45,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ),
        title: ListTile(
          title: Obx(
            () => Text(
              userInfoController.address.value.toString(),
              style: Provider.of<ThemeProvider>(context)
                  .currentTheme
                  .textTheme
                  .displaySmall,
              maxLines: 1,
            ),
          ),
          subtitle: Obx(
            () => Text(
              userInfoController.fullName.value.toString(),
              style: Provider.of<ThemeProvider>(context)
                  .currentTheme
                  .textTheme
                  .titleSmall,
              maxLines: 1,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.transparent,
              child: Icon(
                Icons.qr_code,
                color:
                    Provider.of<ThemeProvider>(context).currentTheme.focusColor,
                size: 28,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              Container(
                height: 197,
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    color: Provider.of<ThemeProvider>(context)
                        .currentTheme
                        .primaryColor
                        .withOpacity(0.30)),
                child: Column(
                  children: [
                    Text(
                      S.of(context).whatWouldYouLikeToService,
                      style: Provider.of<ThemeProvider>(context)
                          .currentTheme
                          .textTheme
                          .titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const DashboardSearch(),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          S.of(context).serviceProviders,
                          style: Provider.of<ThemeProvider>(context)
                              .currentTheme
                              .textTheme
                              .bodyLarge,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _userDashboardController.searchList.length.isEqual(0)
                          ? Column(
                              children: [
                                const SizedBox(height: 10),
                                Text(
                                  S.of(context).noSearchDataAvailable,
                                  style: Provider.of<ThemeProvider>(context)
                                      .currentTheme
                                      .textTheme
                                      .bodyLarge,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.to(() => const HomeScreen());
                                  },
                                  child: Text(
                                    S.of(context).goBack,
                                    style: const TextStyle(
                                        fontSize: 14, color: primaryColor),
                                  ),
                                ),
                              ],
                            )
                          : SizedBox(
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: 280,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 20,
                                ),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    _userDashboardController.searchList.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) =>
                                    ServiceProviders(
                                  countryCode: _userDashboardController
                                      .searchList[index].countryCode,
                                  image: _userDashboardController
                                      .searchList[index].profileImage,
                                  title: _userDashboardController
                                      .searchList[index].title,
                                  phone: _userDashboardController
                                      .searchList[index].phone,
                                  ratings: _userDashboardController
                                      .searchList[index].ratings,
                                  id: _userDashboardController
                                      .searchList[index].id,
                                  profession: _userDashboardController
                                      .searchList[index].categoryName,
                                  email: _userDashboardController
                                      .searchList[index].email,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// void _openDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Dialog Title'),
//         content: Text('This is a simple dialog.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text('Close'),
//           ),
//         ],
//       );
//     },
//   );
// }
