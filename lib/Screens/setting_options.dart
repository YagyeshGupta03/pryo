import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/LanguageScreen.dart';
import 'package:pryo_app/Screens/Sp_screens/sp_settings.dart';
import 'package:pryo_app/Screens/UserMemberScreens/USettingScreens/uSetting_screen.dart';
import 'package:pryo_app/Screens/UserMemberScreens/USettingScreens/uTheme_screen.dart';
import '../../../Constants/theme_data.dart';
import '../generated/l10n.dart';

class SettingOptions extends StatelessWidget {
  const SettingOptions({Key? key, required this.user}) : super(key: key);

  final bool user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            user
                ? Get.to(() => const USettingScreen())
                : Get.to(() => const SpSettings());
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Provider.of<ThemeProvider>(context)
                .currentTheme
                .iconTheme
                .color,
          ),
        ),
        title: Text(
          S.of(context).settings,
          style: Provider.of<ThemeProvider>(context)
              .currentTheme
              .textTheme
              .headlineMedium,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      // extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SpSettingsCard(
                title: S.of(context).theme,
                icon: Icon(Icons.color_lens,
                    color: Provider.of<ThemeProvider>(context)
                        .currentTheme
                        .iconTheme
                        .color),
                onTap: () {
                  Get.to(() => const UThemeScreen());
                },
              ),
              SpSettingsCard(
                title: S.of(context).language,
                icon: Icon(Icons.language,
                    color: Provider.of<ThemeProvider>(context)
                        .currentTheme
                        .iconTheme
                        .color),
                onTap: () {
                  Get.to(() => LanguageScreen(user: user),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
