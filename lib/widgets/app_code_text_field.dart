import 'package:flutter/material.dart';
import 'package:tokoto/constant/constant.dart';

class AppCodeTextField extends StatelessWidget {
  final TextEditingController controller;

  const AppCodeTextField({
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsetsDirectional.only(end: kDefaultPadding / 4),
        child: TextField(
          style: TextStyle(
            fontSize: 30,
            color:
                Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
          ),
          maxLength: 1,
          textAlign: TextAlign.center,
          showCursor: false,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            counterText: '',
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .color!
                    .withOpacity(0.7),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .color!
                    .withOpacity(0.7),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
