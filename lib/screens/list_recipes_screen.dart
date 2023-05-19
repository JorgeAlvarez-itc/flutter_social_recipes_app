import 'package:flutter/material.dart';
import 'package:recetas/models/favs_model.dart';
import 'package:recetas/firebase/firebase_db.dart';
import 'package:recetas/widgets/recipe_widget.dart';
import 'package:recetas/widgets/loading_widget.dart';

class ListRecipesScreen extends StatelessWidget {
  ListRecipesScreen({Key? key});
  DatabaseFirebase _firebaseFavs = DatabaseFirebase(2);
  Stream? stream;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Recetas',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: _firebaseFavs.getFavoriteRecipes('jtH17GWxEqh297XnSsGL6SU5tCl1'),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              FavsModel favsModel = FavsModel.fromQuerySnapshot(snapshot.data);
              _firebaseFavs.getRecipesFromIds(favsModel.recetas!).then((value) {
                if (value.isNotEmpty) {
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      RecipeWidget(recipeModel: value[index], docId: value[index].id!);
                    },
                  );
                } else {
                  return const LoadingWidget();
                }
              });
              return const LoadingWidget();
            } else if (snapshot.hasError) {
              return Text('Error al cargar los datos');
            } else {
              return const LoadingWidget();
            }
          },
        ),
      ),
    );
  }
}
