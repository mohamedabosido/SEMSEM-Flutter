import 'package:flutter/material.dart';
import 'package:tokoto/constant/constant.dart';

class OnBoardingContent extends StatelessWidget {
  final String body;
  final String imagePath;

  const OnBoardingContent({
    Key? key,
    required this.body,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            'SEMSEM',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50,
              color: kPrimaryColor,
            ),
          ),
          const SizedBox(height: kDefaultPadding / 3),
          Text(
            body,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.color
                  ?.withOpacity(0.6),
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: kDefaultPadding * 3),
          Stack(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 125,
                  backgroundColor: Theme.of(context).brightness ==
                      Brightness.dark
                      ? Theme.of(context).backgroundColor
                      : kOffOrangeColor.withOpacity(0.5),
                ),
              ),
              Center(
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: 300,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
