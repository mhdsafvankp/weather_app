
import 'package:flutter/material.dart';


class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, this.onPressed, this.text = 'Submit',  this.child});

  final Function()? onPressed;
  final String text;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: child ?? Text(text));
  }
}
