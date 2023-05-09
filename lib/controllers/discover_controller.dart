import 'package:get/get.dart';

class DiscoverController extends GetxController {
  RxString selectedMenuBarOption = "".obs;

  void selectMenuBarOption(String option) {
    selectedMenuBarOption.value = option;
  }
}
