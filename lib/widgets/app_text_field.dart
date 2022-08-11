import 'package:flutter/material.dart';
import 'package:tokoto/constant/constant.dart';

class AppTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData suffixIcon;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final bool autofocus;
  final bool enabled;

  const AppTextField({
    required this.labelText,
    required this.hintText,
    required this.suffixIcon,
    required this.textInputType,
    required this.controller,
    required this.textInputAction,
    this.autofocus = false,
    this.enabled = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled,
      autofocus: autofocus,
      keyboardType: textInputType,
      obscureText: textInputType == TextInputType.visiblePassword,
      textInputAction: textInputAction,
      controller: controller,
      style: TextStyle(
        color: Theme.of(context).textTheme.bodyText1!.color,
        fontSize: 18,
      ),
      decoration: InputDecoration(
        // errorText: 'Incorrect $labelText',
        hintText: hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).textTheme.bodyText1?.color?.withOpacity(0.7),
          fontSize: 18,
        ),
        label: Text(
          labelText,
          style: TextStyle(
            color:
                Theme.of(context).textTheme.bodyText1?.color?.withOpacity(0.7),
            fontSize: 20,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(
            color:
                Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.7),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(
            color:
                Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.7),
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(
            color:
                Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.1),
          ),
        ),
        suffixIcon: Icon(
          suffixIcon,
          color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.7),
        ),
      ),
    );
  }
}
