
import 'package:flutter/material.dart';


class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key, required this.onPressed, required this.text});

  final Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor:
          WidgetStateProperty.all<Color>(
              Colors.blue),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              // Change your radius here
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          elevation: WidgetStateProperty.all(10)),
      child: Text(text),
    );
  }
}
