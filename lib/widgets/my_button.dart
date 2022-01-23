import 'package:flutter/material.dart';
import 'package:learn_chat/constants/colors.dart';

class MyButton extends StatelessWidget {
  const MyButton({required this.text, required this.onPressed, Key? key})
      : super(key: key);
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        child: Text(
          text,
          style: const TextStyle(
            color: kMainColor,
            fontSize: 24,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
