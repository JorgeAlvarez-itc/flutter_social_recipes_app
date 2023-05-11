import 'dart:io';
import 'package:get/get.dart';

class AccountController extends GetxController {
  var isImage = Rx<File?>(null);
  
  void updateImage(File newImage) {
    isImage.value = newImage;
  }
}
