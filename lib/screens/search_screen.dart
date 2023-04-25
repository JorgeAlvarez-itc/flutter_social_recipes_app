import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../controllers/search_controller.dart';
import 'package:recetas/widgets/recipe_widget.dart';


class SearchScreen extends StatelessWidget {
  final SearchController _controller = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Search',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Expanded(
                    child: TextField(
                      onTap: () {
                        _controller.changeisSearching();
                      },
                      decoration: InputDecoration(
                        hintText: 'What would you like to search?',
                        filled: true,
                        fillColor: Colors.grey[200],
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Obx(
                () {
                  if (!_controller.isSearching.value) {
                    return Expanded(
                      child: ListView(
                        children: [
                          const SizedBox(height: 16.0),
                          const Text(
                            'Category Recipes',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          SizedBox(
                            height: 100.0,
                            child: ListView.builder(
                              itemCount: 5, // Reemplaza con la cantidad de categorías que desees mostrar
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Column(
                                    children: [
                                      Icon(Icons.category),
                                      const SizedBox(height: 8.0),
                                      Text('Category $index'),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ]
                      ),
                    );
                  } else {
                    return Expanded(
                      child: ListView(
                        children: [
                          const Text(
                            'Recipes',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          RecipeWidget(),
                          RecipeWidget(),
                          RecipeWidget(),
                          RecipeWidget(),
                          RecipeWidget(),
                          RecipeWidget(),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
