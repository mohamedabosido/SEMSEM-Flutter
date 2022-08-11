import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tokoto/api/controller/advertise_api_controller.dart';
import 'package:tokoto/api/controller/categories_api_controller.dart';
import 'package:tokoto/api/controller/products_api_controller.dart';
import 'package:tokoto/api/controller/notification_controller.dart';
import 'package:tokoto/constant/constant.dart';
import 'package:tokoto/screens/app/search_screen.dart';
import 'package:tokoto/screens/app/sub_screen.dart';
import 'package:tokoto/widgets/header_widget.dart';
import 'package:tokoto/widgets/shimmer_ads_widget.dart';
import 'package:tokoto/widgets/shimmer_categories_widget.dart';
import 'package:tokoto/widgets/shimmer_populars_widget.dart';
import 'package:tokoto/widgets/shimmer_special_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var advertises = ref.watch(advertiseProvider);
    var categories = ref.watch(categoriesProvider);
    var populars = ref.watch(popularProvider);
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(top: kDefaultPadding*1.5),
            sliver: CupertinoSliverRefreshControl(
              onRefresh: () async {
                ref.refresh(advertiseProvider);
                ref.refresh(categoriesProvider);
                ref.refresh(specialForYouProvider);
                ref.refresh(popularProvider);
              },
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(
              top: kDefaultPadding,
              left: kDefaultPadding,
            ),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: kDefaultPadding),
                    child: Row(
                      children: [
                        Consumer(builder: (context, ref, child) {
                          return Expanded(
                            child: TextField(
                              keyboardType: TextInputType.none,
                              onTap: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  elevation: 15,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                  builder: (context) => FractionallySizedBox(
                                    heightFactor: 0.9,
                                    child: SearchScreen(),
                                  ),
                                );
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.color
                                      ?.withOpacity(0.6),
                                  size: 30,
                                ),
                                hintText: 'Search product',
                                hintStyle: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.color
                                      ?.withOpacity(0.6),
                                ),
                                filled: true,
                                fillColor: Theme.of(context).backgroundColor,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          );
                        }),
                        const SizedBox(width: kDefaultPadding / 3),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/cart_screen');
                          },
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context).backgroundColor,
                            radius: 30,
                            child: SvgPicture.asset(
                              'images/cart.svg',
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.color
                                  ?.withOpacity(0.6),
                              width: 25,
                              height: 25,
                            ),
                          ),
                        ),
                        const SizedBox(width: kDefaultPadding / 3),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, '/notification_screen');
                          },
                          child: Stack(
                            children: [
                              Positioned(
                                child: CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).backgroundColor,
                                  radius: 30,
                                  child: SvgPicture.asset(
                                    'images/Bell.svg',
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.color
                                        ?.withOpacity(0.6),
                                    width: 25,
                                    height: 25,
                                  ),
                                ),
                              ),
                              ref.watch(unReadNotificationProvider) != 0
                                  ? Positioned(
                                      bottom: 35,
                                      left: 35,
                                      child: CircleAvatar(
                                        radius: 12,
                                        backgroundColor: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        child: CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Colors.red,
                                          child: Text(
                                            '${ref.watch(unReadNotificationProvider)}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding),
                  advertises.isNotEmpty
                      ? const AdsWidget()
                      : loaderWidget(context),
                  const SizedBox(height: kDefaultPadding),
                  categoriesWidget(categories, context),
                  const SizedBox(height: kDefaultPadding),
                  Padding(
                    padding: const EdgeInsets.only(right: kDefaultPadding),
                    child: HeaderWidget(
                        text: 'Special for you',
                        onPressed: () {},
                        subTextFound: false),
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  const SpecialForYouWidget(),
                  const SizedBox(height: kDefaultPadding),
                  Padding(
                    padding: const EdgeInsets.only(right: kDefaultPadding),
                    child: HeaderWidget(
                        text: 'Popular Products',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SubScreen(
                                    text: 'Popular Products', list: populars),
                              ));
                        }),
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  popularsWidget(populars, context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
