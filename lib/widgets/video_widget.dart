import 'package:flutter/material.dart';
import 'package:recetas/responsive/responsive.dart';

class VideoWidget extends StatelessWidget {
  const VideoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Responsive(mobile: MobileVideos(), tablet: LandscapeVideos() ,desktop: LandscapeVideos())
      ]),
    );
  }
}

class MobileVideos extends StatelessWidget {
  const MobileVideos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Card(
        elevation: 15,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.network(
                    'https://www.clara.es/medio/2023/01/08/receta-calabaza-rellena-bolonesa_c46f79f3_1280x853.jpg', // Aquí debes agregar la URL de la imagen del video
                    fit: BoxFit.cover,
                    height: 250,
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 50,
                    ),
                    onTap: (){},
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Titulo del Video',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Pequeña descripción del video',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LandscapeVideos extends StatelessWidget {
  const LandscapeVideos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        margin: EdgeInsets.only(bottom: 105),
        elevation: 15,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  'https://www.clara.es/medio/2023/01/08/receta-calabaza-rellena-bolonesa_c46f79f3_1280x853.jpg', // Aquí debes agregar la URL de la imagen del video
                  fit: BoxFit.cover,
                  //height: 250,
                ),
                GestureDetector(
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 50,
                  ),
                  onTap: (){},
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Titulo del Video',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Pequeña descripción del video',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
