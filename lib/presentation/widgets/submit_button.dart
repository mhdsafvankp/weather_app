
import 'package:flutter/material.dart';


class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key, required this.onPressed, this.text = 'SUBMIT', this.child});

  final Function() onPressed;
  final String text;
  final Widget? child;

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
      child: child ?? Text(text),
    );
  }
}
