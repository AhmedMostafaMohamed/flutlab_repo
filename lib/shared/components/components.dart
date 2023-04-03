import 'package:flutter/material.dart';

Widget defaultformField(
        {required TextEditingController controller,
        required TextInputType type,
        isPassword = false,
        IconData? suffix,
        Function(String?)? onSubmit,
        Function(String?)? onChange,
        required IconData prefix,
        required String label,
        Function()? suffixPressed,
        required String? Function(String?) validate}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(onPressed: suffixPressed, icon: Icon(suffix))
            : null,
        border: const OutlineInputBorder(),
      ),
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      validator: validate,
    );
