import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<bool> registerWithEmailAndPassword(
  {required String email,
  required String password,
  required String displayName}) async {
  try {
    final UserCredential userCredential = await _auth
        .createUserWithEmailAndPassword(email: email, password: password);
    final AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: password);
    userCredential.user!.updateDisplayName(displayName);
    userCredential.user!.linkWithCredential(credential);
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
  }) async {
    try {
      await usuario.user!.updatePhotoURL(url);
      await usuario.user!.reload();
      print(usuario);
      //await _auth.signInWithCredential(usuario! as AuthCredential);
      return usuario;
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
      print('User logged in: ${userCredential.user}');
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

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {}
  }
}
