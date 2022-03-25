import 'package:firebase_auth/firebase_auth.dart';

class Authenticator {
   static final FirebaseAuth _auth= FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.idTokenChanges();

  static Future<String> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return ("logged in");
    } catch (e) {
      return e.toString();
    }
  }
  static Future<String>  signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return ("Signed Up");
    } catch (e) {
      return e.toString();
    }
  }
}