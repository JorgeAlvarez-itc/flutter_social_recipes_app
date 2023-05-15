import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
   final FacebookAuth facebookAuth = FacebookAuth.instance;

  Future<bool> registerWithEmailAndPassword(
      {required String email,
      required String password,
      required String displayName}) async {
    try {
      String passEncrypt = md5.convert(utf8.encode(password)).toString();
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: passEncrypt);
      final AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: passEncrypt);
      userCredential.user!.updateDisplayName(displayName);
      //userCredential.user!.linkWithCredential(credential);
      userCredential.user!.reload();
      userCredential.user!.sendEmailVerification();
      print('User registered: ${userCredential.user}');
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return false;
    }
  }

  Future<UserCredential> updateProfilePhoto({
    required UserCredential usuario,
    required String url,
    required String pass,
  }) async {
    try {
      print(pass.toString());
      await usuario.user!.updatePhotoURL(url);
      await usuario.user!.reload();
      UserCredential? userUpdated = await signInWithEmailAndPassword(email: usuario.user!.email.toString(), password: pass.toString());
      return userUpdated!;
    } catch (e) {
      print(e);
      return usuario;
    }
  }

  Future<UserCredential?> signInWithCredential(
      AuthCredential? credential) async {
    try {
      print(credential);
      if (credential != null) {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        return userCredential;
      } else {
        return null;
      }
    } catch (e) {
      print('Error signing in with credential: $e');
      return null;
    }
  }

  Future<UserCredential?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      var cred =
          EmailAuthProvider.credentialWithLink(email: email, emailLink: email);
      print('User logged in: ${userCredential.user}');
      //userCredential.user!.linkWithCredential(cred);
      //print(cred);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return null;
    }
  }

  Future<bool> sendEmailVerification(User user) async {
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      return true;
    }
    return false;
  }

  Future<bool> recoverPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    this.signOut();
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<int> registerWithGoogle() async {
    this.signOut();
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: googleUser.email,
        password: googleAuth.accessToken.toString(),
      );
      await userCredential.user!.linkWithCredential(credential);
      userCredential.user!.sendEmailVerification();
      return 1;
    } catch (e) {
      if (e.toString().contains('already')) {
        return 2;
      } else {
        return 3;
      }
    }
  }

  
  Future<UserCredential?> signInWithFacebook() async {
    this.signOut();
    try {
      final LoginResult result = await facebookAuth.login();
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final OAuthCredential credential =
            FacebookAuthProvider.credential(accessToken.token);
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        print('User login: ${userCredential.user}');
       
        return userCredential;
      } else {
        return null;
      }
    } catch (e) {
        return null;
    }
  }

  Future<int> signUpWithFacebook() async {
    this.signOut();
    try {
      final LoginResult result = await facebookAuth.login();

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final OAuthCredential credential =
            FacebookAuthProvider.credential(accessToken.token);

        // Creating a Firebase user with email and password
        final UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: accessToken.userId +
              '@facebook.com', // Using the Facebook user ID as email
          password:
              accessToken.token, // Using the Facebook access token as password
        );
        // Linking the Facebook credential to the Firebase user
        await userCredential.user!.linkWithCredential(credential);
        return 1;
      } else {
        return 3;
      }
    } catch (e) {
      if(e.toString().contains('already')){
        return 2;
      }else{
        return 3;
      }
    }
  }



  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await facebookAuth.logOut();
      await _auth.signOut();
    } catch (e) {}
  }
}
