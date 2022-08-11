import 'package:flutter/material.dart';
import 'package:tokoto/constant/constant.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final Color color;

  const AppButton({
    Key? key,
    this.width = double.infinity,
    this.color = kPrimaryColor,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width, 60),
        primary: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white
        ),
      ),
    );
  }
}
