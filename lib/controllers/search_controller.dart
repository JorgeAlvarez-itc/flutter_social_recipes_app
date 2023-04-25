import 'package:get/get.dart';

class SearchController extends GetxController {
  var isSearching=false.obs;

  void changeisSearching(){
    isSearching(!isSearching.value);
    update();
  }

}