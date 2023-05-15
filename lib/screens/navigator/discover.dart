import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:recetas/responsive/responsive.dart';
import 'package:recetas/widgets/card_recipe_widget.dart';
import 'package:recetas/controllers/discover_controller.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Responsive(mobile: DiscoverMobile(), tablet: DiscoverLandscape(), desktop: DiscoverLandscape()),
    );
  }
}

class DiscoverMobile extends StatelessWidget {
  const DiscoverMobile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Discover',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
          textAlign: TextAlign.start,
        ),
        actions: [
          IconButton(
            color: Colors.orangeAccent,
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 3,
        controller: ScrollController(initialScrollOffset: 2),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CardRecipeWidget(),
          );
        },
      ),
    );
  }
}

class DiscoverLandscape extends StatelessWidget {
  const DiscoverLandscape({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Discover',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
          textAlign: TextAlign.start,
        ),
        actions: [
          IconButton(
            color: Colors.orangeAccent,
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 3,
        controller: ScrollController(initialScrollOffset: 2),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child:SizedBox(
              width: 300, // Ancho deseado para la tarjeta
              child: CardRecipeWidget(),
            ),
          );
        },
      ),
    );
  }
}
