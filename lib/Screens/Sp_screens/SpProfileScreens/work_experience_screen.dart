import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Controllers/profile_controller.dart';
import 'package:pryo_app/Screens/Sp_screens/sp_settings.dart';
import '../../../Constants/colors.dart';
import '../../../Constants/sizes.dart';
import '../../../Constants/theme_data.dart';
import '../../../Widgets/common_widgets.dart';
import '../../../generated/l10n.dart';
import '../../Profile_screens/user_profile_screen.dart';

class WorkExperience extends StatefulWidget {
  const WorkExperience({Key? key}) : super(key: key);

  @override
  State<WorkExperience> createState() => _WorkExperienceState();
}

class _WorkExperienceState extends State<WorkExperience> {
  XFile? _image;

  final _work = TextEditingController();
  final ProfileController _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.to(() => const SpSettings());
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Provider.of<ThemeProvider>(context)
                .currentTheme
                .iconTheme
                .color,
          ),
        ),
        title: Center(
          child: Text(
            S.of(context).workExperience,
            style: Provider.of<ThemeProvider>(context)
                .currentTheme
                .textTheme
                .bodyMedium,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              UserFields(
                  text: S.of(context).workExperience,
                  hintText: S.of(context).enterNumberOfYears,
                  fieldLabel: 'Full Name',
                  keyboard: TextInputType.number,
                  controller: _work,
                  enable: true),
              const SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  final picker = ImagePicker();
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      _image = pickedFile;
                    });
                  }
                },
                child: Card(
                  elevation: 1,
                  child: Container(
                    height: 100,
                    width: screenWidth(context),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.transparent),
                        color: Provider.of<ThemeProvider>(context)
                            .currentTheme
                            .cardColor),
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
                          S.of(context).selectExperienceCertificate,
                          style: Provider.of<ThemeProvider>(context)
                              .currentTheme
                              .textTheme
                              .labelMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              //Login Button
              LoginButton(
                  onTap: () {
                    if (_work.text.isNotEmpty && _image?.path != null && _image?.path.isNotEmpty == true) {
                      _profileController.addWork(context, _work.text, _image);
                    } else {
                      return AnimatedSnackBar.material(
                        S.of(context).enterAllTheFields,
                        type: AnimatedSnackBarType.error,
                        mobilePositionSettings: const MobilePositionSettings(
                          topOnAppearance: 50,
                        ),
                        mobileSnackBarPosition: MobileSnackBarPosition.top,
                      ).show(context);
                    }
                  },
                  title: S.of(context).save,
                  txtColor: Colors.white,
                  btnColor: primaryColor),
            ],
          ),
        ),
      ),
    );
  }
}
