import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recetas/responsive/responsive.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key, this.user, this.isEmailAccount, this.pass});
  UserCredential? user;
  bool? isEmailAccount;
  String? pass;
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Scaffold(
        body: Responsive(
            mobile: OnBoardingMobile(),
            tablet: OnBoardingTablet(),
            //Desktop view
            desktop: OnBoardingTest()),
      ),
    );
  }
}

class OnBoardingDesktop extends StatelessWidget {
  const OnBoardingDesktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/onboarding1.jpeg'),
                fit: BoxFit.contain,
                alignment: Alignment.centerLeft,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.1),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 200),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText(
                          'Complete Recipe',
                          textStyle: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                      isRepeatingAnimation: true,
                    ),
                    Text(
                      'Best apps for see and follow all recipes and more than 200++ around the world',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class OnBoardingMobile extends StatelessWidget {
  const OnBoardingMobile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      scrollPhysics: BouncingScrollPhysics(),
      pages: [
        PageViewModel(
          titleWidget: AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText(
                'Recetas Fáciles al Instante',
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            isRepeatingAnimation: true,
          ),
          body: "Inspírate con recetas simples para tus comidas diarias",
          image: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/onboarding1.jpeg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.1),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
        ),
        PageViewModel(
          titleWidget: AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText(
                'Favoritos Personalizados',
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            isRepeatingAnimation: true,
          ),
          body:
              "Guarda tus recetas preferidas y accede a ellas en cualquier momento",
          image: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/onboarding2.jpeg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.1),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
        ),
        PageViewModel(
          titleWidget: AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText(
                'Explora y Descubre',
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            isRepeatingAnimation: true,
          ),
          body: 'Encuentra nuevas recetas basadas en tus gustos y preferencias',
          image: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/onboarding3.jpeg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.1),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
        ),
      ],
      onDone: () {
        Navigator.pushNamed(context, '/start');
      },
      onSkip: () {
        Navigator.pushNamed(context, '/start');
      },
      showSkipButton: true,
      next: Icon(
        Icons.arrow_forward,
        color: Colors.orangeAccent,
      ),
      skip: Text(
        'Saltar',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.orangeAccent),
      ),
      done: Text(
        'Comencemos',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.orangeAccent),
      ),
      dotsDecorator: DotsDecorator(
        size: Size.square(10.0),
        activeSize: Size(20.0, 10.0),
        color: Colors.black12,
        activeColor: Colors.orangeAccent,
        spacing: EdgeInsets.symmetric(horizontal: 3.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }
}

