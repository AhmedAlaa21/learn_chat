import 'package:flutter/material.dart';
import 'package:learn_chat/constants/colors.dart';
import 'package:learn_chat/screens/auth_screens/root.dart';
import 'package:learn_chat/screens/auth_screens/sign_up.dart';
import 'package:learn_chat/services/providers/auth_provider.dart';
import 'package:learn_chat/widgets/my_button.dart';
import 'package:learn_chat/widgets/my_text_field.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  static const String screenRoute = 'login';
  late String email, password;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const Spacer(
                flex: 2,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/scholar.png'),
                  const Text(
                    'Learning Talk',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Pacifico',
                      fontSize: 32,
                    ),
                  ),
                ],
              ),
              const Spacer(
                flex: 2,
              ),
              MyTextField(
                label: 'Email',
                textInputType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              MyTextField(
                label: 'Password',
                obsecure: true,
                onChanged: (value) {
                  password = value;
                },
              ),
              const SizedBox(
                height: 55,
              ),
              MyButton(
                text: 'Sign In',
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    await provider.signInWithEmailAndPassword(
                        email: email, password: password, context: context);
                    Navigator.pushReplacementNamed(context, Root.screenRoute);
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: const Text('Please enter valid data'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Okay!'))
                            ],
                          );
                        });
                  }
                },
              ),
              const SizedBox(
                height: 3,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'don`t have an account?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignUpScreen.screenRoute);
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              const Spacer(
                flex: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
