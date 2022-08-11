import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:tokoto/helpers/fb_auth_controller.dart';
import 'package:tokoto/helpers/fb_notifications.dart';
import 'package:tokoto/helpers/theme.dart';
import 'package:tokoto/prefs/user_preferences_controller.dart';
import 'package:tokoto/screens/app/cart_screen.dart';
import 'package:tokoto/screens/app/check_out_screen.dart';
import 'package:tokoto/screens/app/main_screen.dart';
import 'package:tokoto/screens/app/messages_screen.dart';
import 'package:tokoto/screens/app/order_success_screen.dart';
import 'package:tokoto/screens/app/profile_sub_screens/help_center_screen.dart';
import 'package:tokoto/screens/app/profile_sub_screens/my_account_screen.dart';
import 'package:tokoto/screens/app/profile_sub_screens/notification_screen.dart';
import 'package:tokoto/screens/app/profile_sub_screens/settings_screen.dart';
import 'package:tokoto/screens/auth/forgot_password_screen.dart';
import 'package:tokoto/screens/auth/login_success_screen.dart';
import 'package:tokoto/screens/auth/otp_verification_screen.dart';
import 'package:tokoto/screens/auth/sign_in_screen.dart';
import 'package:tokoto/screens/auth/sign_up_screen.dart';
import 'package:tokoto/screens/on_boarding_screen.dart';
import 'package:flutter/services.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferencesController().initSharePreferences();
  await Firebase.initializeApp();
  await FirebaseNotifications.initNotifications();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tokoto',
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      themeMode: ref.watch(darkModeProvider),
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        maxWidth: 1200,
        minWidth: 480,
        defaultScale: true,
        breakpoints: const [
          ResponsiveBreakpoint.resize(480, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.resize(1000, name: DESKTOP),
        ],
      ),
      initialRoute: FbAuthController().loggedIn()
          ? '/main_screen'
          : '/on_boarding_screen',
      routes: {
        '/on_boarding_screen': (context) => const OnBoardingScreen(),
        '/sign_in_screen': (context) => const SignInScreen(),
        '/forgot_password_screen': (context) => const ForgotPasswordScreen(),
        '/login_success_screen': (context) => const LoginSuccessScreen(),
        '/sign_up_screen': (context) => const SignUpScreen(),
        '/otp_verification_screen': (context) => OTPVerificationScreen(),
        '/main_screen': (context) => const MainScreen(),
        '/messages_screen': (context) => const MessagesScreen(),
        '/my_account_screen': (context) => const MyAccountScreen(),
        '/notification_screen': (context) => const NotificationScreen(),
        '/settings_screen': (context) => const SettingsScreen(),
        '/help_center_screen': (context) => const HelpCenterScreen(),
        '/cart_screen': (context) => const CartScreen(),
        '/check_out_screen': (context) => const CheckOutScreen(),
        '/order_success_screen': (context) => const OrderSuccessScreen(),
      },
    );
  }
}
