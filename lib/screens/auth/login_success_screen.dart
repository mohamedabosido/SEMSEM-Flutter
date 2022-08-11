import 'package:flutter/material.dart';
import 'package:tokoto/constant/constant.dart';
import 'package:tokoto/widgets/app_app_bar.dart';
import 'package:tokoto/widgets/app_button.dart';

class LoginSuccessScreen extends StatelessWidget {
  const LoginSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(text: 'Login Success'),
      body: Padding(
        padding: const EdgeInsets.only(
          top: kDefaultPadding * 3,
          left: kDefaultPadding,
          right: kDefaultPadding,
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/BGSuccess.png'),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 75,
                  child: CircleAvatar(
                    radius: 95,
                    backgroundColor: Theme.of(context).brightness ==
                        Brightness.dark
                        ? Theme.of(context).backgroundColor
                        : kOffOrangeColor.withOpacity(0.5),
                    child: CircleAvatar(
                      radius: 85,
                      backgroundColor: Theme.of(context).brightness ==
                          Brightness.dark
                          ? Theme.of(context).scaffoldBackgroundColor
                          : Colors.white,
                      child: Image.asset('images/success.png'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: kDefaultPadding * 4),
            Text(
              'Login Success',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Theme.of(context).textTheme.bodyText1?.color,
              ),
            ),
            const SizedBox(height: kDefaultPadding / 2),
            Text(
              'Now you\'re ready to go shopping',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18,
                color: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.color
                    ?.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: kDefaultPadding * 3),
            AppButton(
                text: 'Back to home',
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/main_screen');
                },
                width: 190),
          ],
        ),
      ),
    );
  }
}
