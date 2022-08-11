import 'package:flutter/material.dart';
import 'package:tokoto/constant/constant.dart';
import 'package:tokoto/widgets/app_button.dart';
import 'package:tokoto/widgets/on_boarding_content.dart';
import 'package:tokoto/widgets/page_view_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentPageIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: kDefaultPadding * 5,
          left: kDefaultPadding,
          right: kDefaultPadding,
          bottom: kDefaultPadding * 2,
        ),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (int value) {
                  setState(() {
                    _currentPageIndex = value;
                  });
                },
                children: const [
                  OnBoardingContent(
                      body: 'Welcome to Semsem, Let’s shop!',
                      imagePath: 'images/ob1.png'),
                  OnBoardingContent(
                      body:
                          'We help people connect with store around Gaza City',
                      imagePath: 'images/ob2.png'),
                  OnBoardingContent(
                      body:
                          'We show the easy way to shop. Just stay at home with us',
                      imagePath: 'images/ob3.png'),
                ],
              ),
            ),
            const SizedBox(height: kDefaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PageViewIndicator(
                  isSelected: _currentPageIndex == 0,
                ),
                PageViewIndicator(
                  isSelected: _currentPageIndex == 1,
                ),
                PageViewIndicator(
                  isSelected: _currentPageIndex == 2,
                ),
              ],
            ),
            const SizedBox(height: kDefaultPadding * 2),
            AppButton(
              text: 'Continue',
              onPressed: () {
                _currentPageIndex != 2
                    ? _pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeIn)
                    : Navigator.pushReplacementNamed(context, '/sign_in_screen');
              },
            ),
          ],
        ),
      ),
    );
  }
}
