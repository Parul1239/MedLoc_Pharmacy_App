import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

abstract class BaseAuth{
  Future<String> signInWithEmailAndPassword(String email,String password);
  Future<String> createUserWithEmailAndPassword(String email,String password);
  Future<String> currentUser();
  Future sendPasswordResetEmail(String email);
  Future<void> signOut();
  Future<String> getCurrentUserEmail();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final firestoreInstance = Firestore.instance;

  Future<String> signInWithEmailAndPassword(String email,
      String password) async {
    FirebaseUser user = (await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password)).user;

    if (user.isEmailVerified) {
      return user.uid;
    }
    return user.email;
  }

  Future<String> createUserWithEmailAndPassword(String email,
      String password) async {
    FirebaseUser user = (await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user;
    try {
      await user.sendEmailVerification();
      return user.uid;
    } catch (e) {
      print("An error occured while trying to send email verification");
      print(e.message);
    }
  }

  Future sendPasswordResetEmail(String email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }


  Future<String> currentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.uid;
}

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<String> getCurrentUserEmail() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    final String email = user.email.toString();
    print(email);
    return email;
  }

}





