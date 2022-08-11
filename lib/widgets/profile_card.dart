import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tokoto/constant/constant.dart';

class ProfileCard extends StatelessWidget {
  final String text;
  final String icon;
  final VoidCallback onPressed;

  const ProfileCard({
    required this.text,
    required this.icon,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(top: kDefaultPadding),
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: SvgPicture.asset(
            icon,
            color: kPrimaryColor,
            height: 24,
            width: 24,
          ),
          title:  Text(
            text,
            style:  TextStyle(
              color: Theme.of(context).textTheme.bodyText1?.color?.withOpacity(0.6),
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing:  Icon(
            Icons.arrow_forward_ios_outlined,
            color: Theme.of(context).textTheme.bodyText1?.color?.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
