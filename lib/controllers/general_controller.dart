import 'dart:io';
import 'package:get/get.dart';


class GeneralController extends GetxController {
  var isLoading=false.obs;
  var categoriaValue=''.obs;
  var isImage = Rx<File?>(null);
  
  void updateImage(File newImage) {
    isImage.value = newImage;
  }

  void changeLoadingView(){
    isLoading(!isLoading.value);
    update();
  }
}