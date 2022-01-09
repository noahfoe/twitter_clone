import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/models/user.dart';
import 'package:twitter_clone/screens/auth/signin.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  late String message = "";

  UserModel _userFromFirebaseUser(User? user) {
    return UserModel(
        id: user!.uid,
        bannerImage:
            "https://www.matildastory.com/wp-content/uploads/2019/08/Twitter-Header-Turquoise-001.png",
        profileImage:
            "https://blog.dlvrit.com/wp-content/uploads/Twitter-Egg-300x300.jpeg");
  }

  Stream<UserModel> get user {
    return auth.authStateChanges().map((user) => _userFromFirebaseUser(user!));
  }

  Stream<User?> get authStateChanges => auth.authStateChanges();

  Future signInAction(
      String email, String password, BuildContext context) async {
    try {
      User? user = (await auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      _userFromFirebaseUser(user);
      context.goNamed('home');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        message = "The password provided is incorrect.";
      } else if (e.code == 'user-not-found') {
        message = "An account with that email does not exist.";
      }
    } catch (e) {
      message = "An unexpected error has occurred.";
    }
  }

  Future signUpAction(String email, String password, String username,
      BuildContext context) async {
    try {
      UserCredential userCred = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCred.user!.uid)
          .set({
        'name': userCred.user!.uid,
        'email': email,
        'username': username
      });
      _userFromFirebaseUser(userCred.user);
      context.goNamed('home');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        message = "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        message = "The account already exists for that email.";
      }
    } catch (e) {
      message = "An unexpected error has occured.";
    }
  }

  Future signOutAction(context) async {
    try {
      await auth.signOut();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Signin()));
    } catch (e) {
      message = "An unexpected error has occurred.";
      return null;
    }
  }
}
