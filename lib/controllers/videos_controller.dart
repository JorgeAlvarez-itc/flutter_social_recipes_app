import 'package:get/get.dart';

class VideosController extends GetxController {
  var isListView=true.obs;

  void changeListView(){
    isListView(!isListView.value);
    update();
  }
}