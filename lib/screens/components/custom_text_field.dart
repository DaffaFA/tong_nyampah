import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  @required
  final String placeholder;
  @required
  final IconData prefixIcon;
  final bool isPassword;
  final TextEditingController controller;

  CustomTextField({
    this.placeholder,
    this.prefixIcon,
    this.isPassword = false,
    this.controller,
  });

  Widget build(BuildContext context) {
    return TextField(
      controller: this.controller,
      cursorColor: Color(0xFF070707),
      autocorrect: false,
      obscureText: isPassword,
      style: Theme.of(context).textTheme.body1,
      decoration: InputDecoration(
        focusColor: Color(0xFF070707),
        prefixIcon: Container(
          padding: EdgeInsets.only(left: 23.0, right: 20.0),
          child: Icon(this.prefixIcon,
              size: 25.0,
              color: this.controller.text.length > 0
                  ? Color(0xFF070707)
                  : Color(0xFF707070)),
        ),
        hintText: this.placeholder,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: this.controller.text.length > 0
                ? Color(0xFF070707)
                : Color(0xFF707070),
            width: 3.0,
          ),
          borderRadius: BorderRadius.zero,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF070707),
            width: 3.0,
          ),
          borderRadius: BorderRadius.zero,
        ),
      ),
    );
  }
}
