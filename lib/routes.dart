import 'package:flutter/widgets.dart';
import 'package:recetas/screens/home_screen.dart';
import 'package:recetas/screens/list_recipes_screen.dart';
import 'package:recetas/screens/login_screen.dart';
import 'package:recetas/screens/start_screen.dart';
import 'package:recetas/screens/search_screen.dart';
import 'package:recetas/screens/register_screen.dart';
import 'package:recetas/screens/list_owner_recips.dart';
import 'package:recetas/screens/onboarding_screen.dart';
import 'package:recetas/screens/create_recip_screen.dart';
import 'package:recetas/screens/edit_profile_srcreen.dart';
import 'package:recetas/widgets/details_recipe_widget.dart';



Map<String,WidgetBuilder>getApplicationRoutes(){
  return <String,WidgetBuilder>{
    '/onboarding':(BuildContext context) =>const OnBoardingScreen(),
    '/start':(BuildContext context) =>const StartScreen(),
    '/login':(BuildContext context) =>const LoginScreen(),
    '/register':(BuildContext context) =>const RegisterScreen(),
    '/home':(BuildContext context) => PrincipalScreen(),
    '/search':(BuildContext context) =>SearchScreen(),
    '/edit':(BuildContext context) => EditProfileScreen(),
    '/own':(BuildContext context) => ListOwnRecipes(),
    '/create':(BuildContext context) => CreateRecipScreen(),
    '/details':(BuildContext context) => DetailsRecipeScreen(),
    '/listall':(BuildContext context) => ListAllrecipes(),
  };
}