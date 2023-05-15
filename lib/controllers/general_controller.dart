import 'package:get/get.dart';

class GeneralController extends GetxController {
  var isLoading=false.obs;
  var categoriaValue=''.obs;

  void changeLoadingView(){
    isLoading(!isLoading.value);
    update();
  }
}