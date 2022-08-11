import 'package:flutter/material.dart';
import 'package:tokoto/constant/constant.dart';

class PageViewIndicator extends StatelessWidget {
  final bool isSelected;

  const PageViewIndicator({
    Key? key,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(end: 6),
      width: isSelected ? 20 : 6,
      height: 6,
      decoration: BoxDecoration(
        color: isSelected ? kPrimaryColor : kLightColor,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
