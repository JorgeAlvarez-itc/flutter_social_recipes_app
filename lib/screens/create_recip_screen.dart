import 'package:flutter/material.dart';

class CreateRecipScreen extends StatelessWidget {
  const CreateRecipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Publicar receta'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image(
                image: AssetImage('assets/images/your_image.jpg'),
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height / 5,
              ),
              SizedBox(height: 20.0),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Crear receta',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre de la receta',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el nombre de la receta';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              // Resto de los TextFormField para los demás campos del formulario
              // ...
              SizedBox(height: 10.0),
              DropdownButtonFormField<String>(
                value: categoriaValue,
                onChanged: (value) {
                  categoriaValue = value;
                },
                items: [
                  DropdownMenuItem<String>(
                    value: 'Categoria 1',
                    child: Text('Categoria 1'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Categoria 2',
                    child: Text('Categoria 2'),
                  ),
                  // Agrega más categorías según tus necesidades
                ],
                decoration: InputDecoration(
                  labelText: 'Categoría',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, selecciona una categoría';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Realiza las acciones para guardar la receta
                  }
                },
                child: Text('Guardar receta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
