import 'package:flutter/material.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final bool automaticallyImplyLeading;

  const AppAppBar({
    required this.text,
    this.automaticallyImplyLeading = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: true,
      title: Text(
        text,
        style:  TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 22,
          color: Theme.of(context).textTheme.bodyText1?.color,
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
