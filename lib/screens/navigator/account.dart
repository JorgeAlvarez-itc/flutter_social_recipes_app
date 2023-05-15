import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:recetas/widgets/awesomeDialog_widget.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? password;
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final isEmailAccount = args['isEmailAccount'] ?? false;
    final UserCredential userCredential = args['user'] as UserCredential;
    if(args['password']!=null){
      password= args['password'] as String;
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
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(0.2),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    userCredential.user!.providerData[0].photoURL != null
                        ? userCredential.user!.providerData[0].photoURL
                            .toString()
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
                SizedBox(height: 20),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        ListTile(
                          leading: Icon(Icons.person),
                          title: Text('Edit profile'),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.pushNamed(context, '/edit', arguments: {
                              'user': userCredential,
                              'isEmailAccount': isEmailAccount,
                              'pass':password,
                            });
                          },
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.microwave_outlined),
                          title: Text('My recipes'),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: (){
                            Navigator.pushNamed(context, '/own', arguments: {
                              'user': userCredential,
                            });
                          },
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.logout),
                          title: Text('Logout'),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            awesome
                                .buildDialog(
                                    context,
                                    DialogType.infoReverse,
                                    'Confirmar',
                                    '¿Realmente desea cerrar la sesión?',
                                    '/oboarding',
                                    AnimType.bottomSlide,
                                    true)
                                .show()
                                .then((value) {
                              print(value);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
