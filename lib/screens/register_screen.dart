import 'package:flutter/material.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              'https://images.pexels.com/photos/5060450/pexels-photo-5060450.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
              fit: BoxFit.cover,
              height: 300,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Create account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildGeneralbtn(),
                  SizedBox(height: 10),
                  _buildFacebookbtn(),
                  SizedBox(height: 10),
                  _buildGooglebtn(),
                  SizedBox(height: 10),
                  _buildGitbtn(),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
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
                        child: Text(
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
          ],
        ),
      ),
    );
  }
  Widget _buildGeneralbtn(){
    return SizedBox(
      width: double.infinity,
      child: SocialLoginButton(
        buttonType: SocialLoginButtonType.generalLogin, 
        onPressed: (){},
        text: 'Signup',
        backgroundColor: Colors.orangeAccent,
        borderRadius: 30.0,
      ),
    );
  }
  Widget _buildFacebookbtn(){
    return SizedBox(
      width: double.infinity,
      child: SocialLoginButton(
        buttonType: SocialLoginButtonType.facebook,
        onPressed: (){},
        text: 'Continue with Facebook',
        borderRadius: 30.0,
      ),
    );
  }
  Widget _buildGooglebtn(){
    return SizedBox(
      width: double.infinity,
      child: SocialLoginButton(
        buttonType: SocialLoginButtonType.google,
        onPressed: (){},
        text: 'Continue with Google',
        borderRadius: 30.0,
      ),
    );
  }
  Widget _buildGitbtn(){
    return SizedBox(
      width: double.infinity,
      child: SocialLoginButton(
        buttonType: SocialLoginButtonType.github,
        onPressed: (){},
        text: 'Continue with GitHub',
        borderRadius: 30.0,
      ),
    );
  }
}
