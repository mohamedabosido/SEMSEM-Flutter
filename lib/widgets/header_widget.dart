import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String text;
  final String subText;
  final VoidCallback onPressed;
  final bool subTextFound;

  const HeaderWidget({
    required this.text,
    this.subTextFound = true,
    this.subText = 'See More',
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textTheme.bodyText1?.color),
        ),
        subTextFound
            ? TextButton(
                onPressed: onPressed,
                child: Text(
                  subText,
                  style:  TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.bodyText1?.color?.withOpacity(0.5),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
