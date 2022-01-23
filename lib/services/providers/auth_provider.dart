import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  createEmailAndPassword(
      {required String email,
      required String password,
      BuildContext? context}) async {
    try {
      _auth.createUserWithEmailAndPassword(email: email, password: password);
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(
          context: context!,
          text: 'The password provided is too weak.',
        );
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(
          context: context!,
          text: 'The account already exists for that email.',
        );
      }
    } catch (e) {
      showSnackBar(
        context: context!,
        text: 'There was an error.',
      );
    }
    showSnackBar(context: context!, text: 'Success!');
  }

  signInWithEmailAndPassword(
      {required String email,
      required String password,
      BuildContext? context}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(
          context: context!,
          text: 'No user found for that email.',
        );
      } else if (e.code == 'wrong-password') {
        showSnackBar(
          context: context!,
          text: 'Wrong password, enter right password.',
        );
      }
    } catch (e) {
      showSnackBar(
        context: context!,
        text: 'There was an error.',
      );
    }
    showSnackBar(context: context!, text: 'Success!');
  }

  User? getCurrentUser() {
    User? user = _auth.currentUser;
    if (user == null) {
      return null;
    } else {
      return user;
    }
  }

  signOut() {
    _auth.signOut();
    notifyListeners();
  }

  showSnackBar({required BuildContext context, required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        dismissDirection: DismissDirection.horizontal,
        content: Text(text),
        duration: const Duration(
          seconds: 1,
        ),
        backgroundColor: text == 'Success'? Colors.green : Colors.blue,
      ),
    );
  }
}
