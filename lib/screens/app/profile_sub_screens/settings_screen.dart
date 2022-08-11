import 'package:flutter/material.dart';
import 'package:tokoto/constant/constant.dart';
import 'package:tokoto/prefs/user_preferences_controller.dart';
import 'package:tokoto/widgets/app_app_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final darkModeProvider = StateProvider<ThemeMode>((ref) {
  return UserPreferencesController().darkMode
      ? ThemeMode.dark
      : ThemeMode.light;
});

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

bool notification = true;
bool askBeforeBuy = true;
bool colorBlind = UserPreferencesController().darkMode;

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(text: 'Settings'),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Notifications',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.color
                        ?.withOpacity(0.7),
                  ),
                ),
                Switch(
                  value: notification,
                  onChanged: (value) {
                    setState(() {
                      notification = value;
                    });
                  },
                  activeColor: Colors.white,
                  activeTrackColor: kPrimaryColor,
                  inactiveThumbColor: Colors.white,
                )
              ],
            ),
            const SizedBox(height: kDefaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ask before buy',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.color
                        ?.withOpacity(0.7),
                    fontSize: 20,
                  ),
                ),
                Switch(
                  value: askBeforeBuy,
                  onChanged: (value) {
                    setState(() {
                      askBeforeBuy = value;
                    });
                  },
                  activeColor: Colors.white,
                  activeTrackColor: kPrimaryColor,
                  inactiveThumbColor: Colors.white,
                )
              ],
            ),
            const SizedBox(height: kDefaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dark Mode',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.color
                        ?.withOpacity(0.7),
                    fontSize: 20,
                  ),
                ),
                Switch(
                  value: colorBlind,
                  onChanged: (value) {
                    setState(() {
                      colorBlind = value;
                    });
                    UserPreferencesController().setDarkMode(value);
                    if (colorBlind) {
                      ref.read(darkModeProvider.notifier).state =
                          ThemeMode.dark;
                    } else {
                      ref.read(darkModeProvider.notifier).state =
                          ThemeMode.light;
                    }
                  },
                  activeColor: Colors.white,
                  activeTrackColor: kPrimaryColor,
                  inactiveThumbColor: Colors.white,
                )
              ],
            ),
            const SizedBox(height: kDefaultPadding),
          ],
        ),
      ),
    );
  }
}
