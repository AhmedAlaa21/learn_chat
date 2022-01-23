import 'package:flutter/material.dart';
import 'package:learn_chat/constants/colors.dart';

class MessageContainer extends StatelessWidget {
  const MessageContainer({required this.text, required this.isSender, Key? key})
      : super(key: key);
  final String text;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: isSender == true
            ? const EdgeInsets.only(
                left: 16,
                top: 16,
              )
            : const EdgeInsets.only(
                right: 16,
                top: 16,
              ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: isSender
            ? const BoxDecoration(
                color: kMainColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(16),
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              )
            : const BoxDecoration(
                color: kMainColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
