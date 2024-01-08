import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Constants/colors.dart';
import 'package:pryo_app/Screens/Login_screens/Login_screen.dart';
import 'package:pryo_app/Screens/SSettingScreens/sThemes_screen.dart';
import 'package:pryo_app/Screens/Sp_screens/SpProfileScreens/work_experience_screen.dart';
import 'package:pryo_app/Screens/Sp_screens/sp_dashboard.dart';
import 'package:pryo_app/Screens/UserMemberScreens/HomeScreens/chat_home_screen.dart';
import 'package:pryo_app/Screens/setting_options.dart';
import '../../Constants/all_urls.dart';
import '../../Constants/sizes.dart';
import '../../Constants/theme_data.dart';
import '../../Controllers/global_controllers.dart';
import '../../generated/l10n.dart';
import '../admin_support_screen.dart';
import '../change_password_screen.dart';
import 'SpProfileScreens/sp_profile_screen.dart';

class SpSettings extends StatefulWidget {
  const SpSettings({Key? key}) : super(key: key);

  @override
  State<SpSettings> createState() => _SpSettingsState();
}

class _SpSettingsState extends State<SpSettings> {
  void initState() {
    super.initState();
    // userInfoController.getReviews(credentialController.id);
    // userInfoController.getReviewAndExperience(credentialController.id);
    // print('${credentialController.id}>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.to(() => SpDashboardScreen( userID: credentialController.id.toString(),));
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Provider.of<ThemeProvider>(context)
                .currentTheme
                .iconTheme
                .color,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 250,
              width: screenWidth(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: Obx(
                      () => CircleAvatar(
                        radius: 48,
                        backgroundColor: primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: userInfoController.profileImage.value =='' ?
                          ClipRRect(
                            borderRadius: BorderRadius.circular(500),
                            child: Image.asset(
                              'assets/images/profile.jpg',
                              fit: BoxFit.cover,
                              height: 88,
                              width: 88,
                            ),
                          )
                              : ClipRRect(
                            borderRadius: BorderRadius.circular(500),
                            child: Image.network(
                              '$profileUrl${userInfoController.profileImage.value}',
                              fit: BoxFit.cover,
                              height: 88,
                              width: 88,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding( padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      userInfoController.fullName.value,
                      style: Provider.of<ThemeProvider>(context)
                          .currentTheme
                          .textTheme
                          .bodyMedium, textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(userInfoController.email.value,
                        style: Provider.of<ThemeProvider>(context)
                            .currentTheme
                            .textTheme
                            .labelMedium, textAlign: TextAlign.center,),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
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
                  SpSettingsCard(
                    title: S.of(context).settings,
                    icon: Icon(Icons.settings,
                        color: Provider.of<ThemeProvider>(context)
                            .currentTheme
                            .iconTheme
                            .color),
                    onTap: () {
                      Get.to(() => const SettingOptions(user: false));
                    },
                  ),
                  SpSettingsCard(
                    title: S.of(context).chats,
                    icon: Icon(Icons.chat,
                        color: Provider.of<ThemeProvider>(context)
                            .currentTheme
                            .iconTheme
                            .color),
                    onTap: () {
                      Get.to(() => const ChatHomeScreen());
                    },
                  ),
                  SpSettingsCard(
                    title: S.of(context).workExperience,
                    icon: Icon(Icons.work,
                        color: Provider.of<ThemeProvider>(context)
                            .currentTheme
                            .iconTheme
                            .color),
                    onTap: () {
                      Get.to(()=> const WorkExperience());
                    },
                  ),
                  SpSettingsCard(
                    title: S.of(context).changePassword,
                    icon: Icon(Icons.password,
                        color: Provider.of<ThemeProvider>(context)
                            .currentTheme
                            .iconTheme
                            .color),
                    onTap: () {
                      Get.to(()=> const ChangePasswordScreen());
                    },
                  ),
                  // SpSettingsCard(
                  //   title: 'Notifications',
                  //   icon: Icon(Icons.notifications_rounded,
                  //       color: Provider.of<ThemeProvider>(context)
                  //           .currentTheme
                  //           .iconTheme
                  //           .color),
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => const NotificationScreen(),
                  //       ),
                  //     );
                  //   },
                  // ),
                  const SizedBox(height: 20),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey.shade300,
                    indent: 20,
                    endIndent: 20,
                  ),
                  const SizedBox(height: 20),
                  // SpSettingsCard(
                  //   title: 'Address/Location',
                  //   icon: Icon(Icons.location_on,
                  //       color: Provider.of<ThemeProvider>(context)
                  //           .currentTheme
                  //           .iconTheme
                  //           .color),
                  //   onTap: () {},
                  // ),
                  SpSettingsCard(
                    title: S.of(context).contactUs,
                    icon: Icon(Icons.support_agent,
                        color: Provider.of<ThemeProvider>(context)
                            .currentTheme
                            .iconTheme
                            .color),
                    onTap: () {
                      Get.to(()=> const AdminSupportScreen());
                    },
                  ),
                  SpSettingsCard(
                    title: S.of(context).logout,
                    icon: Icon(Icons.logout,
                        color: Provider.of<ThemeProvider>(context)
                            .currentTheme
                            .iconTheme
                            .color),
                    onTap: () {
                      loadingController.updateLoading(false);
                      credentialController.deleteData();
                      Get.offAll(() => const LoginScreen());
                    },
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
//
//
//
//
class SpSettingsCard extends StatelessWidget {
  const SpSettingsCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final Widget icon;
  final String title;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Card(
        color: Provider.of<ThemeProvider>(context).currentTheme.cardTheme.color,
        elevation: 2,
        child: SizedBox(
          height: 55,
          width: screenWidth(context),
          child: ListTile(
            leading: icon,
            title: Text(
              title,
              style: Provider.of<ThemeProvider>(context)
                  .currentTheme
                  .textTheme
                  .labelLarge,
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
class EditImage extends StatelessWidget {
  const EditImage({Key? key, required this.onTap}) : super(key: key);

  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 70, left: 60),
      child: Align(
        alignment: Alignment.center,
        child: InkWell(
          onTap: () {
            onTap();
          },
          child: const CircleAvatar(
            radius: 14,
            backgroundColor: primaryColor,
            child: Center(
              child: Icon(
                Icons.edit,
                size: 16,
                color: whiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
