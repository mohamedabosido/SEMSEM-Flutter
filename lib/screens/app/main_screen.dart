import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tokoto/constant/constant.dart';
import 'package:tokoto/helpers/fb_notifications.dart';
import 'package:tokoto/screens/app/favorites_screen.dart';
import 'package:tokoto/screens/app/home_screen.dart';
import 'package:tokoto/screens/app/messages_screen.dart';
import 'package:tokoto/screens/app/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with FirebaseNotifications {
  int _currentIndex = 0;

  List<Widget> screens = const [
    HomeScreen(),
    FavoritesScreen(),
    MessagesScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    requestNotificationPermissions();
    initializeForegroundNotificationForAndroid();
    manageNotificationAction(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(40),
            topLeft: Radius.circular(40),
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .color!
                  .withOpacity(0.05),
              spreadRadius:2,
              blurRadius: 25,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            showUnselectedLabels: false,
            showSelectedLabels: false,
            currentIndex: _currentIndex,
            selectedItemColor: kPrimaryColor,
            unselectedItemColor: kUnSelectedColor,
            onTap: (int value) {
              setState(() {
                _currentIndex = value;
              });
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'images/shop.svg',
                    color:
                        _currentIndex == 0 ? kPrimaryColor : kUnSelectedColor,
                    height: 24,
                    width: 24,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'images/heart.svg',
                    color:
                        _currentIndex == 1 ? kPrimaryColor : kUnSelectedColor,
                    height: 24,
                    width: 24,
                  ),
                  label: 'Favorite'),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'images/chat.svg',
                    color:
                        _currentIndex == 2 ? kPrimaryColor : kUnSelectedColor,
                    height: 24,
                    width: 24,
                  ),
                  label: 'Chat'),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'images/person.svg',
                    color:
                        _currentIndex == 3 ? kPrimaryColor : kUnSelectedColor,
                    height: 24,
                    width: 24,
                  ),
                  label: 'Person')
            ],
          ),
        ),
      ),
    );
  }
}
