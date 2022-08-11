import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tokoto/constant/constant.dart';
import 'package:tokoto/helpers/fb_auth_controller.dart';
import 'package:tokoto/helpers/helpers.dart';
import 'package:tokoto/widgets/app_app_bar.dart';
import 'package:tokoto/widgets/profile_card.dart';
import 'package:tokoto/widgets/profile_picture_widget.dart';

class ProfileScreen extends ConsumerWidget with Helpers {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar:
          const AppAppBar(text: 'Profile', automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ProfilePictureWidget(),
              ProfileCard(
                  text: 'My Account',
                  icon: 'images/person.svg',
                  onPressed: () {
                    Navigator.pushNamed(context, '/my_account_screen');
                  }),
              ProfileCard(
                  text: 'Notifications',
                  icon: 'images/Bell.svg',
                  onPressed: () {
                    Navigator.pushNamed(context, '/notification_screen');
                  }),
              ProfileCard(
                  text: 'Settings',
                  icon: 'images/Settings.svg',
                  onPressed: () {
                    Navigator.pushNamed(context, '/settings_screen');
                  }),
              ProfileCard(
                  text: 'Help Center',
                  icon: 'images/Question mark.svg',
                  onPressed: () {
                    Navigator.pushNamed(context, '/help_center_screen');
                  }),
              ProfileCard(
                  text: 'Log Out',
                  icon: 'images/Log out.svg',
                  onPressed: () async {
                    await FbAuthController().logout();
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacementNamed(context, '/sign_in_screen');
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
