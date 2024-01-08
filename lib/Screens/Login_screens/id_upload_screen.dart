import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Screens/Login_screens/signup_screen.dart';
import 'package:pryo_app/Widgets/common_widgets.dart';
import '../../Constants/colors.dart';
import '../../Constants/sizes.dart';
import '../../Constants/theme_data.dart';
import '../../Controllers/Login_controller.dart';
import '../../Controllers/global_controllers.dart';
import '../../generated/l10n.dart';

class IdUploadScreen extends StatefulWidget {
  const IdUploadScreen(
      {Key? key,
      required this.fullName,
      required this.userName,
      required this.password,
      required this.email,
      required this.phone,
      required this.city,
      required this.address,
      required this.category,
      required this.countryCode})
      : super(key: key);

  final String fullName;
  final String userName;
  final String password;
  final String email;
  final String phone;
  final String city;
  final String address;
  final String category;
  final String countryCode;

  @override
  State<IdUploadScreen> createState() => _IdUploadScreenState();
}

class _IdUploadScreenState extends State<IdUploadScreen> {
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

  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            loadingController.updateLoading(false);
            Get.to(() => const SignUpScreen());
          },
          icon: Icon(
            Icons.arrow_back,
            color: Provider.of<ThemeProvider>(context)
                .currentTheme
                .iconTheme
                .color,
          ),
        ),
        title: Text(
          S.of(context).verification,
          style: Provider.of<ThemeProvider>(context)
              .currentTheme
              .textTheme
              .headlineMedium,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () async {
                    _pickImage();
                  },
                  child: Container(
                    height: 100,
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
                          S.of(context).selectId,
                          style: Provider.of<ThemeProvider>(context)
                              .currentTheme
                              .textTheme
                              .labelLarge,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                LoginButton(
                    onTap: () {
                      if (_image.toString().isNotEmpty) {
                        _loginController.signUp(
                            context,
                            widget.fullName,
                            widget.userName,
                            widget.email,
                            widget.phone,
                            widget.password,
                            widget.city,
                            widget.address,
                            widget.countryCode,
                            widget.category,
                            _image);
                      } else {
                        AnimatedSnackBar.material(
                          S.of(context).selectId,
                          type: AnimatedSnackBarType.error,
                          mobilePositionSettings: const MobilePositionSettings(
                            topOnAppearance: 50,
                          ),
                          mobileSnackBarPosition: MobileSnackBarPosition.top,
                        ).show(context);
                      }
                    },
                    title: S.of(context).signup,
                    txtColor: Colors.white,
                    btnColor: primaryColor),
              ],
            ),
          ),
        ),
          Obx(
                () => loadingController.loading.value
                ? Center(
              child: Container(
                height: screenHeight(context),
                width: screenWidth(context),
                color: Colors.black12,
                child: LoadingAnimationWidget.threeArchedCircle(
                  color: primaryColor,
                  size: 50,
                ),
              ),
            )
                : const SizedBox(),
          ),
        ]
      ),
    );
  }
}
