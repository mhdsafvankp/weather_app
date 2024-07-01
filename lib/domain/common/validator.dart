import 'package:flutter/cupertino.dart';

enum ValidateType { email, password, none }

TextInputType? getInputType(ValidateType type) {
  switch (type) {
    case ValidateType.email:
       return TextInputType.emailAddress;
    case ValidateType.password:
      return TextInputType.visiblePassword;
    case ValidateType.none:
      return TextInputType.text;
  }
}

String? customValidator(String value, ValidateType type) {
  switch (type) {
    case ValidateType.email:
      if (value.isEmpty) {
        return 'Email is required';
      }
      if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
        return 'Please enter a valid email address';
      }
      return null;
    case ValidateType.password:
      if (value.isEmpty) {
        return 'Password is required';
      }
      if (value.length < 6) {
        return 'minimum 6 length is required';
      }
      return null;
    case ValidateType.none:
      return null;
  }
}
