import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Constants/sizes.dart';
import 'package:pryo_app/Constants/theme_data.dart';
import 'package:pryo_app/Controllers/profile_controller.dart';
import 'package:pryo_app/Screens/Sp_screens/sp_settings.dart';
import 'package:pryo_app/Screens/worker_profile_screen.dart';
import '../../Constants/all_urls.dart';
import '../../Constants/colors.dart';
import '../../Controllers/global_controllers.dart';
import '../../Controllers/notifications_controller.dart';
import '../../generated/l10n.dart';
import 'SpProfileScreens/sp_profile_screen.dart';

class SpDashboardScreen extends StatefulWidget {
  const SpDashboardScreen({Key? key, required this.userID}) : super(key: key);

  final String userID;

  @override
  State<SpDashboardScreen> createState() => _SpDashboardScreenState();
}

class _SpDashboardScreenState extends State<SpDashboardScreen> {
  final ProfileController _profileController = Get.put(ProfileController());

  void initState() {
    super.initState();
    // userInfoController.getReviews(widget.userID);
    userInfoController.getReviewAndExperience(widget.userID);
    _profileController.updateLocation(context);
    print('////////////');

    FCM().setNotifications(context);
    firebase.firebaseTokenUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                          height: 40,
                          width: 40,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(500),
                        child: Image.network(
                          '$profileUrl${userInfoController.profileImage.value}',
                          fit: BoxFit.cover,
                          height: 40,
                          width: 40,
                        ),
                      ),
              ),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        title: ListTile(
          title: Obx(
            () => Text(
              userInfoController.city.value.toString(),
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: whiteColor,
                fontSize: 15,
                fontFamily: fontFamily,
              ),
              maxLines: 1,
            ),
          ),
          subtitle: Obx(
            () => Text(
              userInfoController.fullName.value.toString(),
              style: TextStyle(
                  color: whiteColor,
                  fontFamily: fontFamily,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
              maxLines: 1,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const SpSettings());
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              width: screenWidth(context),
              margin: const EdgeInsets.only(bottom: 25),
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
              decoration: BoxDecoration(
                  color: Provider.of<ThemeProvider>(context)
                      .currentTheme
                      .dialogBackgroundColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Obx(
                      () => Text(
                        'Hello ${userInfoController.fullName.value.toString()}!',
                        style: TextStyle(
                            color: whiteColor,
                            fontFamily: fontFamily,
                            fontSize: 22,
                            fontWeight: FontWeight.w700),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const SpSettings());
                    },
                    child: Text(
                      S.of(context).editProfile,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: primaryColor),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    S.of(context).dashboard,
                    style: Provider.of<ThemeProvider>(context)
                        .currentTheme
                        .textTheme
                        .bodyMedium,
                  ),
                ),
                Container(
                  color: Provider.of<ThemeProvider>(context)
                      .currentTheme
                      .highlightColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => DashboardCard(
                          image: 'assets/images/dashboardCard2.png',
                          text: S.of(context).totalExperience,
                          number:
                              '${userInfoController.workExperience.value.toString()} years',
                        ),
                      ),
                      Obx(
                        () => DashboardCard(
                          image: 'assets/images/dashboardCard1.png',
                          text: S.of(context).positiveRatings,
                          number:
                              '${userInfoController.positiveRatings.value.toString()}%',
                        ),
                      ),
                    ],
                  ),
                ),
                const SpReviews(),
              ],
            ),
          ],
        ),
      ),
      // drawer: Drawer(
      //   backgroundColor: Provider.of<ThemeProvider>(context)
      //       .currentTheme
      //       .scaffoldBackgroundColor,
      //   child: Column(
      //     children: [
      //       Padding(
      //         padding: const EdgeInsets.only(left: 10),
      //         child: Obx(
      //               () => CircleAvatar(
      //             radius: 32,
      //             backgroundColor: circleClr,
      //             child: Padding(
      //               padding: const EdgeInsets.all(4),
      //               child: userInfoController.profileImage.value == ''
      //                   ? ClipRRect(
      //                 borderRadius: BorderRadius.circular(500),
      //                 child: Image.asset(
      //                   'assets/images/profile.jpg',
      //                   fit: BoxFit.cover,
      //                   height: 40,
      //                   width: 40,
      //                 ),
      //               )
      //                   : ClipRRect(
      //                 borderRadius: BorderRadius.circular(500),
      //                 child: Image.network(
      //                   '$profileUrl${userInfoController.profileImage.value}',
      //                   fit: BoxFit.cover,
      //                   height: 40,
      //                   width: 40,
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //       ListTile(
      //         title: Obx(
      //               () => Text(
      //             userInfoController.address.value.toString(),
      //             style: TextStyle(
      //               fontWeight: FontWeight.w400,
      //               color: whiteColor,
      //               fontSize: 15,
      //               fontFamily: fontFamily,
      //             ),
      //             maxLines: 1,
      //           ),
      //         ),
      //         subtitle: Obx(
      //               () => Text(
      //             userInfoController.fullName.value.toString(),
      //             style: TextStyle(
      //                 color: whiteColor,
      //                 fontFamily: fontFamily,
      //                 fontSize: 12,
      //                 fontWeight: FontWeight.w400),
      //             maxLines: 1,
      //           ),
      //         ),
      //       ),
      //       SpSettingsCard(
      //         title: 'Profile Details',
      //         icon: Icon(Icons.person,
      //             color: Provider.of<ThemeProvider>(context)
      //                 .currentTheme
      //                 .iconTheme
      //                 .color),
      //         onTap: () {
      //           userInfoController.getUserInfo();
      //           Get.to(() => const SpProfileScreen());
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      drawerEnableOpenDragGesture: true,
      drawerDragStartBehavior: DragStartBehavior.start,
    );
  }
}