class OnBoardingTest extends StatelessWidget {
  const OnBoardingTest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      scrollPhysics: BouncingScrollPhysics(),
      pages: [
        PageViewModel(
          titleWidget: Row(
            children: [
              Expanded(
                child: SizedBox(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 180),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedTextKit(
                            animatedTexts: [
                              TyperAnimatedText(
                                'Recetas Fáciles al Instante',
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                            isRepeatingAnimation: true,
                          ),
                          Text(
                            'Inspírate con recetas simples para tus comidas diarias',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          image: Padding(
            padding: const EdgeInsets.only(top: 120),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 500,
                    blurRadius: 300,
                    offset: Offset(0, 9),
                  ),
                ],
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(2000),
              ),
              child: Transform.scale(
                scale: 2.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/onboarding1.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          body: "",
        ),
        PageViewModel(
          titleWidget: Row(
            children: [
              Expanded(
                child: SizedBox(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 180),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedTextKit(
                            animatedTexts: [
                              TyperAnimatedText(
                                'Favoritos Personalizados',
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                            isRepeatingAnimation: true,
                          ),
                          Text(
                            'Guarda tus recetas preferidas y accede a ellas en cualquier momento',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          image: Padding(
            padding: const EdgeInsets.only(top: 120),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 500,
                    blurRadius: 300,
                    offset: Offset(0, 9),
                  ),
                ],
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(2000),
              ),
              child: Transform.scale(
                scale: 2.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/onboarding2.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          body: "",
        ),
        PageViewModel(
          titleWidget: Row(
            children: [
              Expanded(
                child: SizedBox(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 180),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedTextKit(
                            animatedTexts: [
                              TyperAnimatedText(
                                'Explora y Descubre',
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                            isRepeatingAnimation: true,
                          ),
                          Text(
                            'Encuentra nuevas recetas basadas en tus gustos y preferencias',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          image: Padding(
            padding: const EdgeInsets.only(top: 120),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 500,
                    blurRadius: 300,
                    offset: Offset(0, 9),
                  ),
                ],
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(2000),
              ),
              child: Transform.scale(
                scale: 2.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/onboarding3.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          body: "",
        ),
      ],
      onDone: () {
        Navigator.pushNamed(context, '/start');
      },
      onSkip: () {
        Navigator.pushNamed(context, '/start');
      },
      showSkipButton: true,
      next: Icon(
        Icons.arrow_forward,
        color: Colors.orangeAccent,
      ),
      skip: Text(
        'Saltar',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.orangeAccent),
      ),
      done: Text(
        'Comencemos',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.orangeAccent),
      ),
      dotsDecorator: DotsDecorator(
        size: Size.square(10.0),
        activeSize: Size(20.0, 10.0),
        color: Colors.black12,
        activeColor: Colors.orangeAccent,
        spacing: EdgeInsets.symmetric(horizontal: 3.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }
}

class OnBoardingTablet extends StatelessWidget {
  const OnBoardingTablet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      scrollPhysics: BouncingScrollPhysics(),
      pages: [
        PageViewModel(
          titleWidget: Row(
            children: [
              Expanded(
                child: SizedBox(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 35),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedTextKit(
                            animatedTexts: [
                              TyperAnimatedText(
                                'Recetas Fáciles al Instante',
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                            isRepeatingAnimation: true,
                          ),
                          Text(
                            'Inspírate con recetas simples para tus comidas diarias',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          image: Padding(
            padding: const EdgeInsets.only(top: 55),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 100,
                    blurRadius: 150,
                    offset: Offset(0, 9),
                  ),
                ],
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(2000),
              ),
              child: Transform.scale(
                scale: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/onboarding1.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          body: "",
        ),
        PageViewModel(
          titleWidget: Row(
            children: [
              Expanded(
                child: SizedBox(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 35),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedTextKit(
                            animatedTexts: [
                              TyperAnimatedText(
                                'Favoritos Personalizados',
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                            isRepeatingAnimation: true,
                          ),
                          Text(
                            'Guarda tus recetas preferidas y accede a ellas en cualquier momento',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          image: Padding(
            padding: const EdgeInsets.only(top: 55),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 150,
                    blurRadius: 300,
                    offset: Offset(0, 9),
                  ),
                ],
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(2000),
              ),
              child: Transform.scale(
                scale: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/onboarding2.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          body: "",
        ),
        PageViewModel(
          titleWidget: Row(
            children: [
              Expanded(
                child: SizedBox(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 35),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedTextKit(
                            animatedTexts: [
                              TyperAnimatedText(
                                'Explora y Descubre',
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                            isRepeatingAnimation: true,
                          ),
                          Text(
                            'Encuentra nuevas recetas basadas en tus gustos y preferencias',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          image: Padding(
            padding: const EdgeInsets.only(top: 55),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 150,
                    blurRadius: 150,
                    offset: Offset(0, 9),
                  ),
                ],
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(2000),
              ),
              child: Transform.scale(
                scale: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/onboarding2.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          body: "",
        ),
      ],
      onDone: () {
        Navigator.pushNamed(context, '/start');
      },
      onSkip: () {
        Navigator.pushNamed(context, '/start');
      },
      showSkipButton: true,
      next: Icon(
        Icons.arrow_forward,
        color: Colors.orangeAccent,
      ),
      skip: Text(
        'Saltar',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.orangeAccent),
      ),
      done: Text(
        'Comencemos',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.orangeAccent),
      ),
      dotsDecorator: DotsDecorator(
        size: Size.square(10.0),
        activeSize: Size(20.0, 10.0),
        color: Colors.black12,
        activeColor: Colors.orangeAccent,
        spacing: EdgeInsets.symmetric(horizontal: 3.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }
}
