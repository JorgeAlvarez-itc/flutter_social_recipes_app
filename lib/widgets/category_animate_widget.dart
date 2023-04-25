import 'package:flutter/material.dart';

class CategoryWidgetAnim extends StatelessWidget {
  const CategoryWidgetAnim({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: Card(
        child: Center(
          child: Text('Categoria nombre'),
        ),
      ),
    );
  }
}