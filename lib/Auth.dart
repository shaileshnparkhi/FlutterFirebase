import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseAuth {
  Future<String> signIn(String email, String password);
  Future<String> signUp(String email, String password);
  Future<String> getCurrentUser();
  Future<bool> checkLoggedIn();
  Future<void> setLoggedIn();
  Future<void> signOut();
  Future<void> sendPasswordResetEmail(String email);
}

class Auth implements BaseAuth {

  Future<bool> checkLoggedIn() async{
    SharedPreferences prefs =  await SharedPreferences.getInstance();
    var isLoggedIn = prefs.getBool('loggedIn');
    if (isLoggedIn != null && isLoggedIn){
      return true;
    }else{
      return false;
    }

  }

  Future<void> setLoggedIn() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('loggedIn', true);

  }

  Future<void> sendPasswordResetEmail(String email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return user.uid;
  }

  Future<String> signUp(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return user.uid;
  }

  Future<String> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.email;
  }

  Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('loggedIn', false);

    return _firebaseAuth.signOut();

  }


}