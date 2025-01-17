import 'package:flutter/material.dart';
import 'package:weather_app/domain/common/validator.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.labelString,
      this.type = ValidateType.none});

  final TextEditingController controller;
  final String labelString;
  final ValidateType type;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        print('value: $value');
        // Validation function for the name field
        if(value != null){
          return customValidator(value, type);
        }
        return null; // Return null if the name is valid
      },
      cursorColor: Colors.brown,
      cursorWidth: 1,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelString,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.brown, width: 1.0),
        ),
        fillColor: Colors.white,
      ),
      keyboardType: getInputType(type),
    );
  }
}
