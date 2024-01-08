import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Constants/colors.dart';
import 'package:pryo_app/Controllers/profile_controller.dart';
import 'package:pryo_app/Screens/Profile_screens/user_profile_screen.dart';
import 'package:pryo_app/Widgets/common_widgets.dart';
import '../../../Constants/theme_data.dart';
import '../../../Controllers/category_controller.dart';
import '../../../Controllers/global_controllers.dart';
import '../../../generated/l10n.dart';
import 'sp_profile_screen.dart';

class SpEditScreen extends StatefulWidget {
  const SpEditScreen({Key? key}) : super(key: key);

  @override
  State<SpEditScreen> createState() => _SpEditScreenState();
}

class _SpEditScreenState extends State<SpEditScreen> {
  String _selectedCategory = '0';
  String _selectedSubCategory = '';
  final ProfileController _profileController = Get.put(ProfileController());
  final CategoryController _categoryController = Get.put(CategoryController());
  final _dummyController = TextEditingController();
  final _fullName =
      TextEditingController(text: userInfoController.fullName.value.toString());
  final _editCity =
      TextEditingController(text: userInfoController.city.value.toString());
  final _editAddress =
      TextEditingController(text: userInfoController.address.value.toString());
  final _editBio = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Get.to(() => const SpProfileScreen());
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
              S.of(context).editProfile,
              style: Provider.of<ThemeProvider>(context)
                  .currentTheme
                  .textTheme
                  .bodyMedium,
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),

                _selectedSubCategory == '' || _selectedSubCategory == '0'
                    ?

                    //DropDown for Category
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).serviceCategory,
                            style: Provider.of<ThemeProvider>(context)
                                .currentTheme
                                .textTheme
                                .displaySmall,
                          ),
                          const SizedBox(height: 12),
                          DropdownButtonFormField(
                            hint: userInfoController.categoryName.value == ''
                                ? Text(
                                    S.of(context).selectServiceCategory,
                                    style: Provider.of<ThemeProvider>(context)
                                        .currentTheme
                                        .textTheme
                                        .displaySmall,
                                  )
                                : Text(
                                    userInfoController.categoryName.value
                                        .toString(),
                                    style: Provider.of<ThemeProvider>(context)
                                        .currentTheme
                                        .textTheme
                                        .displaySmall,
                                  ),
                            onChanged: (val) {
                              _profileController.subCategoryList.clear();
                              _profileController.getSubCategoryForm(
                                  context, val.toString());
                              setState(() {
                                _selectedCategory = val.toString();
                              });
                            },
                            items: [
                              DropdownMenuItem(
                                value: '0',
                                child:
                                    Text(S.of(context).selectServiceCategory),
                              ),
                              for (int index = 0;
                                  index <
                                      _categoryController.categoryList.length;
                                  index++)
                                DropdownMenuItem<String>(
                                  value: _categoryController
                                      .categoryList[index].id,
                                  child: Text(_categoryController
                                      .categoryList[index].title),
                                ),
                            ],
                          ),
                        ],
                      )

                    // Custom disabled textField to show selected category to user
                    : InkWell(
                        onTap: () {
                          AnimatedSnackBar.material(
                            S.of(context).removeSelectedWorkProfile,
                            type: AnimatedSnackBarType.error,
                            mobilePositionSettings:
                                const MobilePositionSettings(
                              topOnAppearance: 50,
                            ),
                            mobileSnackBarPosition: MobileSnackBarPosition.top,
                          ).show(context);
                        },
                        child: UserFields(
                          controller: _dummyController,
                          hintText: _selectedCategory,
                          fieldLabel: '',
                          keyboard: TextInputType.text,
                          enable: false,
                          text: S.of(context).serviceCategory,
                        ),
                      ),
                const SizedBox(height: 20),

                // Dropdown for sub-category
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).workProfile,
                      style: Provider.of<ThemeProvider>(context)
                          .currentTheme
                          .textTheme
                          .displaySmall,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField(
                      // decoration: InputDecoration(
                      //
                      //
                      // ),
                      hint: userInfoController.subCategoryName.value == ''
                          ? Text(
                        S.of(context).selectWorkProfile,
                        style: Provider.of<ThemeProvider>(context)
                            .currentTheme
                            .textTheme
                            .displaySmall,
                      )
                          : Text(
                        userInfoController.subCategoryName.value
                            .toString(),
                        style: Provider.of<ThemeProvider>(context)
                            .currentTheme
                            .textTheme
                            .displaySmall,
                      ),
                      onChanged: (val) {
                        print('$val');
                        setState(() {
                          _selectedSubCategory = val.toString();
                        });
                      },
                      items: [
                        DropdownMenuItem(
                          value: '0',
                          child: Text(S.of(context).selectWorkProfile),
                        ),
                        for (int index = 0;
                            index < _profileController.subCategoryList.length;
                            index++)
                          DropdownMenuItem<String>(
                            value: _profileController.subCategoryList[index].id,
                            child: Text(_profileController
                                .subCategoryList[index].title),
                          ),
                      ],
                    ),
                  ],
                ),

                //UserTextFields for edit profile

                const SizedBox(height: 20),
                FormatterUserFields(
                    text: S.of(context).fullName,
                    formatter: FilteringTextInputFormatter.allow(
                        RegExp(r'[a-zA-Z\s-]')),
                    hintText: userInfoController.fullName.value,
                    fieldLabel: 'Full Name',
                    keyboard: TextInputType.text,
                    controller: _fullName,
                    enable: true),
                const SizedBox(height: 20),
                // InactiveUserFields(
                //     text: '  E-Mail',
                //     fieldLabel: 'E-mail',
                //     keyboard: TextInputType.text,
                //     controller: _textController.editMail.value,
                //     hintText: userInfoController.email.value,
                //     enable: false),
                // const SizedBox(height: 20),
                // InactiveUserFields(
                //     text: '  Phone Number',
                //     fieldLabel: 'Number',
                //     keyboard: TextInputType.number,
                //     hintText: userInfoController.phone.value,
                //     controller: _textController.editPhone.value,
                //     enable: false),
                // const SizedBox(height: 20),
                UserFields(
                    text: S.of(context).city,
                    fieldLabel: 'City',
                    hintText: userInfoController.city.value,
                    keyboard: TextInputType.text,
                    controller: _editCity,
                    enable: true),
                const SizedBox(height: 20),
                UserFields(
                    text: S.of(context).streetIncludeHouseNumber,
                    fieldLabel: 'Street',
                    keyboard: TextInputType.text,
                    hintText: userInfoController.address.value,
                    controller: _editAddress,
                    enable: true),
                const SizedBox(height: 20),
                UserFields(
                    text: S.of(context).bio,
                    fieldLabel: 'Street',
                    keyboard: TextInputType.text,
                    hintText: S.of(context).aboutYourself,
                    controller: _editBio,
                    enable: true),
                const SizedBox(height: 30),

                //Login Button
                LoginButton(
                    onTap: () {
                      if (_fullName.text.isNotEmpty &&
                          _editAddress.text.isNotEmpty &&
                          _editCity.text.isNotEmpty) {
                        _profileController.serviceProfile(
                            context,
                            _selectedCategory,
                            _selectedSubCategory,
                            _fullName.text,
                            _editAddress.text,
                            _editCity.text,
                            _editBio.text);
                      } else {
                        AnimatedSnackBar.material(
                          S.of(context).kindlyFillAllTheMandatoryFields,
                          type: AnimatedSnackBarType.error,
                          mobilePositionSettings: const MobilePositionSettings(
                            topOnAppearance: 50,
                          ),
                          mobileSnackBarPosition: MobileSnackBarPosition.top,
                        ).show(context);
                      }
                    },
                    title: S.of(context).update,
                    txtColor: Colors.white,
                    btnColor: primaryColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//
//
//
//
//
//
//
