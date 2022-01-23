import 'package:flutter/material.dart';
import 'package:learn_chat/constants/colors.dart';
import 'package:learn_chat/screens/auth_screens/home_screen.dart';
import 'package:learn_chat/screens/auth_screens/root.dart';
import 'package:learn_chat/services/providers/auth_provider.dart';
import 'package:learn_chat/widgets/my_button.dart';
import 'package:learn_chat/widgets/my_text_field.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  static const String screenRoute = 'sign_up';
  late String email, password;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            const Spacer(
              flex: 2,
            ),
            Form(
              key: formKey,
              child: Column(
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
              text: 'Sign Up',
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await provider.createEmailAndPassword(
                      email: email, password: password, context: context);
                  //formKey.currentState!.save();
                  Navigator.pushReplacementNamed(context, HomeScreen.screenRoute);
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
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
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
    );
  }
}
