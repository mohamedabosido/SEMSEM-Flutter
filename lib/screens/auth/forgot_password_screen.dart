// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tokoto/constant/constant.dart';
import 'package:tokoto/helpers/fb_auth_controller.dart';
import 'package:tokoto/widgets/app_app_bar.dart';
import 'package:tokoto/widgets/app_button.dart';
import 'package:tokoto/widgets/app_text_field.dart';
import 'package:tokoto/widgets/ask_to_sign_up_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late TextEditingController _emailController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(text: 'Forgot Password'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            children: [
              Text(
                'Forgot Password',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Theme.of(context).textTheme.bodyText1?.color,
                ),
              ),
              const SizedBox(height: kDefaultPadding / 2),
              Text(
                'Please enter your email and we will send you a link to return to your account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  color: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .color!
                      .withOpacity(0.6),
                ),
              ),
              const SizedBox(height: kDefaultPadding * 5),
              AppTextField(
                labelText: 'Email',
                hintText: 'Enter your email',
                suffixIcon: Icons.mail_outline_rounded,
                textInputType: TextInputType.emailAddress,
                controller: _emailController,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: kDefaultPadding * 4),
              AppButton(
                  text: 'Continue',
                  onPressed: () async {
                    if (await FbAuthController()
                        .resetPassword(_emailController.text, context)) {
                      Navigator.pushNamed(context, '/sign_in_screen');
                    }
                  }),
              const SizedBox(height: kDefaultPadding * 5),
              const AskToSignUpWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
