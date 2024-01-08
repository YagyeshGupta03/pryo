import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Screens/setting_options.dart';
import '../../../Constants/sizes.dart';
import '../../../Constants/theme_data.dart';
import 'Constants/colors.dart';
import 'Controllers/global_controllers.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({Key? key, required this.user}) : super(key: key);

  final bool user;
  @override
  Widget build(BuildContext context) {
    final LanguageController _languageController = Get.put(LanguageController());
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
      body: Stack(
        children:[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    _languageController.changeLanguage('en');
                    credentialController.setLanguage('en');
                    Get.to(()=> SettingOptions(user: user));
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
                          Icons.language,
                          color: Provider.of<ThemeProvider>(context)
                              .currentTheme
                              .iconTheme
                              .color,
                        ),
                        title: Text(
                          'English',
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
                  onTap: () async {
                    _languageController.changeLanguage('sv');
                    credentialController.setLanguage('sv');
                    Get.to(()=> SettingOptions(user: user));
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
                          Icons.language,
                          color: Provider.of<ThemeProvider>(context)
                              .currentTheme
                              .iconTheme
                              .color,
                        ),
                        title: Text(
                          'Swedish',
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
        ]
      ),
    );
  }
}
