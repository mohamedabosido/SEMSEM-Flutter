import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tokoto/api/controller/advertise_api_controller.dart';
import 'package:tokoto/constant/constant.dart';

Widget loaderWidget(context) {
  return Shimmer.fromColors(
      baseColor:Theme.of(context).backgroundColor,
      highlightColor: kOffOrangeColor,
      child: Container(
        margin: const EdgeInsets.only(right: kDefaultPadding),
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black,
        ),
      ));
}

class AdsWidget extends ConsumerStatefulWidget {
  const AdsWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<AdsWidget> createState() => _MyAdsListState();
}

class _MyAdsListState extends ConsumerState<AdsWidget> {
  int _currentPage = 0;
  late Timer _timer;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
    );

    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final advertises = ref.watch(advertiseProvider);
    return SizedBox(
      height: 120,
      child: PageView(
        controller: _pageController,
        children: List.generate(
          advertises.length,
          (index) => Container(
            margin: const EdgeInsets.only(right: kDefaultPadding),
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(advertises[index].image!),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
