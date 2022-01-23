import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learn_chat/screens/auth_screens/home_screen.dart';
import 'package:learn_chat/screens/auth_screens/login_screen.dart';
import 'package:learn_chat/screens/auth_screens/root.dart';
import 'package:learn_chat/screens/auth_screens/sign_up.dart';
import 'package:learn_chat/services/providers/auth_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: Root.screenRoute,
        routes: {
          Root.screenRoute: (ctx) => const Root(),
          HomeScreen.screenRoute: (ctx) =>  HomeScreen(),
          LoginScreen.screenRoute: (ctx) => LoginScreen(),
          SignUpScreen.screenRoute: (ctx) => SignUpScreen(),
        },
      ),
    );
  }
}
