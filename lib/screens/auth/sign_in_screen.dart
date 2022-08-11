import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tokoto/constant/constant.dart';
import 'package:tokoto/helpers/fb_auth_controller.dart';
import 'package:tokoto/helpers/helpers.dart';
import 'package:tokoto/widgets/app_app_bar.dart';
import 'package:tokoto/widgets/app_button.dart';
import 'package:tokoto/widgets/app_text_field.dart';
import 'package:tokoto/widgets/ask_to_sign_up_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> with Helpers {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool rememberMe = true;
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Scaffold(
            body: Center(
              child: CupertinoActivityIndicator(radius: 20),
            ),
          )
        : Scaffold(
            appBar: const AppAppBar(
              text: 'Sign In',
              automaticallyImplyLeading: false,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  children: [
                    Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Theme.of(context).textTheme.bodyText1?.color,
                      ),
                    ),
                    const SizedBox(height: kDefaultPadding / 2),
                    Text(
                      'Sign in with your email and password or continue with social media',
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
                    const SizedBox(height: kDefaultPadding * 2),
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
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: kDefaultPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                                value: rememberMe,
                                activeColor: kPrimaryColor,
                                onChanged: (bool? value) {
                                  setState(() {
                                    rememberMe = value!;
                                  });
                                }),
                            Text(
                              'Remember me',
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.color
                                    ?.withOpacity(0.6),
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, '/forgot_password_screen');
                          },
                          child: Text(
                            'Forgot Password',
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.color
                                  ?.withOpacity(0.6),
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: kDefaultPadding * 1.5),
                    AppButton(
                        text: 'Continue',
                        onPressed: () async {
                          if (await performLogin()) {
                            Navigator.pushReplacementNamed(
                                context, '/main_screen');
                          } else {
                            setState(() {
                              loading = false;
                            });
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
                    const SizedBox(height: kDefaultPadding),
                    const AskToSignUpWidget()
                  ],
                ),
              ),
            ),
          );
  }

  Future<bool> performLogin() async {
    if (checkData()) {
      return await login();
    }
    return false;
  }

  bool checkData() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      setState(() {
        loading = true;
      });
      return true;
    }
    showSnackBar(
      context: context,
      message: 'Please Enter All Required Data',
      error: true,
    );
    return false;
  }

  Future<bool> login() async {
    bool status = await FbAuthController().login(
      email: _emailController.text,
      context: context,
      password: _passwordController.text,
    );
    return status;
  }
}
