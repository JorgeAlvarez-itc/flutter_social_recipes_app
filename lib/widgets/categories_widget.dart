import 'package:flutter/material.dart';
import 'package:recetas/models/category_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CategoryWidget extends StatelessWidget {
  CategoryWidget({super.key, required this.categoryModel});
  CategoryModel? categoryModel;
  @override
  Widget build(BuildContext context) {
   return Card(
  child: GestureDetector(
    onTap: (){},
    child: Column(
      children: [
        CachedNetworkImage(
          imageUrl:categoryModel!.urlFoto.toString(),
          width: 120,
          height: 100,
          fit: BoxFit.cover,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Text(categoryModel!.categoria.toString()),
      ],
    ),
  ),
);
  }
}
