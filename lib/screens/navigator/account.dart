import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:recetas/settings/theme_settings.dart';
import 'package:recetas/widgets/awesomeDialog_widget.dart';
import 'package:day_night_switcher/day_night_switcher.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String? password;
    ThemeSettings themeSettings= ThemeSettings();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final isEmailAccount = args['isEmailAccount'] ?? false;
    final UserCredential userCredential = args['user'] as UserCredential;
    if (args['password'] != null) {
      password = args['password'] as String;
    }
    Awesome awesome = Awesome();
    return Scaffold(
  body: Stack(
    children: [
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://images.pexels.com/photos/103124/pexels-photo-103124.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
            ),
            fit: BoxFit.cover, 
          ),
        ),
      ),
      SafeArea(
        child: SingleChildScrollView( // Agregamos SingleChildScrollView aquí
          child: Column(
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  userCredential.user!.providerData[0].photoURL != null
                      ? userCredential.user!.providerData[0].photoURL.toString()
                      : 'https://cadrre.org/wp-content/uploads/2018/04/social-hub-profile-default.jpg',
                ),
              ),
              SizedBox(height: 10),
              Text(
                userCredential.user!.providerData[0].displayName.toString().toUpperCase(),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5),
              Text(
                userCredential.user!.providerData[0].email.toString().toUpperCase(),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 50),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: themeSettings.isSaveDarkMode() ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Editar perfil'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.pushNamed(context, '/edit', arguments: {
                          'user': userCredential,
                          'isEmailAccount': isEmailAccount,
                          'pass': password,
                        });
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.microwave_outlined),
                      title: Text('Mis recetas'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.pushNamed(context, '/own', arguments: {
                          'user': userCredential,
                        });
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('Administrar sugerencias'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.pushNamed(context, '/admon', arguments: {
                          'user': userCredential,
                        });
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('Salir'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        awesome
                            .buildDialog(
                              context,
                              DialogType.infoReverse,
                              'Confirmar',
                              '¿Realmente desea cerrar la sesión?',
                              '/onboarding',
                              AnimType.bottomSlide,
                              true,
                            )
                            .show()
                            .then((value) {
                          print(value);
                        });
                      },
                    ),
                    Divider(),
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 35),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Tema: ', style: TextStyle(fontSize: 15)),
                            DayNightSwitcher(
                              isDarkModeEnabled: themeSettings.isSaveDarkMode(),
                              onStateChanged: (isDarkModeEnabled) async {
                                await themeSettings.changeThemeMode(isDarkModeEnabled);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20), // Agregamos un espacio al final para evitar recorte en el contenido inferior
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
);
;
  }
}
