import 'package:flutter/material.dart';
import '../../Constants/colors.dart';

class LanguageDropdown extends StatelessWidget {
  const LanguageDropdown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 40,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: whiteColor,
          border: Border.all(color: Colors.white)),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          fillColor: whiteColor,
          iconColor: primaryColor,
          prefixIconColor: primaryColor,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          contentPadding: const EdgeInsets.only(left: 20, top: 10),
        ),
        items: [
          DropdownMenuItem(
              value: 'English',
              child: SizedBox( width: 15,
                child: ListTile(
                  leading: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(500),
                        image: const DecorationImage(
                            image: AssetImage('assets/images/english.png'))),
                  ),
                  title: const Text(
                    'Eng',
                    style: TextStyle(fontSize: 10, color: blackColor), maxLines: 1,
                  ),
                ),
              ),
          ),
          DropdownMenuItem(
            value: 'Yesterday',
            child: Text(
              'Yesterday',
              style: TextStyle(fontSize: 15, color: blackColor),
            ),
          ),
          DropdownMenuItem(
            value: 'Custom',
            child: Text(
              'Custom',
              style: TextStyle(fontSize: 15, color: blackColor),
            ),
          ),
        ],
        onChanged: (String? value) {},
      ),
    );
  }
}
