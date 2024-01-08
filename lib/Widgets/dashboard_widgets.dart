import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Constants/all_urls.dart';
import 'package:pryo_app/Constants/sizes.dart';
import 'package:pryo_app/Constants/theme_data.dart';
import 'package:pryo_app/Controllers/global_controllers.dart';
import 'package:pryo_app/Controllers/location_controller.dart';
import 'package:pryo_app/Controllers/user_dashboard_controller.dart';
import 'package:pryo_app/Screens/UserMemberScreens/HomeScreens/dashboard_screen.dart';
import 'package:pryo_app/Screens/ac_repair_description.dart';
import 'package:pryo_app/Screens/service_provider_screen.dart';
import 'package:pryo_app/Screens/worker_profile_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Constants/colors.dart';
import '../Controllers/category_controller.dart';
import '../Controllers/text_controllers.dart';
import '../Screens/UserMemberScreens/HomeScreens/all_categories_screen.dart';
import '../Screens/sub_category_options.dart';
import '../generated/l10n.dart';

//Dashboard search
class DashboardSearch extends StatefulWidget {
  const DashboardSearch({
    super.key,
  });

  @override
  State<DashboardSearch> createState() => _DashboardSearchState();
}

class _DashboardSearchState extends State<DashboardSearch> {
  final TextController _textController = Get.put(TextController());
  final UserDashboardController _userDashboardController =
      Get.put(UserDashboardController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: const Color(0XFFFE6D0B).withOpacity(0.30)),
          color: Provider.of<ThemeProvider>(context)
              .currentTheme
              .scaffoldBackgroundColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 10,
          ),
          Icon(
            Icons.search,
            size: 26,
            color: Provider.of<ThemeProvider>(context)
                .currentTheme
                .iconTheme
                .color,
          ),
          Expanded(
            child: TextFormField(
              controller: _textController.searchBar.value,
              style: Provider.of<ThemeProvider>(context)
                  .currentTheme
                  .textTheme
                  .displaySmall,
              onFieldSubmitted: (val) {
                _userDashboardController.searchList.clear();
                _userDashboardController.searchOnDashboard(val);
                Get.to(() => const SearchDashboard());
              },
              decoration: InputDecoration(
                hintText: S.of(context).searchServiceCategories,
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                hoverColor: Colors.transparent,
                hintStyle: Provider.of<ThemeProvider>(context)
                    .currentTheme
                    .textTheme
                    .displaySmall,
                filled: true,
                fillColor: Colors.transparent,
                focusColor: Colors.transparent,
                focusedBorder: InputBorder.none,
                contentPadding:
                    const EdgeInsets.only(left: 15, right: 10, bottom: 0),
              ),
            ),
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
//Category
class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CategoryController _categoryController =
        Get.put(CategoryController());
    return Obx(
      () => SizedBox(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).categories,
                  style: Provider.of<ThemeProvider>(context)
                      .currentTheme
                      .textTheme
                      .bodyMedium,
                ),
                TextButton(
                  onPressed: () {
                    Get.to(() => const CategoriesScreen());
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
            _categoryController.categoryList.length < 5
                ? LoadingAnimationWidget.prograssiveDots(
                    color: primaryColor,
                    size: 70,
                  )
                : SizedBox(
                    height: 52,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            _categoryController.getSubCategoryForm(context,
                                _categoryController.categoryList[index].id);
                            Get.to(
                              () => SubCategoryOptions(
                                  categoryName: _categoryController
                                      .categoryList[index].title),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Provider.of<ThemeProvider>(context)
                                  .currentTheme
                                  .cardColor,
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.network(
                                      '$imageUrl${_categoryController.categoryList[index].image}',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  _categoryController.categoryList[index].title,
                                  style: Provider.of<ThemeProvider>(context)
                                      .currentTheme
                                      .textTheme
                                      .bodySmall,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
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
//
//Service provider
class ServiceProvider extends StatefulWidget {
  const ServiceProvider({Key? key}) : super(key: key);

  @override
  State<ServiceProvider> createState() => _ServiceProviderState();
}

class _ServiceProviderState extends State<ServiceProvider> {
  bool isLoading = false;
  bool filled1 = false;
  final UserDashboardController _userDashboardController =
      Get.put(UserDashboardController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).serviceProviderNearby,
                style: Provider.of<ThemeProvider>(context)
                    .currentTheme
                    .textTheme
                    .bodyMedium,
              ),
              TextButton(
                onPressed: () {
                  if (_userDashboardController.serviceByLatLngList.length
                      .isEqual(0)) {
                  } else {
                    Get.to(
                      () => ServiceProviderScreen(
                        heading: S.of(context).serviceProvidersNearby,
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
                          itemCount: _userDashboardController
                              .serviceByLatLngList.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) => ServiceProviders(
                            image: _userDashboardController
                                .serviceByLatLngList[index].profileImage,
                            countryCode: _userDashboardController
                                .serviceByLatLngList[index].countryCode,
                            title: _userDashboardController
                                .serviceByLatLngList[index].title,
                            phone: _userDashboardController
                                .serviceByLatLngList[index].phone,
                            ratings: _userDashboardController
                                .serviceByLatLngList[index].ratings,
                            id: _userDashboardController
                                .serviceByLatLngList[index].id,
                            profession: _userDashboardController
                                .serviceByLatLngList[index].categoryName,
                            email: _userDashboardController
                                .serviceByLatLngList[index].email,
                          ),
                        ),
                      ),
                    );
                  }
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
          GetBuilder<LocationController>(
            init: LocationController(),
            builder: (locationC) {
              return locationC.latitude.value.toString() == '0.0'
                  ? SizedBox(
                      height: 80,
                      child: Center(
                        child: Text(
                          S
                              .of(context)
                              .locationPermissionIsDeniedKindlyProvidePermissionForNearbyService,
                          style: Provider.of<ThemeProvider>(context)
                              .currentTheme
                              .textTheme
                              .bodySmall,
                        ),
                      ),
                    )
                  : _userDashboardController.serviceByLatLngList.length
                          .isEqual(0)
                      ? _userDashboardController.loading == true
                          ? Text(
                              S.of(context).noServiceProviderNearbyYou,
                              style: Provider.of<ThemeProvider>(context)
                                  .currentTheme
                                  .textTheme
                                  .titleSmall,
                            )
                          : isLoading
                              ? LoadingAnimationWidget.prograssiveDots(
                                  color: primaryColor,
                                  size: 70,
                                )
                              : Row(
                                  children: [
                                    Text(
                                      S
                                          .of(context)
                                          .kindlyAllowLocationPermission,
                                      style: Provider.of<ThemeProvider>(context)
                                          .currentTheme
                                          .textTheme
                                          .titleSmall,
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        _userDashboardController
                                            .serviceByLatLng();
                                      },
                                      child: Text(
                                        S.of(context).clickHere,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                      : SizedBox(
                          height: 275,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _userDashboardController
                                        .serviceByLatLngList.length <
                                    5
                                ? _userDashboardController
                                    .serviceByLatLngList.length
                                : 5,
                            itemBuilder: (context, index) {
                              return ScrollCard(
                                id: _userDashboardController
                                    .serviceByLatLngList[index].id,
                                image: _userDashboardController
                                            .serviceByLatLngList[index]
                                            .profileImage ==
                                        ''
                                    ? Container(
                                        height: 120,
                                        width: 160,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.transparent,
                                          image: const DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/profile.jpg'),
                                              fit: BoxFit.fill),
                                        ),
                                      )
                                    : Container(
                                        height: 120,
                                        width: 160,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.transparent,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  '$profileUrl${_userDashboardController.serviceByLatLngList[index].profileImage}',
                                                ),
                                                fit: BoxFit.fill)),
                                      ),
                                name: _userDashboardController
                                    .serviceByLatLngList[index].title,
                                ratings: _userDashboardController
                                    .serviceByLatLngList[index].ratings,
                                call: () {
                                  makePhoneCall(
                                      '${_userDashboardController.serviceByLatLngList[index].countryCode}${_userDashboardController.serviceByLatLngList[index].phone}');
                                },
                                chat: () {
                                  firebase.createChatRoom(
                                      context,
                                      _userDashboardController
                                          .serviceByLatLngList[index].id,
                                      _userDashboardController
                                          .serviceByLatLngList[index].title,
                                      _userDashboardController
                                          .serviceByLatLngList[index].email,
                                      _userDashboardController
                                          .serviceByLatLngList[index].phone);
                                },
                                profession: _userDashboardController
                                    .serviceByLatLngList[index].categoryName,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WorkerProfileScreen(
                                        userID: _userDashboardController
                                            .serviceByLatLngList[index].id,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        );
            },
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
//
//Ac repair
class AcRepair extends StatefulWidget {
  const AcRepair({Key? key}) : super(key: key);

  @override
  State<AcRepair> createState() => _AcRepairState();
}

void makePhoneCall(String phoneNumber) async {
  final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
  if (!await launchUrl(phoneUri)) {
    throw Exception('Could not launch phone call');
  }
}

class _AcRepairState extends State<AcRepair> {
  final UserDashboardController _userDashboardController =
      Get.put(UserDashboardController());
  final CategoryController _categoryController = Get.put(CategoryController());
  bool filled1 = false;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: screenWidth(context) / 2,
                  child: Text(
                    '${S.of(context).computerIn} ${userInfoController.city.value}',
                    style: Provider.of<ThemeProvider>(context)
                        .currentTheme
                        .textTheme
                        .bodyMedium,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (_userDashboardController.serviceByCityList1.length
                        .isEqual(0)) {
                    } else {
                      Get.to(
                        () => ServiceProviderScreen(
                          heading: S.of(context).computersService,
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
                            itemCount: _userDashboardController
                                .serviceByCityList1.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) => ServiceProviders(
                              countryCode: _userDashboardController
                                  .serviceByCityList1[index].countryCode,
                              image: _userDashboardController
                                  .serviceByCityList1[index].profileImage,
                              title: _userDashboardController
                                  .serviceByCityList1[index].title,
                              phone: _userDashboardController
                                  .serviceByCityList1[index].phone,
                              ratings: _userDashboardController
                                  .serviceByCityList1[index].ratings,
                              id: _userDashboardController
                                  .serviceByCityList1[index].id,
                              profession: _userDashboardController
                                  .serviceByCityList1[index].categoryName,
                              email: _userDashboardController
                                  .serviceByCityList1[index].email,
                            ),
                          ),
                        ),
                      );
                    }
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
            _userDashboardController.serviceByCityList1.length.isEqual(0)
                ? SizedBox(
                    height: 80,
                    child: Center(
                      child: Text(
                        S.of(context).noComputerServiceProviderInYourCity,
                        style: Provider.of<ThemeProvider>(context)
                            .currentTheme
                            .textTheme
                            .bodySmall,
                      ),
                    ),
                  )
                : SizedBox(
                    height: 275,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          _userDashboardController.serviceByCityList1.length < 5
                              ? _userDashboardController
                                  .serviceByCityList1.length
                              : 5,
                      itemBuilder: (context, index) {
                        return ScrollCard(
                          id: _userDashboardController
                              .serviceByCityList1[index].id,
                          image: _userDashboardController
                                      .serviceByCityList1[index].profileImage ==
                                  ''
                              ? Container(
                                  height: 120,
                                  width: 160,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.transparent,
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/profile.jpg'),
                                        fit: BoxFit.fill),
                                  ),
                                )
                              : Container(
                                  height: 120,
                                  width: 160,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.transparent,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            '$profileUrl${_userDashboardController.serviceByCityList1[index].profileImage}',
                                          ),
                                          fit: BoxFit.fill)),
                                ),
                          call: () {
                            makePhoneCall(
                                '${_userDashboardController.serviceByCityList1[index].countryCode}${_userDashboardController.serviceByCityList1[index].phone}');
                          },
                          chat: () {
                            firebase.createChatRoom(
                                context,
                                _userDashboardController
                                    .serviceByCityList1[index].id,
                                _userDashboardController
                                    .serviceByCityList1[index].title,
                                _userDashboardController
                                    .serviceByCityList1[index].email,
                                _userDashboardController
                                    .serviceByCityList1[index].phone);
                          },
                          ratings: _userDashboardController
                              .serviceByCityList1[index].ratings,
                          name: _userDashboardController
                              .serviceByCityList1[index].title,
                          profession: _userDashboardController
                              .serviceByCityList1[index].categoryName,
                          onTap: () {
                            Get.to(
                              () => WorkerProfileScreen(
                                  userID: _userDashboardController
                                      .serviceByCityList1[index].id),
                            );
                          },
                        );
                      },
                    ),
                  ),
          ],
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
//
////Plumber
class Plumber extends StatefulWidget {
  const Plumber({Key? key}) : super(key: key);

  @override
  State<Plumber> createState() => _PlumberState();
}

class _PlumberState extends State<Plumber> {
  final UserDashboardController _userDashboardController =
      Get.put(UserDashboardController());
  final CategoryController _categoryController = Get.put(CategoryController());
  bool filled1 = false;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: screenWidth(context) / 2,
                  child: Text(
                    '${S.of(context).contractorIn} ${userInfoController.city.value}',
                    style: Provider.of<ThemeProvider>(context)
                        .currentTheme
                        .textTheme
                        .bodyMedium,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (_userDashboardController.serviceByCityList2.length
                        .isEqual(0)) {
                    } else {
                      Get.to(
                        () => ServiceProviderScreen(
                          heading: S.of(context).contractorService,
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
                            itemCount: _userDashboardController
                                .serviceByCityList2.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) => ServiceProviders(
                              countryCode: _userDashboardController
                                  .serviceByCityList2[index].countryCode,
                              image: _userDashboardController
                                  .serviceByCityList2[index].profileImage,
                              title: _userDashboardController
                                  .serviceByCityList2[index].title,
                              phone: _userDashboardController
                                  .serviceByCityList2[index].phone,
                              ratings: _userDashboardController
                                  .serviceByCityList2[index].ratings,
                              id: _userDashboardController
                                  .serviceByCityList2[index].id,
                              profession: _userDashboardController
                                  .serviceByCityList2[index].categoryName,
                              email: _userDashboardController
                                  .serviceByCityList2[index].email,
                            ),
                          ),
                        ),
                      );
                    }
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
            _userDashboardController.serviceByCityList2.length.isEqual(0)
                ? SizedBox(
                    height: 80,
                    child: Center(
                      child: Text(
                        S.of(context).noContractorInYourCity,
                        style: Provider.of<ThemeProvider>(context)
                            .currentTheme
                            .textTheme
                            .bodySmall,
                      ),
                    ),
                  )
                : SizedBox(
                    height: 275,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          _userDashboardController.serviceByCityList2.length < 5
                              ? _userDashboardController
                                  .serviceByCityList2.length
                              : 5,
                      itemBuilder: (context, index) {
                        return ScrollCard(
                          id: _userDashboardController
                              .serviceByCityList2[index].id,
                          image: _userDashboardController
                                      .serviceByCityList2[index].profileImage ==
                                  ''
                              ? Container(
                                  height: 120,
                                  width: 160,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.transparent,
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/profile.jpg'),
                                        fit: BoxFit.fill),
                                  ),
                                )
                              : Container(
                                  height: 120,
                                  width: 160,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.transparent,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              '$profileUrl${_userDashboardController.serviceByCityList2[index].profileImage}'),
                                          fit: BoxFit.fill)),
                                ),
                          ratings: _userDashboardController
                              .serviceByCityList2[index].ratings,
                          call: () {
                            makePhoneCall(
                                "${_userDashboardController.serviceByCityList2[index].countryCode}${_userDashboardController.serviceByCityList2[index].phone}");
                          },
                          chat: () {
                            firebase.createChatRoom(
                                context,
                                _userDashboardController
                                    .serviceByCityList2[index].id,
                                _userDashboardController
                                    .serviceByCityList2[index].title,
                                _userDashboardController
                                    .serviceByCityList2[index].email,
                                _userDashboardController
                                    .serviceByCityList2[index].phone);
                          },
                          name: _userDashboardController
                              .serviceByCityList2[index].title,
                          profession: _userDashboardController
                              .serviceByCityList2[index].categoryName,
                          onTap: () {
                            Get.to(
                              () => WorkerProfileScreen(
                                  userID: _userDashboardController
                                      .serviceByCityList2[index].id),
                            );
                          },
                        );
                      },
                    ),
                  ),
          ],
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
//
//Ad Container
class AdContainer extends StatefulWidget {
  const AdContainer({Key? key}) : super(key: key);

