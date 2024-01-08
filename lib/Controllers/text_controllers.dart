import 'package:flutter/material.dart';
import 'package:get/get.dart';


class TextController extends GetxController{
  Rx<TextEditingController> searchBar = TextEditingController().obs;

  Rx<TextEditingController> editFullName = TextEditingController().obs;
  Rx<TextEditingController> editMail = TextEditingController().obs;
  Rx<TextEditingController> editPhone = TextEditingController().obs;
  Rx<TextEditingController> editAddress = TextEditingController().obs;
  Rx<TextEditingController> editCity = TextEditingController().obs;
  Rx<TextEditingController> editPassword = TextEditingController().obs;
  Rx<TextEditingController> editBio = TextEditingController().obs;

}