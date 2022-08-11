import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tokoto/constant/constant.dart';
import 'package:tokoto/widgets/product_card.dart';

Widget _loaderList(context) {
  return Shimmer.fromColors(
      baseColor: Theme.of(context).backgroundColor,
      highlightColor: kOffOrangeColor,
      child: SizedBox(
        height: 200,
        child: ListView.builder(
          itemCount: 3,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return SizedBox(
              width: 200,
              child: Container(
                margin: const EdgeInsets.only(right: kDefaultPadding / 2),
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: kOffWhiteColor,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            );
          },
        ),
      ));
}

Widget popularsWidget(List populars, context) {
  return populars.isNotEmpty
      ? SizedBox(
          height: 330,
          child: ListView.builder(
            itemCount: populars.length < 3 ? populars.length : 3,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 200,
                child: ProductCard(product: populars[index]),
              );
            },
          ),
        )
      : _loaderList(context);
}
