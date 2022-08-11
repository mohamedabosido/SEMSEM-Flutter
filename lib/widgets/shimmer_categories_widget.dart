import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tokoto/constant/constant.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tokoto/screens/app/category_screen.dart';

Widget _loaderList(context) {
  return Shimmer.fromColors(
      baseColor: Theme.of(context).backgroundColor,
      highlightColor: kOffOrangeColor,
      child: SizedBox(
        height: 125,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 6,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(
                      end: kDefaultPadding / 3),
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kOffOrangeColor,
                  ),
                ),
                const SizedBox(height: kDefaultPadding / 6),
              ],
            );
          },
        ),
      ));
}

Widget categoriesWidget(List categories, context) {
  return categories.isNotEmpty
      ? SizedBox(
          height: 125,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CategoryScreen(category: categories[index]),
                      ));
                },
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsetsDirectional.only(
                          end: kDefaultPadding / 3),
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                                NetworkImage('${categories[index].icon!}'),
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).brightness ==
                                  Brightness.dark
                              ? Theme.of(context).backgroundColor
                              : kOffOrangeColor),
                    ),
                    const SizedBox(height: kDefaultPadding / 6),
                    SizedBox(
                      width: 80,
                      child: Center(
                        child: Text(
                          categories[index].name!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).textTheme.bodyText1?.color?.withOpacity(0.8),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        )
      : _loaderList(context);
}
