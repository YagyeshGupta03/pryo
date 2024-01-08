import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Constants/colors.dart';
import 'package:pryo_app/Controllers/user_dashboard_controller.dart';
import 'package:pryo_app/Screens/Login_screens/Login_screen.dart';
import 'package:pryo_app/Screens/UserMemberScreens/HomeScreens/homeScreen.dart';
import 'package:pryo_app/Screens/UserMemberScreens/USettingScreens/favorite_screen.dart';
import 'package:pryo_app/Screens/admin_support_screen.dart';
import 'package:pryo_app/Screens/change_password_screen.dart';
import 'package:pryo_app/Screens/setting_options.dart';
import '../../../Constants/all_urls.dart';
import '../../../Constants/sizes.dart';
import '../../../Constants/theme_data.dart';
import '../../../Controllers/global_controllers.dart';
import '../../../generated/l10n.dart';
import '../../Sp_screens/sp_settings.dart';

class USettingScreen extends StatefulWidget {
  const USettingScreen({Key? key}) : super(key: key);

  @override
  State<USettingScreen> createState() => _USettingScreenState();
}

class _USettingScreenState extends State<USettingScreen> {
  @override
  Widget build(BuildContext context) {

    final UserDashboardController _userDashboardController =
    Get.put(UserDashboardController());

    @override
    void initState() {
      super.initState();
      _userDashboardController.getUsersFavorite();
    }
    return Scaffold(
      appBar: AppBar(
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
        automaticallyImplyLeading: false,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
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
                          child: userInfoController.profileImage.value == ''
                              ? ClipRRect(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
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
                    title: S.of(context).settings,
                    icon: Icon(Icons.settings,
                        color: Provider.of<ThemeProvider>(context)
                            .currentTheme
                            .iconTheme
                            .color),
                    onTap: () {
                      Get.to(() => const SettingOptions(user: true));
                    },
                  ),
                  SpSettingsCard(
                    title: S.of(context).yourFavorites,
                    icon: Icon(Icons.save,
                        color: Provider.of<ThemeProvider>(context)
                            .currentTheme
                            .iconTheme
                            .color),
                    onTap: () {
                      _userDashboardController.serviceByFavList.clear();
                      _userDashboardController.getUsersFavorite();
                      Get.to(()=> const FavoriteScreen());
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
