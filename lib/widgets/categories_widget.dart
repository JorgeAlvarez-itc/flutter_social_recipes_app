import 'package:flutter/material.dart';
import 'package:recetas/models/category_model.dart';

class CategoryWidget extends StatelessWidget {
  CategoryWidget({super.key, this.categoryModel});
  CategoryModel? categoryModel;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(
            'https://images.pexels.com/photos/4261844/pexels-photo-4261844.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
            width: 120,
            height: 100,
            fit: BoxFit.cover,
          ),
          Text('Category name'),
        ],
      ),
    );
  }
}
