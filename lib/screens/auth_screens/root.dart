import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn_chat/screens/auth_screens/home_screen.dart';
import 'package:learn_chat/screens/auth_screens/login_screen.dart';
import 'package:learn_chat/services/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);
  static const String screenRoute = 'root';

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<AuthProvider>(context).getCurrentUser();
    return user == null ? LoginScreen() : HomeScreen();
  }
}
