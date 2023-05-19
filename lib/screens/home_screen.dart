import 'navigator/home.dart';
import 'package:get/get.dart';
import 'navigator/videos.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../controllers/bottomNav_controller.dart';
import 'package:recetas/screens/navigator/account.dart';
import 'package:recetas/screens/navigator/discover.dart';
import 'package:recetas/screens/navigator/favorites.dart';



class PrincipalScreen extends StatelessWidget {
  PrincipalScreen({Key? key});
  final BottomNavBarController _controller = Get.put(BottomNavBarController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
            index: _controller.currentIndex.value,
            children: [
              HomePage(),
              DiscoverPage(),
              FavScreen(),
              AccountScreen()
              // Agregar más widgets para cada sección
            ],
          )),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: _controller
              .currentIndex.value, // Observa el valor actual del índice
          onTap: _controller
              .changeTabIndex,
          selectedLabelStyle: TextStyle(color: Colors.black),
          unselectedLabelStyle: TextStyle(color: Colors.grey),// Cuando se toque un item, cambia el índice actual
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home,
                  color: _controller.currentIndex.value == 0
                      ? Colors.orangeAccent
                      : Colors
                          .grey), // Cambia el color del ícono según el índice actual
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore,
                  color: _controller.currentIndex.value == 1
                      ? Colors.orangeAccent
                      : Colors
                          .grey), // Cambia el color del ícono según el índice actual
              label: 'Discover',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite,
                  color: _controller.currentIndex.value == 2
                      ? Colors.orangeAccent
                      : Colors
                          .grey), // Cambia el color del ícono según el índice actual
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person,
                  color: _controller.currentIndex.value == 3
                      ? Colors.orangeAccent
                      : Colors
                          .grey), // Cambia el color del ícono según el índice actual
              label: 'User',
            ),
          ],
        ),
      ),
    );
  }
}
