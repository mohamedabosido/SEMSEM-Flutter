import 'package:flutter/material.dart';
import 'package:tokoto/constant/constant.dart';
class AskToSignUpWidget extends StatelessWidget {
  const AskToSignUpWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Text(
          'Don’t have an account? ',
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).textTheme.bodyText1?.color?.withOpacity(0.6),
            fontWeight: FontWeight.normal,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/sign_up_screen');
          },
          child: const Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 18,
              color: kPrimaryColor,
              fontWeight: FontWeight.normal,
            ),
          ),
        )
      ],
    );
  }
}