//
//
//
//
class SpReviews extends StatelessWidget {
  const SpReviews({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Text(
            S.of(context).reviews,
            style: Provider.of<ThemeProvider>(context)
                .currentTheme
                .textTheme
                .bodyMedium,
          ),
          const SizedBox(height: 5),
          Obx(
            () => userInfoController.reviewList.length.isEqual(0)
                ? Text(
                    S.of(context).noReview,
                    style: Provider.of<ThemeProvider>(context)
                        .currentTheme
                        .textTheme
                        .bodySmall,
                  )
                : SizedBox(
                    child: ListView.builder(
                      itemCount: userInfoController.reviewList.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(0),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return ReviewTile(
                          images: userInfoController.reviewList[index].image,
                          name: userInfoController.reviewList[index].name,
                          review: userInfoController.reviewList[index].review,
                          rating: userInfoController.reviewList[index].rating,
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
class DashboardCard extends StatelessWidget {
  const DashboardCard({
    super.key,
    required this.image,
    required this.text,
    required this.number,
  });

  final String image;
  final String text;
  final String number;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: circleClr,
      child: Container(
        constraints: const BoxConstraints(minWidth: 150),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Provider.of<ThemeProvider>(context).currentTheme.cardColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 43,
              width: 50,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(image),
                ),
              ),
            ),
            Text(
              text,
              style: Provider.of<ThemeProvider>(context)
                  .currentTheme
                  .textTheme
                  .labelMedium,
            ),
            Text(
              number,
              style: Provider.of<ThemeProvider>(context)
                  .currentTheme
                  .textTheme
                  .labelLarge,
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
class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Provider.of<ThemeProvider>(context)
          .currentTheme
          .scaffoldBackgroundColor,
      child: Column(
        children: [
          Padding(
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
                            height: 40,
                            width: 40,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(500),
                          child: Image.network(
                            '$profileUrl${userInfoController.profileImage.value}',
                            fit: BoxFit.cover,
                            height: 40,
                            width: 40,
                          ),
                        ),
                ),
              ),
            ),
          ),
          ListTile(
            title: Obx(
              () => Text(
                userInfoController.address.value.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: whiteColor,
                  fontSize: 15,
                  fontFamily: fontFamily,
                ),
                maxLines: 1,
              ),
            ),
            subtitle: Obx(
              () => Text(
                userInfoController.fullName.value.toString(),
                style: TextStyle(
                    color: whiteColor,
                    fontFamily: fontFamily,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
                maxLines: 1,
              ),
            ),
          ),
          SpSettingsCard(
            title: S.of(context).profileDetails,
            icon: Icon(Icons.person,
                color: Provider.of<ThemeProvider>(context)
                    .currentTheme
                    .iconTheme
                    .color),
            onTap: () {
              userInfoController.getUserInfo();
              Get.to(() => const SpProfileScreen());
            },
          ),
        ],
      ),
    );
  }
}
