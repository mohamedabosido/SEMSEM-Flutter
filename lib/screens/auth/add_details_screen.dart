// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tokoto/constant/constant.dart';
import 'package:tokoto/helpers/fb_auth_controller.dart';
import 'package:tokoto/helpers/helpers.dart';
import 'package:tokoto/widgets/app_app_bar.dart';
import 'package:tokoto/widgets/app_button.dart';
import 'package:tokoto/widgets/app_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddDetailsScreen extends ConsumerStatefulWidget {
  final String email;
  final String password;
  final String confirmPassword;

  const AddDetailsScreen({
    Key? key,
    required this.email,
    required this.password,
    required this.confirmPassword,
  }) : super(key: key);

  @override
  ConsumerState createState() => _AddDetailsScreenState();
}

class _AddDetailsScreenState extends ConsumerState<AddDetailsScreen>
    with Helpers {
  late TextEditingController _fNameController;
  late TextEditingController _lNameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fNameController = TextEditingController();
    _lNameController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _fNameController.dispose();
    _lNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
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
            appBar: const AppAppBar(text: 'Sign Up'),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  children: [
                    Text(
                      'Complete Profile',
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
                      labelText: 'First Name',
                      hintText: 'Enter your first name',
                      suffixIcon: Icons.person_outline,
                      textInputType: TextInputType.name,
                      controller: _fNameController,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: kDefaultPadding),
                    AppTextField(
                      labelText: 'Last Name',
                      hintText: 'Enter your last name',
                      suffixIcon: Icons.person_outline,
                      textInputType: TextInputType.name,
                      controller: _lNameController,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: kDefaultPadding),
                    AppTextField(
                      labelText: 'Phone Number',
                      hintText: 'Enter your phone number',
                      suffixIcon: Icons.smartphone_outlined,
                      textInputType: TextInputType.phone,
                      controller: _phoneController,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: kDefaultPadding),
                    AppTextField(
                      labelText: 'Address',
                      hintText: 'Enter your address',
                      suffixIcon: Icons.location_on_outlined,
                      textInputType: TextInputType.streetAddress,
                      controller: _addressController,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: kDefaultPadding * 1.5),
                    AppButton(
                      text: 'Continue',
                      onPressed: () async => await performRegister(),
                    ),
                    const SizedBox(height: kDefaultPadding * 1.5),
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

  Future<void> performRegister() async {
    if (checkData()) {
      await register();
    }
  }

  bool checkData() {
    if (_fNameController.text.isNotEmpty &&
        _lNameController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _addressController.text.isNotEmpty) {
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

  Future<void> register() async {
    bool status = await FbAuthController().register(
      email: widget.email,
      password: widget.password,
      firstName: _fNameController.text,
      lastName: _lNameController.text,
      address: _addressController.text,
      phone: _phoneController.text,
      context: context,
    );
    if (status) {
      showSnackBar(context: context, message: 'Registered Successfully');
      Navigator.pushReplacementNamed(context, '/sign_in_screen');
    } else {
      setState(() {
        loading = false;
      });
    }
  }
}
