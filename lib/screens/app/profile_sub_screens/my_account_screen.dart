import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tokoto/Models/user.dart';
import 'package:tokoto/constant/constant.dart';
import 'package:tokoto/helpers/fb_auth_controller.dart';
import 'package:tokoto/helpers/helpers.dart';
import 'package:tokoto/prefs/user_preferences_controller.dart';
import 'package:tokoto/widgets/app_app_bar.dart';
import 'package:tokoto/widgets/app_button.dart';
import 'package:tokoto/widgets/app_text_field.dart';
import 'package:tokoto/widgets/profile_picture_widget.dart';

class MyAccountScreen extends ConsumerStatefulWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends ConsumerState<MyAccountScreen>
    with Helpers {
  late TextEditingController _fNameController;
  late TextEditingController _lNameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fNameController =
        TextEditingController(text: UserPreferencesController().user.fName);
    _lNameController =
        TextEditingController(text: UserPreferencesController().user.lName);
    _phoneController =
        TextEditingController(text: UserPreferencesController().user.phone);
    _emailController =
        TextEditingController(text: UserPreferencesController().user.email);
    _addressController =
        TextEditingController(text: UserPreferencesController().user.address);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _fNameController.dispose();
    _lNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(text: 'Profile', automaticallyImplyLeading: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ProfilePictureWidget(),
              const SizedBox(height: kDefaultPadding),
              AppTextField(
                labelText: 'First Name',
                hintText: 'Enter your first name',
                suffixIcon: Icons.person_outline,
                textInputType: TextInputType.name,
                controller: _fNameController,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: kDefaultPadding),
              AppTextField(
                labelText: 'Last Name',
                hintText: 'Enter your last name',
                suffixIcon: Icons.person_outline,
                textInputType: TextInputType.name,
                controller: _lNameController,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: kDefaultPadding),
              AppTextField(
                labelText: 'Email',
                hintText: 'Enter your email',
                suffixIcon: Icons.mail_outline_rounded,
                textInputType: TextInputType.emailAddress,
                controller: _emailController,
                enabled: false,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: kDefaultPadding),
              AppTextField(
                labelText: 'Phone Number',
                hintText: 'Enter your phone number',
                suffixIcon: Icons.smartphone_outlined,
                textInputType: TextInputType.phone,
                controller: _phoneController,
                textInputAction: TextInputAction.done,
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
              const SizedBox(height: kDefaultPadding / 2),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: TextButton(
                  onPressed: () async {
                    await FbAuthController().resetPassword(
                        UserPreferencesController().user.email, context);
                  },
                  child: Text(
                    'Reset Password',
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
                ),
              ),
              const SizedBox(height: kDefaultPadding / 2),
              AppButton(
                  text: 'Save Changes',
                  onPressed: () {
                    UserModel userModel = UserModel(
                        id: FbAuthController().firebaseAuth.currentUser!.uid,
                        fName: _fNameController.text,
                        lName: _lNameController.text,
                        email: _emailController.text,
                        phone: _phoneController.text,
                        address: _addressController.text);
                    FbAuthController().updateUserInfo(userModel, context);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
