import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Constants/theme_data.dart';
import 'package:pryo_app/Screens/Profile_screens/user_profile_screen.dart';
import 'package:pryo_app/Screens/UserMemberScreens/HomeScreens/chat_home_screen.dart';
import '../../../Controllers/global_controllers.dart';
import '../../../generated/l10n.dart';
import 'all_categories_screen.dart';
import 'dashboard_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: bnbController.currentIndex.value,
          children: const [
            DashboardScreen(),
            CategoriesScreen(),
            UserProfileScreen(),
            ChatHomeScreen()
            // ChatScreen(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          height: 72,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Provider.of<ThemeProvider>(context).currentTheme.hintColor,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  bnbController.changeIndex(0);
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: Image.asset('assets/images/iconHome.png'),
                    ),
                    bnbController.currentIndex.value == 0
                        ? const SizedBox(width: 5)
                        : const SizedBox(),
                    bnbController.currentIndex.value == 0
                        ? Text(
                            S.of(context).home,
                            style: Provider.of<ThemeProvider>(context)
                                .currentTheme
                                .textTheme
                                .bodyLarge,
                          )
                        : const SizedBox()
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  bnbController.changeIndex(1);
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: Image.asset('assets/images/iconCategory.png'),
                    ),
                    bnbController.currentIndex.value == 1
                        ? const SizedBox(width: 5)
                        : const SizedBox(),
                    bnbController.currentIndex.value == 1
                        ? Text(
                            S.of(context).category,
                            style: Provider.of<ThemeProvider>(context)
                                .currentTheme
                                .textTheme
                                .bodyLarge,
                          )
                        : const SizedBox()
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  bnbController.changeIndex(2);
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: Image.asset('assets/images/iconProfile.png'),
                    ),
                    bnbController.currentIndex.value == 2
                        ? const SizedBox(width: 5)
                        : const SizedBox(),
                    bnbController.currentIndex.value == 2
                        ? Text(
                            S.of(context).profiles,
                            style: Provider.of<ThemeProvider>(context)
                                .currentTheme
                                .textTheme
                                .bodyLarge,
                          )
                        : const SizedBox()
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  bnbController.changeIndex(3);
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: Image.asset('assets/images/iconChats.png'),
                    ),
                    bnbController.currentIndex.value == 3
                        ? const SizedBox(width: 5)
                        : const SizedBox(),
                    bnbController.currentIndex.value == 3
                        ? Text(
                            S.of(context).chats,
                            style: Provider.of<ThemeProvider>(context)
                                .currentTheme
                                .textTheme
                                .bodyLarge,
                          )
                        : const SizedBox()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
