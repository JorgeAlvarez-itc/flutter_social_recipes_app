import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recetas/firebase/firebase_db.dart';
import 'package:recetas/models/suggest_model.dart';
import 'package:recetas/responsive/responsive.dart';
import 'package:recetas/widgets/loading_widget.dart';
import 'package:recetas/widgets/card_recipe_widget.dart';
import 'package:recetas/controllers/discover_controller.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final UserCredential userCredential = args['user'] as UserCredential;
    return Container(
      child: Responsive(
          mobile: DiscoverMobile(
            userCredential: userCredential,
          ),
          tablet: DiscoverLandscape(
            userCredential: userCredential,
          ),
          desktop: DiscoverLandscape(
            userCredential: userCredential,
          )),
    );
  }
}

class DiscoverMobile extends StatelessWidget {
  DiscoverMobile({super.key, this.userCredential});
  UserCredential? userCredential;
  DatabaseFirebase _dbSuggest = DatabaseFirebase(3);
  DatabaseFirebase _dbReci = DatabaseFirebase(0);
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
      body: StreamBuilder(
        stream: _dbSuggest.getSuggestCategories(userCredential!.user!.uid),
        builder: (context, snapshot) {
          SuggestModel aux =
              SuggestModel.fromQuerySnapshot(snapshot.data!.docs[0]);
          return FutureBuilder(
              future: aux.categorias!.isNotEmpty
                  ? _dbReci.getAllRecipSuggest(aux.categorias)
                  : _dbReci.getAllRecipes(),
              builder: (context, recetas) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 3,
                  controller: ScrollController(initialScrollOffset: 2),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          CardRecipeWidget(recipeModel: recetas.data![index]),
                    );
                  },
                );
              });
        },
      ),
    );
  }
}

class DiscoverLandscape extends StatelessWidget {
  DiscoverLandscape({
    super.key,
    required this.userCredential,
  });
  UserCredential? userCredential;
  DatabaseFirebase _dbSuggest = DatabaseFirebase(3);
  DatabaseFirebase _dbReci = DatabaseFirebase(0);

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
      body: StreamBuilder(
        stream: _dbSuggest.getSuggestCategories(userCredential!.user!.uid),
        builder: (context, snapshot) {
          SuggestModel aux =
              SuggestModel.fromQuerySnapshot(snapshot.data!.docs[0]);
          return FutureBuilder(
              future: aux.categorias!.isNotEmpty
                  ? _dbReci.getAllRecipSuggest(aux.categorias)
                  : _dbReci.getAllRecipes(),
              builder: (context, recetas) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 3,
                  controller: ScrollController(initialScrollOffset: 2),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 300, // Ancho deseado para la tarjeta
                        child:
                            CardRecipeWidget(recipeModel: recetas.data![index]),
                      ),
                    );
                  },
                );
              });
        },
      ),
    );
  }
}
