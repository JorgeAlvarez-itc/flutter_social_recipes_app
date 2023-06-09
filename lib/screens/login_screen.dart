import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:recetas/responsive/responsive.dart';
import 'package:recetas/firebase/firebase_auth.dart';
import 'package:recetas/settings/account_setting.dart';
import 'package:recetas/controllers/home_controller.dart';
import 'package:recetas/widgets/awesomeDialog_widget.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController? txtEmailCont = TextEditingController();
  TextEditingController? txtPassCont = TextEditingController();
  Awesome awesome = Awesome();
  FirebaseAuthMethods authMethods = FirebaseAuthMethods();
  AccountSettings accountSettings = AccountSettings();
  final _formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      authMethods.signOut();
      String passEncrypt =
          md5.convert(utf8.encode(txtPassCont!.text)).toString();
      authMethods
          .signInWithEmailAndPassword(
              email: txtEmailCont!.text, password: passEncrypt.toString())
          .then((value) {
        if (value != null) {
          User aux = value.user!;
          if (aux.emailVerified) {
            accountSettings.saveCredentials(
                true, value, passEncrypt.toString());
            Navigator.pushNamed(context, '/home', arguments: {
              'user': value,
              'isEmailAccount': true,
              'password': passEncrypt.toString(),
            });
            
          } else {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.warning,
              animType: AnimType.scale,
              title: "Error",
              desc: "Por favor verifica tu correo electronico",
              btnOkText: 'Reenviar correo de verificacion',
              btnOkOnPress: () async {
                await authMethods.sendEmailVerification(aux).then((value) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.rightSlide,
                    title: "Correo enviado con éxito",
                    desc:
                        "El correo de verificación ha sido enviado con éxito, por favor verifique su bandeja de entrada",
                    btnOkOnPress: () {},
                    btnOkColor: Colors.green,
                  ).show();
                });
              },
              btnOkColor: Colors.orangeAccent,
            ).show();
          }
        } else {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.scale,
            title: "Error",
            desc: "Por favor verifica que los datos ingresados sean correctos",
            btnOkOnPress: () {},
            btnOkColor: Colors.orangeAccent,
          ).show();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Responsive(
              mobile: MobileLogin(context),
              tablet: LandscapeLogin(context),
              desktop: LandscapeLogin(context))
        ],
      ),
    );
  }

  Scaffold MobileLogin(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              'https://images.pexels.com/photos/6605302/pexels-photo-6605302.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
              fit: BoxFit.cover,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            SizedBox(height: 32),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white12,
              ),
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Bienvenido',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: txtEmailCont,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        final emailRegExp =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (!emailRegExp.hasMatch(value.toString())) {
                          return 'Por favor ingresa un correo electrónico válido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: txtPassCont,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Contraseña',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor ingresa una contraseña';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    _buildGeneralbtn(context),
                    const SizedBox(height: 10),
                    _buildFacebookbtn(),
                    const SizedBox(height: 10),
                    _buildGooglebtn(),
                    const SizedBox(height: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('¿Olvidaste tu contraseña?'),
                        TextButton(
                          onPressed: () {
                            _buildDialogRecover(context);
                          },
                          child: const Text(
                            'Envía correo para recuperar',
                            style: TextStyle(
                              color: Colors.orangeAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('¿No tienes cuenta?'),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: const Text(
                            'Registrar ahora!',
                            style: TextStyle(
                              color: Colors.orangeAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Scaffold LandscapeLogin(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                // Ajusta el factor de escala según tus necesidades
                child: Image.network(
                  'https://images.pexels.com/photos/6605302/pexels-photo-6605302.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white12,
                ),
                margin: EdgeInsets.only(right: 15, left: 15, bottom: 130),
                //padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Bienvenido',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: txtEmailCont,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          final emailRegExp =
                              RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (!emailRegExp.hasMatch(value.toString())) {
                            return 'Por favor ingresa un correo electrónico válido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: txtPassCont,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Contraseña',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor ingresa una contraseña';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 5),
                  _buildGeneralbtn(context),
                  const SizedBox(height: 10),
                  _buildFacebookbtn(),
                  const SizedBox(height: 10),
                  _buildGooglebtn(),
                  const SizedBox(height: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('¿Olvidaste tu contraseña?'),
                      TextButton(
                        onPressed: () {
                          _buildDialogRecover(context);
                        },
                        child: const Text(
                          'Enviar correo para recuperar',
                          style: TextStyle(
                            color: Colors.orangeAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('¿No tienes cuenta?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: const Text(
                          'Registrar ahora!',
                          style: TextStyle(
                            color: Colors.orangeAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ))
            //const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildGeneralbtn(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SocialLoginButton(
        buttonType: SocialLoginButtonType.generalLogin,
        onPressed: () {
          _submitForm();
        },
        text: 'Iniciar sesión',
        backgroundColor: Colors.orangeAccent,
        borderRadius: 30.0,
      ),
    );
  }

  Widget _buildFacebookbtn() {
    return SizedBox(
      width: double.infinity,
      child: SocialLoginButton(
        buttonType: SocialLoginButtonType.facebook,
        onPressed: () {
          authMethods.signInWithFacebook().then((value) {
            if (value != null) {
              accountSettings.saveCredentials(false, value, null);
              Navigator.pushNamed(context, '/home', arguments: {
                'user': value,
                'isEmailAccount': false,
              });
             
            } else {}
          });
        },
        text: 'Continuar con Facebook',
        fontSize: 12,
        borderRadius: 30.0,
      ),
    );
  }

  Widget _buildGooglebtn() {
    return SizedBox(
      width: double.infinity,
      child: SocialLoginButton(
        buttonType: SocialLoginButtonType.google,
        onPressed: () {
          authMethods.signInWithGoogle().then((value) {
            if (value != null) {
              accountSettings.saveCredentials(false, value, null);
              Navigator.pushNamed(context, '/home', arguments: {
                'user': value,
                'isEmailAccount': false,
              });
            } else {}
          });
        },
        text: 'Continuar con Google',
        fontSize: 12,
        borderRadius: 30.0,
      ),
    );
  }

  void _buildDialogRecover(BuildContext context) {
    final _formKeyRec = GlobalKey<FormState>();
    TextEditingController? txtEmailRecovCont = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Recuperar contraseña'),
          content: Form(
            key: _formKeyRec,
            child: TextFormField(
              controller: txtEmailRecovCont,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Introduce tu email',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor introduce tu correo';
                } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
                  return 'Introduce un email válido';
                }
                return null;
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                if (_formKeyRec.currentState!.validate()) {
                  authMethods
                      .recoverPassword(email: txtEmailRecovCont.text)
                      .then((value) {
                    if (value) {
                    } else {}
                  });
                }
              },
              child: const Text('Enviar correo'),
            ),
          ],
        );
      },
    );
  }
}
