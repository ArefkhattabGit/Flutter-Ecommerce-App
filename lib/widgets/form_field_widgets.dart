import 'package:flutter/material.dart';

Widget defualtFormField({
  required TextEditingController controller,
  required TextInputType keyboardType,
  required FormFieldValidator<String> validator,
  ValueChanged<String>? onFieldSubmitted,
  required String lableText,
  bool autofocus = false,
  required IconData prefexIcon,
  IconData? suffixIcon,
  GestureTapCallback? sufeixPress,
  bool ispassword = false,
  ValueChanged<String>? onChanged,
}) =>
    TextFormField(enableSuggestions: true,


      autofocus: autofocus,
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      obscureText: ispassword,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: lableText,
        prefixIcon: Icon(prefexIcon),
        suffixIcon: InkWell(
          child: Icon(suffixIcon),
          onTap: sufeixPress,
        ),
        border: const OutlineInputBorder(),
      ),
    );