  @override
  State<AdContainer> createState() => _AdContainerState();
}

class _AdContainerState extends State<AdContainer> {
  final UserDashboardController _userDashboardController =
      Get.put(UserDashboardController());

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _userDashboardController.adsList.length.isEqual(0)
          ? const SizedBox()
          : SizedBox(
              height: 210,
              child: CarouselSlider.builder(
                options: CarouselOptions(
                    height: 200,
                    scrollDirection: Axis.horizontal,
                    initialPage: 0,
                    viewportFraction: 1,
                    reverse: false,
                    enableInfiniteScroll: false,
                    autoPlay: false),
                itemCount: _userDashboardController.adsList.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        InkWell(
                  onTap: () {
                    _launchUrl(Uri.parse(_userDashboardController
                        .adsList[itemIndex].link
                        .toString()));
                  },
                  child: Container(
                    width: screenWidth(context),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(
                              '$advertisementUrl${_userDashboardController.adsList[itemIndex].image}'),
                          fit: BoxFit.fill),
                      color: Colors.transparent,
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
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
//Service category
class ServiceCategory extends StatefulWidget {
  const ServiceCategory({Key? key}) : super(key: key);

  @override
  State<ServiceCategory> createState() => _ServiceCategoryState();
}

class _ServiceCategoryState extends State<ServiceCategory> {
  final CategoryController _categoryController = Get.put(CategoryController());
  final UserDashboardController _userDashboardController =
      Get.put(UserDashboardController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                S.of(context).serviceCategory,
                style: Provider.of<ThemeProvider>(context)
                    .currentTheme
                    .textTheme
                    .bodyMedium,
              ),
              // TextButton(
              //   onPressed: () {},
              //   child: Text(
              //     'View All',
              //     style: Provider.of<ThemeProvider>(context)
              //         .currentTheme
              //         .textTheme
              //         .bodySmall,
              //   ),
              // ),
            ],
          ),
          const SizedBox(height: 15),
          Obx(
            () => _categoryController.allSubCategoryList.length.isEqual(0)
                ? const SizedBox()
                : SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categoryController.allSubCategoryList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 190,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.transparent,
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  _userDashboardController.getSpBySubCat(
                                      _categoryController
                                          .allSubCategoryList[index].id);
                                  Get.to(
                                    () => SubCategoryDescription(
                                      subCatId: _categoryController
                                          .allSubCategoryList[index].id,
                                      title: _categoryController
                                          .allSubCategoryList[index].title,
                                      image:
                                          '$subCategoryUrl${_categoryController.allSubCategoryList[index].image}',
                                      description: _categoryController
                                          .allSubCategoryList[index]
                                          .description,
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 180,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.transparent,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              '$subCategoryUrl${_categoryController.allSubCategoryList[index].image}'),
                                          fit: BoxFit.fill)),
                                  padding: const EdgeInsets.all(12),
                                  // child: const Row(
                                  //   mainAxisAlignment: MainAxisAlignment.end,
                                  //   crossAxisAlignment: CrossAxisAlignment.start,
                                  //   children: [
                                  //     Icon(
                                  //       Icons.favorite_border,
                                  //       color: Colors.white,
                                  //     )
                                  //   ],
                                  // ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                _categoryController
                                    .allSubCategoryList[index].title,
                                style: Provider.of<ThemeProvider>(context)
                                    .currentTheme
                                    .textTheme
                                    .displaySmall,
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
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
//Top Service provider
class TopServiceProvider extends StatefulWidget {
  const TopServiceProvider({Key? key}) : super(key: key);

  @override
  State<TopServiceProvider> createState() => _TopServiceProviderState();
}

class _TopServiceProviderState extends State<TopServiceProvider> {
  final UserDashboardController _userDashboardController =
      Get.put(UserDashboardController());
  bool filled1 = false;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).topServiceProvider,
                  style: Provider.of<ThemeProvider>(context)
                      .currentTheme
                      .textTheme
                      .bodyMedium,
                ),
                TextButton(
                  onPressed: () {
                    if (_userDashboardController.serviceByRatings.length
                        .isEqual(0)) {
                    } else {
                      Get.to(
                        () => ServiceProviderScreen(
                          heading: S.of(context).topServiceProviders,
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
                            itemCount: _userDashboardController
                                .serviceByRatings.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                Get.to(() => WorkerProfileScreen(
                                    userID: _userDashboardController
                                        .serviceByRatings[index].id));
                              },
                              child: ServiceProviders(
                                countryCode: _userDashboardController
                                    .serviceByRatings[index].countryCode,
                                image: _userDashboardController
                                    .serviceByRatings[index].profileImage,
                                title: _userDashboardController
                                    .serviceByRatings[index].title,
                                phone: _userDashboardController
                                    .serviceByRatings[index].phone,
                                ratings: _userDashboardController
                                    .serviceByRatings[index].ratings,
                                id: _userDashboardController
                                    .serviceByRatings[index].id,
                                profession: _userDashboardController
                                    .serviceByRatings[index].categoryName,
                                email: _userDashboardController
                                    .serviceByRatings[index].email,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
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
            _userDashboardController.serviceByRatings.length.isEqual(0)
                ? SizedBox(
                    height: 80,
                    child: Center(
                      child: Text(
                        S.of(context).noServiceProviderInYourCity,
                        style: Provider.of<ThemeProvider>(context)
                            .currentTheme
                            .textTheme
                            .bodySmall,
                      ),
                    ),
                  )
                : SizedBox(
                    height: 275,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          _userDashboardController.serviceByRatings.length < 5
                              ? _userDashboardController.serviceByRatings.length
                              : 5,
                      itemBuilder: (context, index) {
                        return ScrollCard(
                          image: _userDashboardController
                                      .serviceByRatings[index].profileImage ==
                                  ''
                              ? Container(
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
                                )
                              : Container(
                                  height: 120,
                                  width: 160,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.blue,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              '$profileUrl${_userDashboardController.serviceByRatings[index].profileImage}'),
                                          fit: BoxFit.fill)),
                                ),
                          id: _userDashboardController
                              .serviceByRatings[index].id,
                          ratings: _userDashboardController
                              .serviceByRatings[index].ratings,
                          name: _userDashboardController
                              .serviceByRatings[index].title,
                          chat: () {
                            firebase.createChatRoom(
                                context,
                                _userDashboardController
                                    .serviceByRatings[index].id,
                                _userDashboardController
                                    .serviceByRatings[index].title,
                                _userDashboardController
                                    .serviceByRatings[index].email,
                                _userDashboardController
                                    .serviceByRatings[index].phone);
                          },
                          call: () {
                            makePhoneCall(
                                '${_userDashboardController.serviceByRatings[index].countryCode}${_userDashboardController.serviceByRatings[index].phone}');
                          },
                          profession: _userDashboardController
                              .serviceByRatings[index].categoryName,
                          onTap: () {
                            Get.to(() => WorkerProfileScreen(
                                userID: _userDashboardController
                                    .serviceByRatings[index].id));
                          },
                        );
                      },
                    ),
                  ),
          ],
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
//Customer Review
class CustomerReview extends StatefulWidget {
  const CustomerReview({Key? key}) : super(key: key);

  @override
  State<CustomerReview> createState() => _CustomerReviewState();
}

class _CustomerReviewState extends State<CustomerReview> {
  final UserDashboardController _userDashboardController =
      Get.put(UserDashboardController());

  @override
  Widget build(BuildContext context) {
    return _userDashboardController.userName == ''
        ? const SizedBox()
        : SizedBox(
            width: screenWidth(context),
            child: Column(
              children: [
                Text(
                  S.of(context).whatOurCustomerSays,
                  style: Provider.of<ThemeProvider>(context)
                      .currentTheme
                      .textTheme
                      .bodyMedium,
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: screenWidth(context) / 1.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Provider.of<ThemeProvider>(context)
                        .currentTheme
                        .cardColor,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    _userDashboardController.review.toString(),
                    style: Provider.of<ThemeProvider>(context)
                        .currentTheme
                        .textTheme
                        .labelMedium,
                    textAlign: TextAlign.center,
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 80,
                  color: Colors.transparent,
                  width: 250,
                  child: Row(
                    children: [
                      _userDashboardController.userImage == ''
                          ? CircleAvatar(
                              radius: 40,
                              backgroundColor: circleClr,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(1000),
                                child: Image.asset(
                                  'assets/images/profile.jpg',
                                  fit: BoxFit.cover,
                                  height: 70,
                                  width: 70,
                                ),
                              ),
                            )
                          : CircleAvatar(
                              radius: 40,
                              backgroundColor: circleClr,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(1000),
                                child: Image.network(
                                  '$profileUrl${_userDashboardController.userImage.toString()}',
                                  fit: BoxFit.cover,
                                  height: 70,
                                  width: 70,
                                ),
                              ),
                            ),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _userDashboardController.userName,
                            style: Provider.of<ThemeProvider>(context)
                                .currentTheme
                                .textTheme
                                .titleMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(width: 5),
                          IgnorePointer(
                            ignoring: true,
                            child: RatingBar(
                              initialRating: double.parse(
                                  _userDashboardController.ratings),
                              direction: Axis.horizontal,
                              itemCount: 5,
                              itemSize: 15,
                              ratingWidget: RatingWidget(
                                full: const Icon(
                                  Icons.star,
                                  color: Color(0XFFFEAD1D),
                                ),
                                half: const Icon(Icons.star_half,
                                    color: Color(0XFFFEAD1D)),
                                empty: const Icon(Icons.star_border,
                                    color: Color(0XFFFEAD1D)),
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            S.of(context).verifiedUser,
                            style: Provider.of<ThemeProvider>(context)
                                .currentTheme
                                .textTheme
                                .labelSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}

///
//
//
//
//
//ScrollCard
class ScrollCard extends StatefulWidget {
  const ScrollCard({
    super.key,
    required this.image,
    required this.name,
    required this.profession,
    required this.onTap,
    required this.call,
    required this.ratings,
    required this.chat,
    required this.id,
  });

  final String name;
  final String profession;
  final Function onTap;
  final Widget image;
  final Function call;
  final String ratings;
  final Function chat;
  final String id;

  @override
  State<ScrollCard> createState() => _ScrollCardState();
}

class _ScrollCardState extends State<ScrollCard> {
  final UserDashboardController _userDashboardController =
      Get.put(UserDashboardController());
  bool isFav = false;

  @override
  void initState() {
    super.initState();
    _userDashboardController.checkFavorite(widget.id).then((value) {
      isFav = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Provider.of<ThemeProvider>(context).currentTheme.cardColor,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            widget.image,
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              // height: 30,
              child: Text(
                widget.name,
                style: Provider.of<ThemeProvider>(context)
                    .currentTheme
                    .textTheme
                    .bodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              child: Text(
                widget.profession,
                style: Provider.of<ThemeProvider>(context)
                    .currentTheme
                    .textTheme
                    .titleSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 5),
            IgnorePointer(
              ignoring: true,
              child: RatingBar(
                initialRating:
                    widget.ratings.isEmpty ? 1 : double.parse(widget.ratings),
                direction: Axis.horizontal,
                itemCount: 5,
                itemSize: 20,
                ratingWidget: RatingWidget(
                  full: const Icon(
                    Icons.star,
                    color: Color(0XFFFEAD1D),
                  ),
                  half: const Icon(Icons.star_half, color: Color(0XFFFEAD1D)),
                  empty:
                      const Icon(Icons.star_border, color: Color(0XFFFEAD1D)),
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TapButton(
                  onTap: () {
                    widget.call();
                  },
                  image: const Icon(
                    Icons.call,
                    color: Colors.green,
                  ),
                ),
                TapButton(
                  onTap: () {
                    widget.chat();
                  },
                  image: Image.asset(
                    'assets/images/chat.png',
                    fit: BoxFit.contain,
                  ),
                ),
                // GetBuilder<UserDashboardController>(
                //   init: UserDashboardController(),
                //   builder: (dashController) {
                //     return FutureBuilder(
                //         future: dashController.checkFavorite(widget.id),
                //         builder:
                //             (BuildContext context, AsyncSnapshot snapshot) {
                //           if (snapshot.hasData) {
                //             if (snapshot.data != null) {
                //               if (snapshot.data == true) {
                //                 return IconButton(
                //                     onPressed: () async {
                //                       bool done = await dashController
                //                           .favUpdate(widget.id);
                //                       if (done) {
                //                         setState(() {});
                //                       } else {
                //                         setState(() {});
                //                       }
                //                     },
                //                     icon: const Icon(
                //                       Icons.favorite,
                //                       color: Colors.red,
                //                     ));
                //               } else {
                //                 return IconButton(
                //                     onPressed: () async {
                //                       bool done = await dashController
                //                           .favUpdate(widget.id);
                //                       if (done) {
                //                         setState(() {});
                //                       } else {
                //                         setState(() {});
                //                       }
                //                     },
                //                     icon: const Icon(Icons.favorite_border));
                //               }
                //             } else {
                //               return IconButton(
                //                   onPressed: () async {
                //                     bool done = await dashController
                //                         .favUpdate(widget.id);
                //                     if (done) {
                //                       setState(() {});
                //                     } else {
                //                       setState(() {});
                //                     }
                //                   },
                //                   icon: const Icon(Icons.favorite_border));
                //             }
                //           } else if (snapshot.hasError) {
                //             return const Icon(Icons.error_outline);
                //           } else {
                //             return IconButton(
                //                 onPressed: () {},
                //                 icon: const Icon(Icons.favorite_border));
                //           }
                //         });
                //   },
                // ),

                if (isFav)
                  IconButton(
                      onPressed: () async {
                        bool done =
                            await _userDashboardController.favUpdate(widget.id);
                        print(done);
                        if (done) {
                          isFav = done;
                          setState(() {});
                        } else {
                          isFav = done;
                          setState(() {});
                        }
                      },
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ))
                else
                  IconButton(
                      onPressed: () async {
                        bool done =
                            await _userDashboardController.favUpdate(widget.id);
                        print(done);
                        if (done) {
                          isFav = done;
                          setState(() {
                            _userDashboardController.getUsersFavorite();
                            // Get.to(()=> const FavoriteScreen());
                          });
                        } else {
                          isFav = done;
                          setState(() {});
                        }
                      },
                      icon: const Icon(Icons.favorite_border))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//
//
//
//
//TapButton
class TapButton extends StatelessWidget {
  const TapButton({
    super.key,
    required this.image,
    required this.onTap,
  });

  final Widget image;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 35,
        width: 35,
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.transparent),
        child: image,
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
class FavCard extends StatefulWidget {
  const FavCard({
    super.key,
    required this.image,
    required this.name,
    required this.profession,
    required this.onTap,
    required this.call,
    required this.favorite,
    required this.ratings,
    required this.chat,
    required this.id,
  });

  final String name;
  final String profession;
  final Function onTap;
  final Widget image;
  final Function call;
  final Function favorite;
  final String ratings;
  final Function chat;
  final String id;

  @override
  State<FavCard> createState() => _FavCardState();
}

class _FavCardState extends State<FavCard> {
  final UserDashboardController _userDashboardController =
      Get.put(UserDashboardController());
  bool filled1 = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Provider.of<ThemeProvider>(context).currentTheme.cardColor,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            widget.image,
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              child: Text(
                widget.name,
                style: Provider.of<ThemeProvider>(context)
                    .currentTheme
                    .textTheme
                    .bodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              child: Text(
                widget.profession,
                style: Provider.of<ThemeProvider>(context)
                    .currentTheme
                    .textTheme
                    .titleSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 5),
            IgnorePointer(
              ignoring: true,
              child: RatingBar(
                initialRating:
                    widget.ratings.isEmpty ? 1 : double.parse(widget.ratings),
                direction: Axis.horizontal,
                itemCount: 5,
                itemSize: 20,
                ratingWidget: RatingWidget(
                  full: const Icon(
                    Icons.star,
                    color: Color(0XFFFEAD1D),
                  ),
                  half: const Icon(Icons.star_half, color: Color(0XFFFEAD1D)),
                  empty:
                      const Icon(Icons.star_border, color: Color(0XFFFEAD1D)),
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TapButton(
                  onTap: () {
                    widget.call();
                  },
                  image: const Icon(
                    Icons.call,
                    color: Colors.green,
                  ),
                ),
                TapButton(
                  onTap: () {
                    widget.chat();
                  },
                  image: Image.asset(
                    'assets/images/chat.png',
                    fit: BoxFit.contain,
                  ),
                ),
                TapButton(
                  onTap: () {
                    widget.favorite();
                    setState(() {
                      filled1 = !filled1;
                    });
                  },
                  image: filled1
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                        ),
                ),
              ],
            ),
          ],
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
