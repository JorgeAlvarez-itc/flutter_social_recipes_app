import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:recetas/firebase/firebase_auth.dart';
import 'package:recetas/responsive/responsive.dart';
import 'package:recetas/widgets/awesomeDialog_widget.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController? txtEmailCont = TextEditingController();
  TextEditingController? txtUsernCont = TextEditingController();
  TextEditingController? txtPassCont = TextEditingController();
  Awesome awesome = Awesome();
  FirebaseAuthMethods authMethods = FirebaseAuthMethods();

  final _formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      try {
        authMethods
            .registerWithEmailAndPassword(
                email: txtEmailCont!.text,
                password: txtPassCont!.text,
                displayName: txtUsernCont!.text)
            .then((value) {
          if (value) {
            awesome
                .buildDialog(
                    context,
                    DialogType.success,
                    'Registro exitoso',
                    'Su cuenta ha sido registrada con exito!. Por favor verifique su correo antes de iniciar sesión.',
                    '/login',
                    AnimType.scale,
                    false)
                .show();
          }
        });
      } catch (e) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.scale,
          title: "Error",
          desc: e.toString(),
          btnOkOnPress: () {},
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Responsive(mobile: MobileRegister(context), tablet: LandscapeRegister(context) ,desktop:LandscapeRegister(context))
        ],
      ),
    );
  }

Scaffold MobileRegister(BuildContext context) {
    return Scaffold(
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            'https://images.pexels.com/photos/5060450/pexels-photo-5060450.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
            fit: BoxFit.cover,
            height: 270,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Create account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: txtUsernCont,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor ingresa un nombre de usuario';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: txtEmailCont,
                    decoration: const InputDecoration(
                      labelText: 'Email',
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
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: txtPassCont,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor ingresa una contraseña';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildGeneralbtn(),
                  const SizedBox(height: 10),
                  _buildFacebookbtn(),
                  const SizedBox(height: 10),
                  _buildGooglebtn(),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Have an account? ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Signin',
                          style: TextStyle(
                            fontSize: 16,
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
        ],
      ),
    ),
  );
  }

Scaffold LandscapeRegister(BuildContext context) {
    return Scaffold(
    body: SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  child: Image.network(
                    'https://images.pexels.com/photos/5060450/pexels-photo-5060450.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 1,
                    height:MediaQuery.of(context).size.height * 1,
                  ).blurred(blur: 2,blurColor: Colors.black),
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 90),
                    child: Image.network(
                      'https://images.pexels.com/photos/5060450/pexels-photo-5060450.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                      alignment: Alignment.center,
                      fit: BoxFit.contain,  
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Create account',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: txtUsernCont,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor ingresa un nombre de usuario';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: txtEmailCont,
                      decoration: const InputDecoration(
                        labelText: 'Email',
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
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: txtPassCont,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
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
            child:Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                      _buildGeneralbtn(),
                      const SizedBox(height: 10),
                      _buildFacebookbtn(),
                      const SizedBox(height: 10),
                      _buildGooglebtn(),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Have an account? ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Signin',
                              style: TextStyle(
                                fontSize: 16,
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
            )),
        ],
      ),
    ),
  );
  }


  Widget _buildGeneralbtn() {
    return SizedBox(
      width: double.infinity,
      child: SocialLoginButton(
        buttonType: SocialLoginButtonType.generalLogin,
        onPressed: () {
          _submitForm();
        },
        text: 'Signup',
        backgroundColor: Colors.orangeAccent,
        fontSize: 13,
        borderRadius: 30.0,
      ),
    );
  }

  Widget _buildFacebookbtn() {
    return SizedBox(
      width: double.infinity,
      child: SocialLoginButton(
        buttonType: SocialLoginButtonType.facebook,
        onPressed: () async{
          authMethods.signUpWithFacebook().then((value){
            if (value == 1) {
              awesome
                  .buildDialog(
                      context,
                      DialogType.success,
                      'Registro exitoso',
                      'Su cuenta se ha registrado por favor inicia sesion',
                      '/login',
                      AnimType.scale,
                      false)
                  .show();
            } else if (value == 2) {
              awesome
                  .buildDialog(
                      context,
                      DialogType.warning,
                      'La cuenta ya está registrada',
                      'Ya existe una cuenta registrada con este correo electronico, por favor inicie sesion',
                      '/login',
                      AnimType.bottomSlide,
                      false)
                  .show();
            } else {
              awesome
                  .buildDialog(
                      context,
                      DialogType.error,
                      'Ocurrio un error',
                      'Ocurrió un error al intentar realizar el registro',
                      '/register',
                      AnimType.bottomSlide,
                      false)
                  .show();
            }
          });
        },
        text: 'Continue with Facebook',
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
          authMethods.registerWithGoogle().then((value) {
            if (value == 1) {
              awesome
                  .buildDialog(
                      context,
                      DialogType.success,
                      'Registro exitoso',
                      'Su cuenta se ha registrado por favor inicia sesion',
                      '/login',
                      AnimType.scale,
                      false)
                  .show();
            } else if (value == 2) {
              awesome
                  .buildDialog(
                      context,
                      DialogType.warning,
                      'La cuenta ya está registrada',
                      'Ya existe una cuenta registrada con este correo electronico, por favor inicie sesion',
                      '/login',
                      AnimType.bottomSlide,
                      false)
                  .show();
            } else {
              awesome
                  .buildDialog(
                      context,
                      DialogType.error,
                      'Ocurrio un error',
                      'Ocurrió un error al intentar realizar el registro',
                      '/register',
                      AnimType.bottomSlide,
                      false)
                  .show();
            }
          });
        },
        text: 'Continue with Google',
        fontSize: 12,
        borderRadius: 30.0,
      ),
    );
  }
}
