import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Constants/all_urls.dart';
import 'package:pryo_app/Constants/colors.dart';
import 'package:pryo_app/Controllers/global_controllers.dart';
import 'package:pryo_app/Controllers/profile_controller.dart';
import 'package:pryo_app/Screens/Profile_screens/userEdit_screen.dart';
import 'package:pryo_app/Screens/UserMemberScreens/HomeScreens/homeScreen.dart';
import 'package:pryo_app/Widgets/common_widgets.dart';
import '../../Constants/sizes.dart';
import '../../Constants/theme_data.dart';
import '../../generated/l10n.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _dummyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.to(() => const HomeScreen());
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
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
                            color: circleClr,
                            image: DecorationImage(
                                image: AssetImage(Provider.of<ThemeProvider>(
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
                            child: userInfoController.profileImage.value == ''
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(500),
                                    child: Image.asset(
                                      'assets/images/profile.jpg',
                                      fit: BoxFit.cover,
                                      height: 80,
                                      width: 80,
                                    ),
                                  )
                                : ClipRRect(
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
                          .bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => const UserEditScreen());
                      },
                      child: Text(
                        S.of(context).editProfile,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                          fontFamily: fontFamily,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    UserFields(
                        text: S.of(context).fullName,
                        hintText: userInfoController.fullName.value,
                        fieldLabel: 'Full Name',
                        keyboard: TextInputType.text,
                        controller: _dummyController,
                        enable: false),
                    const SizedBox(height: 20),
                    UserFields(
                        text: S.of(context).email,
                        hintText: userInfoController.email.value,
                        fieldLabel: 'E-mail',
                        keyboard: TextInputType.text,
                        controller: _dummyController,
                        enable: false),
                    const SizedBox(height: 20),
                    UserFields(
                        text: S.of(context).phoneNumber,
                        hintText: userInfoController.phone.value,
                        fieldLabel: 'Number',
                        keyboard: TextInputType.number,
                        controller: _dummyController,
                        enable: false),
                    const SizedBox(height: 30),
                    ThemeButton(
                        onTap: () {
                          Get.to(() => const UserEditScreen());
                        },
                        title: S.of(context).edit)
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

class CameraButton extends StatefulWidget {
  const CameraButton({
    super.key,
  });

  @override
  State<CameraButton> createState() => _CameraButtonState();
}

class _CameraButtonState extends State<CameraButton> {
  final ProfileController _profileController = Get.put(ProfileController());
  XFile? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 225, left: 42),
      child: Align(
        alignment: Alignment.center,
        child: InkWell(
          onTap: () async {
            final picker = ImagePicker();
            final pickedFile =
                await picker.pickImage(source: ImageSource.gallery);
            setState(() {
              _image = pickedFile;
              _profileController.profileImageUpdate(context, _image);
            });
          },
          child: const CircleAvatar(
            radius: 14,
            backgroundColor: circleClr,
            child: Center(
              child: Icon(
                Icons.camera_alt,
                size: 16,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UserFields extends StatelessWidget {
  const UserFields(
      {Key? key,
      required this.text,
      required this.hintText,
      required this.controller,
      required this.enable,
      required this.fieldLabel,
      required this.keyboard})
      : super(key: key);

  final String text;
  final String hintText;
  final String fieldLabel;
  final TextInputType keyboard;
  final TextEditingController controller;
  final bool enable;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: Provider.of<ThemeProvider>(context)
              .currentTheme
              .textTheme
              .displaySmall,
        ),
        const SizedBox(height: 12),
        CustomTextField(
            cont: controller,
            hintText: hintText,
            fillColor:
                Provider.of<ThemeProvider>(context).currentTheme.cardColor,
            fieldLabel: fieldLabel,
            keyboard: keyboard,
            icon: const SizedBox(),
            enable: enable),
      ],
    );
  }
}

//
//
//
//
//
class FormatterUserFields extends StatelessWidget {
  const FormatterUserFields(
      {Key? key,
      required this.text,
      required this.hintText,
      required this.controller,
      required this.enable,
      required this.fieldLabel,
      required this.keyboard,
      required this.formatter})
      : super(key: key);

  final String text;
  final String hintText;
  final String fieldLabel;
  final TextInputType keyboard;
  final TextEditingController controller;
  final bool enable;
  final FilteringTextInputFormatter formatter;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: Provider.of<ThemeProvider>(context)
              .currentTheme
              .textTheme
              .displaySmall,
        ),
        const SizedBox(height: 12),
        FormatterTextField(
          cont: controller,
          hintText: hintText,
          fillColor: Provider.of<ThemeProvider>(context).currentTheme.cardColor,
          fieldLabel: fieldLabel,
          keyboard: keyboard,
          icon: const SizedBox(),
          enable: enable,
          formatter: formatter,
        ),
      ],
    );
  }
}

//
//
//
//
//
//
class InactiveUserFields extends StatelessWidget {
  const InactiveUserFields(
      {Key? key,
      required this.text,
      required this.hintText,
      required this.controller,
      required this.enable,
      required this.fieldLabel,
      required this.keyboard})
      : super(key: key);

  final String text;
  final String hintText;
  final String fieldLabel;
  final TextInputType keyboard;
  final TextEditingController controller;
  final bool enable;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: Provider.of<ThemeProvider>(context)
              .currentTheme
              .textTheme
              .displaySmall,
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          child: CustomTextField(
              cont: controller,
              fillColor: Colors.transparent,
              hintText: hintText,
              fieldLabel: fieldLabel,
              keyboard: keyboard,
              icon: const SizedBox(),
              enable: enable),
        ),
      ],
    );
  }
}
