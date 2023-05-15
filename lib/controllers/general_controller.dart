import 'package:get/get.dart';

class GeneralController extends GetxController {
  var isLoading=false.obs;

  void changeLoadingView(){
    isLoading(!isLoading.value);
    update();
  }
}