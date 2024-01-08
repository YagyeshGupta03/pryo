import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Controllers/common_controllers.dart';
import 'package:pryo_app/Screens/Profile_screens/user_profile_screen.dart';
import 'package:pryo_app/Widgets/common_widgets.dart';
import '../Constants/colors.dart';
import '../Constants/theme_data.dart';
import '../generated/l10n.dart';

class AdminSupportScreen extends StatefulWidget {
  const AdminSupportScreen({Key? key}) : super(key: key);

  @override
  State<AdminSupportScreen> createState() => _AdminSupportScreenState();
}

class _AdminSupportScreenState extends State<AdminSupportScreen> {
  final AdminSupport _adminSupport = Get.put(AdminSupport());
  final _title = TextEditingController();
  final _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFFFE6D0B).withOpacity(0.30),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
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
          S.of(context).adminSupport,
          style: Provider.of<ThemeProvider>(context)
              .currentTheme
              .textTheme
              .headlineMedium,
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              UserFields(
                  text: S.of(context).title,
                  hintText: S.of(context).title,
                  controller: _title,
                  enable: true,
                  fieldLabel: 'title',
                  keyboard: TextInputType.text),
              const SizedBox(height: 20),
              UserFields(
                  text: S.of(context).description,
                  hintText: S.of(context).description,
                  controller: _description,
                  enable: true,
                  fieldLabel: 'title',
                  keyboard: TextInputType.text),
              const SizedBox(height: 30),
              LoginButton(
                  onTap: () {
                    _adminSupport.adminEnquiry(
                        _title.text, _description.text, context);
                  },
                  title: S.of(context).submit,
                  txtColor: Colors.white,
                  btnColor: primaryColor)
            ],
          ),
        ),
      ),
    );
  }
}
