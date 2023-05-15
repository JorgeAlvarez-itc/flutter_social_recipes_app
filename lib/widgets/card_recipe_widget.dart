import 'package:flutter/material.dart';

class CardRecipeWidget extends StatelessWidget {
  const CardRecipeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(15.0),
              ),
              child: Image.network('https://www.cocinacaserayfacil.net/wp-content/uploads/2019/11/Recetas-de-carnes.jpg',
                fit: BoxFit.contain,
                width: MediaQuery.of(context).size.width * 0.94,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.access_time, color: Colors.grey),
                    SizedBox(width: 4.0),
                    Text(
                      '45 minutes',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Icon(Icons.fireplace, color: Colors.grey),
                    SizedBox(width: 4.0),
                    Text(
                      '155 cal',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Icon(Icons.favorite_border, color: Colors.grey),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
            child: Text(
              'NOMBRE DE LA RECETA',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
