import 'package:get/get.dart';

class BottomNavBarController extends GetxController {
  var currentIndex = 0.obs; // El índice actual, inicializado en 0

  void changeTabIndex(int index) {
    currentIndex.value = index; // Cambia el valor del índice actual
  }
}
