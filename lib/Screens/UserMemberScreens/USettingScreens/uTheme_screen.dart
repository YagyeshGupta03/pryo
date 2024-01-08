import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Controllers/global_controllers.dart';
import 'package:pryo_app/Screens/UserMemberScreens/HomeScreens/homeScreen.dart';
import '../../../Constants/sizes.dart';
import '../../../Constants/theme_data.dart';
import '../../../generated/l10n.dart';

class UThemeScreen extends StatefulWidget {
  const UThemeScreen({Key? key}) : super(key: key);

  @override
  State<UThemeScreen> createState() => _UThemeScreenState();
}

class _UThemeScreenState extends State<UThemeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                final themeProvider =
                Provider.of<ThemeProvider>(context, listen: false);
                themeProvider.setTheme(whiteTheme);
                credentialController.addTheme(true);
              },
              child: Card(
                color: Provider.of<ThemeProvider>(context)
                    .currentTheme
                    .cardTheme
                    .color,
                elevation: 2,
                child: SizedBox(
                  height: 55,
                  width: screenWidth(context),
                  child: ListTile(
                    leading: Icon(
                      Icons.sunny,
                      color: Provider.of<ThemeProvider>(context)
                          .currentTheme
                          .iconTheme
                          .color,
                    ),
                    title: Text(
                      S.of(context).lightTheme,
                      style: Provider.of<ThemeProvider>(context)
                          .currentTheme
                          .textTheme
                          .labelLarge,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                final themeProvider =
                Provider.of<ThemeProvider>(context, listen: false);
                themeProvider.setTheme(blackTheme);
                credentialController.addTheme(false);
              },
              child: Card(
                color: Provider.of<ThemeProvider>(context)
                    .currentTheme
                    .cardTheme
                    .color,
                elevation: 2,
                child: SizedBox(
                  height: 55,
                  width: screenWidth(context),
                  child: ListTile(
                    leading: Icon(
                      Icons.dark_mode,
                      color: Provider.of<ThemeProvider>(context)
                          .currentTheme
                          .iconTheme
                          .color,
                    ),
                    title: Text(
                      S.of(context).darkTheme,
                      style: Provider.of<ThemeProvider>(context)
                          .currentTheme
                          .textTheme
                          .labelLarge,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
