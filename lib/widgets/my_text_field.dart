import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    required this.label,
    this.obsecure = false,
    this.textInputType = TextInputType.text,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  final String label;
  final bool? obsecure;
  final TextInputType? textInputType;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: TextFormField(
        obscuringCharacter: '*',
        validator: (value) {
          if (value == null) {
            return 'required, enter the right one.';
          }
        },
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          label: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          enabled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.white54, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.white70, width: 2.3),
          ),
          contentPadding: const EdgeInsets.all(16),
        ),
        obscureText: obsecure!,
        keyboardType: textInputType,
        onChanged: onChanged!,
      ),
    );
  }
}
