import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tokoto/constant/constant.dart';
import 'package:tokoto/helpers/fb_auth_controller.dart';
import 'package:tokoto/helpers/helpers.dart';
import 'package:tokoto/screens/auth/add_details_screen.dart';
import 'package:tokoto/widgets/app_app_bar.dart';
import 'package:tokoto/widgets/app_button.dart';
import 'package:tokoto/widgets/app_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with Helpers {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Scaffold(
            body: Center(
              child: CupertinoActivityIndicator(radius: 20),
            ),
          )
        : Scaffold(
            appBar: const AppAppBar(text: 'Sign Up'),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  children: [
                    Text(
                      'Register Account',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Theme.of(context).textTheme.bodyText1?.color,
                      ),
                    ),
                    const SizedBox(height: kDefaultPadding / 2),
                    Text(
                      'Complete your details or continue with social media',
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
                    const SizedBox(height: kDefaultPadding * 1.5),
                    AppTextField(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      suffixIcon: Icons.mail_outline_rounded,
                      textInputType: TextInputType.emailAddress,
                      controller: _emailController,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: kDefaultPadding),
                    AppTextField(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      suffixIcon: Icons.lock_outline,
                      textInputType: TextInputType.visiblePassword,
                      controller: _passwordController,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: kDefaultPadding),
                    AppTextField(
                      labelText: 'Confirm Password',
                      hintText: 'Re-enter your password',
                      suffixIcon: Icons.lock_outline,
                      textInputType: TextInputType.visiblePassword,
                      controller: _confirmPasswordController,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: kDefaultPadding * 1.5),
                    AppButton(
                        text: 'Continue',
                        onPressed: () {
                          if (checkData()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddDetailsScreen(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    confirmPassword:
                                        _confirmPasswordController.text),
                              ),
                            );
                            showSnackBar(
                                context: context, message: 'Step 1 Done');
                          }
                        }),
                    const SizedBox(height: kDefaultPadding * 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              loading = true;
                            });
                            if (await FbAuthController()
                                .loginWithGoogle(context)) {
                            }
                          },
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Theme.of(context).backgroundColor,
                            child: Image.asset('images/google.png'),
                          ),
                        ),
                        const SizedBox(width: kDefaultPadding / 3),
                        GestureDetector(
                          onTap: () async {
                            FbAuthController().loginWithFacebook();
                          },
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Theme.of(context).backgroundColor,
                            child: Image.asset('images/facebook.png'),
                          ),
                        ),
                        const SizedBox(width: kDefaultPadding / 3),
                      ],
                    ),
                    const SizedBox(height: kDefaultPadding / 2),
                    Text(
                      'By continuing your confirm that you agree with our Term and Condition',
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
                  ],
                ),
              ),
            ),
          );
  }

  bool checkData() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty) {
      if (_passwordController.text == _confirmPasswordController.text) {
        return true;
      } else {
        showSnackBar(
          context: context,
          message: 'Check The Password Fields',
          error: true,
        );
        return false;
      }
    }
    showSnackBar(
      context: context,
      message: 'Please Enter All Required Data',
      error: true,
    );
    return false;
  }
}
