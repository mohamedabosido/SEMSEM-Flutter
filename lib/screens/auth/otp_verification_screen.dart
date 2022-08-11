import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tokoto/constant/constant.dart';
import 'package:tokoto/helpers/helpers.dart';
import 'package:tokoto/widgets/app_app_bar.dart';
import 'package:tokoto/widgets/app_button.dart';
import 'package:tokoto/widgets/app_code_text_field.dart';

class OTPVerificationScreen extends ConsumerWidget with Helpers {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();
  TextEditingController controller6 = TextEditingController();

  OTPVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const AppAppBar(text: 'OTP Verification'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            children: [
              Text(
                'OTP Verification',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Theme.of(context).textTheme.bodyText1?.color,
                ),
              ),
              const SizedBox(height: kDefaultPadding / 2),
              Text(
                'We sent your code to +1 898 860 *** This code will expired in 00:30',
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
              const SizedBox(height: kDefaultPadding * 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppCodeTextField(
                    controller: controller1,
                  ),
                  AppCodeTextField(
                    controller: controller2,
                  ),
                  AppCodeTextField(
                    controller: controller3,
                  ),
                  AppCodeTextField(
                    controller: controller4,
                  ),
                  AppCodeTextField(
                    controller: controller5,
                  ),
                  AppCodeTextField(
                    controller: controller6,
                  ),
                ],
              ),
              const SizedBox(height: kDefaultPadding * 4),
              AppButton(
                  text: 'Continue',
                  onPressed: () async {
                    // String otp = controller1.text +
                    //     controller2.text +
                    //     controller3.text +
                    //     controller4.text +
                    //     controller5.text +
                    //     controller6.text;
                    // final phoneAuthCr = PhoneAuthProvider.credential(
                    //     verificationId: ref.watch(otpProvider), smsCode: otp);
                  }),
              const SizedBox(height: kDefaultPadding * 4),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Resend OTP Code',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color!
                        .withOpacity(0.6),
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
