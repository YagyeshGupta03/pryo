import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Constants/colors.dart';
import 'package:pryo_app/Controllers/global_controllers.dart';
import 'package:pryo_app/Screens/Sp_screens/SpProfileScreens/gallery_image_screen.dart';
import 'package:pryo_app/Screens/Sp_screens/SpProfileScreens/sp_edit_screen.dart';
import 'package:pryo_app/Screens/sp_profile_view.dart';
import '../../../Constants/all_urls.dart';
import '../../../Constants/sizes.dart';
import '../../../Constants/theme_data.dart';
import '../../../Controllers/category_controller.dart';
import '../../../Controllers/text_controllers.dart';
import '../../../Widgets/common_widgets.dart';
import '../../../generated/l10n.dart';
import '../../Profile_screens/user_profile_screen.dart';
import '../sp_settings.dart';

class SpProfileScreen extends StatefulWidget {
  const SpProfileScreen({Key? key}) : super(key: key);

  @override
  State<SpProfileScreen> createState() => _SpProfileScreenState();
}

class _SpProfileScreenState extends State<SpProfileScreen> {
  final TextController _textController = Get.put(TextController());
  final CategoryController _categoryController = Get.put(CategoryController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      //appbar
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.to(() => const SpSettings());
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
      ),

      //body
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 270,
                    child: Column(
                      children: [
                        Container(
                          width: screenWidth(context),
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                                image: AssetImage(
                                    Provider.of<ThemeProvider>(
                                        context)
                                        .currentTheme ==
                                        whiteTheme
                                        ? 'assets/images/userBackground.png'
                                        : 'assets/images/profileBackground.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 160),
                    child: Align(
                      alignment: Alignment.center,
                      child: Obx(
                        () => CircleAvatar(
                          radius: 48,
                          backgroundColor: circleClr,
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: userInfoController.profileImage.value == ''?
                            ClipRRect(
                              borderRadius: BorderRadius.circular(500),
                              child: Image.asset(
                                'assets/images/profile.jpg',
                                fit: BoxFit.cover,
                                height: 80,
                                width: 80,
                              ),
                            )
                            :ClipRRect(
                              borderRadius: BorderRadius.circular(500),
                              child: Image.network(
                                '$profileUrl${userInfoController.profileImage.value}',
                                fit: BoxFit.cover,
                                height: 80,
                                width: 80,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const CameraButton()
                ],
              ),
              Container(
                width: screenWidth(context),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      userInfoController.fullName.value,
                      style: Provider.of<ThemeProvider>(context)
                          .currentTheme
                          .textTheme
                          .bodyMedium, textAlign: TextAlign.center,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(()=> const SpEditScreen());
                      },
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                          fontFamily: fontFamily,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    InactiveUserFields(
                        text: S.of(context).fullName,
                        hintText: userInfoController.fullName.value,
                        fieldLabel: 'Full Name',
                        keyboard: TextInputType.text,
                        controller: _textController.editFullName.value,
                        enable: false),
                    const SizedBox(height: 20),
                    InactiveUserFields(
                        text: S.of(context).email,
                        hintText: userInfoController.email.value,
                        fieldLabel: 'E-mail',
                        keyboard: TextInputType.text,
                        controller: _textController.editMail.value,
                        enable: false),
                    const SizedBox(height: 20),
                    InactiveUserFields(
                        text: S.of(context).phoneNumber,
                        hintText: userInfoController.phone.value,
                        fieldLabel: 'Number',
                        keyboard: TextInputType.number,
                        controller: _textController.editPhone.value,
                        enable: false),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        Get.to(()=> const SpProfileView());
                      },
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          child: Text(
                            'Watch your advertisement',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              fontFamily: fontFamily,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ThemeButton(
                        onTap: () {
                          Get.to(()=> const GalleryImageScreen());
                        },
                        title: S.of(context).addYourServiceImages),
                    const SizedBox(height: 10),
                    ThemeButton(
                        onTap: () {
                          _categoryController.serviceCategory();
                          Get.to(() => const SpEditScreen());
                        },
                        title: S.of(context).edit),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
