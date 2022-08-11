import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tokoto/Models/product.dart';
import 'package:tokoto/api/controller/cart_api_controller.dart';
import 'package:tokoto/api/controller/favorite_api_controller.dart';
import 'package:tokoto/constant/constant.dart';
import 'package:tokoto/widgets/app_button.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailScreen({required this.product, Key? key})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late PageController _pageController;
  late String _selectedColor;
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
    _selectedColor = widget.product.images!.keys.first;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  int counter = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(kDefaultPadding / 3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new_sharp,
                      color: Theme.of(context).iconTheme.color,
                      size: 25,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(kDefaultPadding / 3),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Text(
                        widget.product.rating.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).textTheme.bodyText1?.color,
                        ),
                      ),
                      const SizedBox(width: kDefaultPadding / 5),
                      SvgPicture.asset(
                        'images/Star Icon.svg',
                        width: 20,
                        height: 20,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: kDefaultPadding / 3),
          SizedBox(
            height: 200,
            child: PageView(
              controller: _pageController,
              onPageChanged: (int value) {
                setState(() {
                  _currentIndex = value;
                });
              },
              children: List.generate(
                widget.product.images![_selectedColor]!.length,
                (index) => Image.network(
                  widget.product.images![_selectedColor]![index],
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(height: kDefaultPadding / 2),
          Center(
            child: SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: widget.product.images![_selectedColor]!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(index,
                          duration: const Duration(microseconds: 400),
                          curve: Curves.easeIn);
                    },
                    child: Container(
                      margin: const EdgeInsetsDirectional.only(
                          end: kDefaultPadding / 3),
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(10),
                        border: _currentIndex == index
                            ? Border.all(color: kPrimaryColor)
                            : const Border(),
                        image: DecorationImage(
                          image: NetworkImage(
                            widget.product.images![_selectedColor]![index],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(top: kDefaultPadding),
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: kDefaultPadding,
                      top: kDefaultPadding,
                      bottom: kDefaultPadding,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.title!,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.bodyText1?.color,
                          ),
                        ),
                        const SizedBox(height: kDefaultPadding / 3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$ ${widget.product.price}',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                                color: kPrimaryColor,
                              ),
                            ),
                            Consumer(builder: (context, ref, child) {
                              final favorites = ref.watch(favoritesProvider);
                              return GestureDetector(
                                onTap: () {
                                  if (favorites.contains(widget.product)) {
                                    ref
                                        .read(favoritesProvider.notifier)
                                        .delete(product: widget.product);
                                  } else {
                                    ref
                                        .read(favoritesProvider.notifier)
                                        .add(product: widget.product);
                                  }
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.all(kDefaultPadding / 2),
                                  decoration: BoxDecoration(
                                    color: favorites.contains(widget.product) &&
                                            Theme.of(context).brightness ==
                                                Brightness.light
                                        ? kOffRedColor
                                        : Theme.of(context).backgroundColor,
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      topLeft: Radius.circular(20),
                                    ),
                                  ),
                                  child: Icon(Icons.favorite,
                                      color: favorites.contains(widget.product)
                                          ? Colors.red
                                          : kUnSelectedColor),
                                ),
                              );
                            }),
                          ],
                        ),
                        const SizedBox(height: kDefaultPadding),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: kDefaultPadding / 2),
                          child: ExpandableText(
                            widget.product.details!,
                            expandText: '\n\nSee More Details ',
                            collapseText: '\n\nSee Less Details ',
                            maxLines: 2,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.color
                                  ?.withOpacity(0.6),
                              fontSize: 20,
                            ),
                            linkStyle: const TextStyle(
                              color: kPrimaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(kDefaultPadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: List.generate(
                                  widget.product.images!.keys.length,
                                  (index) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedColor = widget
                                            .product.images!.keys
                                            .elementAt(index);
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsetsDirectional.only(
                                          end: kDefaultPadding / 3),
                                      padding: const EdgeInsets.all(
                                          kDefaultPadding / 6),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: widget.product.images!.keys
                                                    .elementAt(index) ==
                                                _selectedColor
                                            ? Border.all(color: kPrimaryColor)
                                            : const Border(),
                                      ),
                                      child: CircleAvatar(
                                        radius: 12,
                                        backgroundColor: Color(
                                          int.parse(
                                            widget.product.images!.keys
                                                .elementAt(index),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (counter > 1) {
                                          counter--;
                                        }
                                      });
                                    },
                                    child: CircleAvatar(
                                      radius: 18,
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      child: Icon(
                                        Icons.remove,
                                        color:
                                            Theme.of(context).iconTheme.color,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: kDefaultPadding / 2),
                                  Text(
                                    counter.toString(),
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.color,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(width: kDefaultPadding / 2),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (counter < 10) {
                                          counter++;
                                        }
                                      });
                                    },
                                    child: CircleAvatar(
                                      radius: 18,
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      child: Icon(
                                        Icons.add,
                                        color:
                                            Theme.of(context).iconTheme.color,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(kDefaultPadding),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Consumer(
                            builder: (context, ref, child) {
                              final carts = ref.watch(cartsProvider);
                              if (carts.keys.toList().contains(widget.product)) {
                                return AppButton(
                                    text: 'Added to Cart',
                                    color: Colors.green,
                                    onPressed: () {});
                              } else {
                                return AppButton(
                                    text: 'Add to Card',
                                    onPressed: () {
                                      ref.read(cartsProvider.notifier).add(
                                          product: widget.product,
                                          count: counter);
                                    });
                              } // Hello world
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
