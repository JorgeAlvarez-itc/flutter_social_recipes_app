import 'package:flutter/material.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                color: Colors.white,
              ),
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Welcome back',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Email address',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 32),
                  _buildGeneralbtn(context),
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
                      Text('Don\'t have an account? '),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Text(
                          'Sign up',
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
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
  Widget _buildGeneralbtn(BuildContext context){
    return SizedBox(
      width: double.infinity,
      child: SocialLoginButton(
        buttonType: SocialLoginButtonType.generalLogin, 
        onPressed: (){
          Navigator.pushNamed(context, '/home');
        },
        text: 'Login',
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
