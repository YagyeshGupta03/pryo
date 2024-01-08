import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Constants/colors.dart';
import 'package:pryo_app/Constants/sizes.dart';
import 'package:pryo_app/Controllers/global_controllers.dart';
import 'package:pryo_app/Screens/Sp_screens/SpProfileScreens/sp_profile_screen.dart';
import 'package:pryo_app/Widgets/common_widgets.dart';
import '../../../Constants/all_urls.dart';
import '../../../Constants/theme_data.dart';
import '../../../Controllers/profile_controller.dart';
import '../../../generated/l10n.dart';

class GalleryImageScreen extends StatefulWidget {
  const GalleryImageScreen({Key? key}) : super(key: key);

  @override
  State<GalleryImageScreen> createState() => _GalleryImageScreenState();
}

class _GalleryImageScreenState extends State<GalleryImageScreen> {
  final ProfileController _profileController = Get.put(ProfileController());
  List<XFile>? _image;
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickMultiImage();

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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.to(() => const SpProfileScreen());
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            color:Provider.of<ThemeProvider>(context)
                .currentTheme
                .iconTheme.color,
          ),
        ),
        title: Center(
          child: Text(
            S.of(context).galleryImages,
            style: Provider.of<ThemeProvider>(context)
                .currentTheme
                .textTheme
                .bodyMedium,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Obx(()=> Container(
        width: screenWidth(context),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                _pickImage();
              },
              child: Container(
                height: 150,
                width: screenWidth(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: primaryColor),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image,
                      size: 32,
                      color: Provider.of<ThemeProvider>(context)
                          .currentTheme
                          .iconTheme
                          .color,
                    ),
                    Text(
                      S.of(context).chooseImage,
                      style: Provider.of<ThemeProvider>(context)
                          .currentTheme
                          .textTheme
                          .labelLarge,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            userInfoController.galleryImages.isEmpty ?
            Text(S.of(context).noImageInTheGallery)
                : SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: userInfoController.galleryImages.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 190,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.transparent,
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.transparent,
                        image: DecorationImage(
                            image: NetworkImage(
                                '$galleryUrl${userInfoController.galleryImages[index]}'),
                            fit: BoxFit.fill),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 50),
            LoginButton(
                onTap: () {
                  _profileController.spGalleryUpdate(context, _image);
                },
                title: S.of(context).saveImage,
                txtColor: Colors.white,
                btnColor: primaryColor),
          ],
        ),
      )),
    );
  }
}
