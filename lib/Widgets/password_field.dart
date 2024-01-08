import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Constants/colors.dart';
import 'package:pryo_app/Constants/theme_data.dart';
import '../Functions/validator_function.dart';

class PasswordField extends StatefulWidget {
  const PasswordField(
      {Key? key,
        required this.cont,
        required this.hintText})
      : super(key: key);

  final TextEditingController cont;
  final String hintText;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool hidePassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Provider.of<ThemeProvider>(context)
          .currentTheme.textTheme.displayMedium,
      validator: (value) => validateField(value!, 'password', context),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofocus: false,
      controller: widget.cont,
      obscureText: !hidePassword,
      cursorColor: primaryColor,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: IconButton(
          icon: Icon(hidePassword
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined, color: Provider.of<ThemeProvider>(context)
              .currentTheme.iconTheme.color,),
          onPressed: () {
            setState(
                  () {
                hidePassword = !hidePassword;
              },
            );
          },
        ),
        hintStyle: Provider.of<ThemeProvider>(context)
            .currentTheme.textTheme.displaySmall,
        filled: true,
        fillColor: Provider.of<ThemeProvider>(context)
            .currentTheme.cardColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
        border: Provider.of<ThemeProvider>(context)
            .currentTheme.inputDecorationTheme.border,
      ),
    );
  }
}
