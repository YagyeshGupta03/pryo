import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../Constants/colors.dart';
import '../Constants/theme_data.dart';
import '../Functions/validator_function.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    super.key,
    required this.onTap,
    required this.image,
  });

  final Function onTap;
  final String image;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onTap();
      },
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: circleClr,
          borderRadius: BorderRadius.circular(500),
          image: DecorationImage(
            image: AssetImage(image),
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
class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.cont,
      required this.hintText,
      required this.icon,
      required this.enable,
      required this.fieldLabel,
      required this.keyboard, required this.fillColor})
      : super(key: key);

  final TextEditingController cont;
  final String hintText;
  final Widget icon;
  final bool enable;
  final String fieldLabel;
  final TextInputType keyboard;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Provider.of<ThemeProvider>(context)
          .currentTheme.textTheme.displayMedium,
      cursorColor: primaryColor,
      controller: cont,
      keyboardType: keyboard,
      enabled: enable,
      validator: (value) => validateField(value!, fieldLabel, context),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: icon,
        hintStyle: Provider.of<ThemeProvider>(context)
            .currentTheme.textTheme.displaySmall,
        filled: true,
        fillColor: fillColor,
        disabledBorder: Provider.of<ThemeProvider>(context)
            .currentTheme.inputDecorationTheme.disabledBorder,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
        border: Provider.of<ThemeProvider>(context)
            .currentTheme.inputDecorationTheme.border,
      ),
    );
  }
}
//
//
//
//
//
class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.onTap,
    required this.title,
    required this.txtColor,
    required this.btnColor,
  });

  final Function onTap;
  final String title;
  final Color txtColor;
  final Color btnColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: btnColor),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 30,
          width: double.infinity,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: txtColor,
                fontFamily: fontFamily,
              ),
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
class ThemeButton extends StatelessWidget {
  const ThemeButton({
    super.key,
    required this.onTap,
    required this.title,
  });

  final Function onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor:  Provider.of<ThemeProvider>(context)
              .currentTheme.cardTheme.color,),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 30,
          width: double.infinity,
          child: Center(
            child: Text(
              title,
              style: Provider.of<ThemeProvider>(context)
                  .currentTheme.textTheme.labelLarge,
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
class HeadingText extends StatelessWidget {
  const HeadingText({
    super.key,
    required this.profileName,
  });

  final String profileName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(profileName, style:  Provider.of<ThemeProvider>(context)
              .currentTheme.textTheme.displayLarge),
          // Text(
          //   message,
          //   style:  Provider.of<ThemeProvider>(context)
          //       .currentTheme.textTheme.displayMedium,
          //   textAlign: TextAlign.center,
          // ),
        ],
      ),
    );
  }
}
//
//
//
//
//
class PhoneTextField extends StatefulWidget {
  const PhoneTextField(
      {Key? key,
        required this.cont,
        required this.hintText,
        required this.icon,
        required this.enable,
        required this.fieldLabel,
        required this.keyboard, required this.fillColor})
      : super(key: key);

  final TextEditingController cont;
  final String hintText;
  final Widget icon;
  final bool enable;
  final String fieldLabel;
  final TextInputType keyboard;
  final Color fillColor;

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

var codeOfCountry = '';
class _PhoneTextFieldState extends State<PhoneTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Provider.of<ThemeProvider>(context)
          .currentTheme.textTheme.displayMedium,
      cursorColor: primaryColor,
      controller: widget.cont,
      keyboardType: widget.keyboard,
      enabled: widget.enable,
      validator: (value) => validateField(value!, widget.fieldLabel, context),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: SizedBox(
          child: CountryCodePicker(
            onChanged: (countryCode){
              setState(() {
                codeOfCountry = countryCode.toString();
              });
            },
            dialogBackgroundColor: Provider.of<ThemeProvider>(context)
                .currentTheme.cardColor,
            initialSelection: '+46',
            showFlag: false,
            favorite: const ['+46','sv'],
            showCountryOnly: false,
            showOnlyCountryWhenClosed: false,
            alignLeft: false,
          ),
        ),
        suffixIcon: widget.icon,
        hintStyle: Provider.of<ThemeProvider>(context)
            .currentTheme.textTheme.displaySmall,
        filled: true,
        fillColor: widget.fillColor,
        disabledBorder: Provider.of<ThemeProvider>(context)
            .currentTheme.inputDecorationTheme.disabledBorder,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
        border: Provider.of<ThemeProvider>(context)
            .currentTheme.inputDecorationTheme.border,
      ),
    );
  }
}
//
//
//
//
//
class FormatterTextField extends StatelessWidget {
  const FormatterTextField(
      {Key? key,
        required this.cont,
        required this.hintText,
        required this.icon,
        required this.enable,
        required this.fieldLabel,
        required this.keyboard, required this.fillColor, required this.formatter})
      : super(key: key);

  final TextEditingController cont;
  final String hintText;
  final Widget icon;
  final bool enable;
  final String fieldLabel;
  final TextInputType keyboard;
  final Color fillColor;
  final FilteringTextInputFormatter formatter;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Provider.of<ThemeProvider>(context)
          .currentTheme.textTheme.displayMedium,
      cursorColor: primaryColor,
      controller: cont,
      keyboardType: keyboard,
      inputFormatters: [formatter],
      enabled: enable,
      validator: (value) => validateField(value!, fieldLabel, context),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: icon,
        hintStyle: Provider.of<ThemeProvider>(context)
            .currentTheme.textTheme.displaySmall,
        filled: true,
        fillColor: fillColor,
        disabledBorder: Provider.of<ThemeProvider>(context)
            .currentTheme.inputDecorationTheme.disabledBorder,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
        border: Provider.of<ThemeProvider>(context)
            .currentTheme.inputDecorationTheme.border,
      ),
    );
  }
}