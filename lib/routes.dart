import 'package:flutter/widgets.dart';
import 'package:recetas/screens/home_screen.dart';
import 'package:recetas/screens/login_screen.dart';
import 'package:recetas/screens/start_screen.dart';
import 'package:recetas/screens/search_screen.dart';
import 'package:recetas/screens/register_screen.dart';
import 'package:recetas/screens/onboarding_screen.dart';



Map<String,WidgetBuilder>getApplicationRoutes(){
  return <String,WidgetBuilder>{
    '/onboarding':(BuildContext context) =>const OnBoardingScreen(),
    '/start':(BuildContext context) =>const StartScreen(),
    '/login':(BuildContext context) =>const LoginScreen(),
    '/register':(BuildContext context) =>const RegisterScreen(),
    '/home':(BuildContext context) => PrincipalScreen(),
    '/search':(BuildContext context) =>SearchScreen(),
  };
}