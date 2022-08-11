import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tokoto/api/controller/products_api_controller.dart';
import 'package:tokoto/constant/constant.dart';
import 'package:tokoto/screens/app/category_screen.dart';

Widget _loaderList(context) {
  return Shimmer.fromColors(
      baseColor:  Theme.of(context).backgroundColor,
      highlightColor: kOffOrangeColor,
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          itemCount: 2,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
                margin:
                    const EdgeInsetsDirectional.only(end: kDefaultPadding / 2),
                padding: const EdgeInsets.all(kDefaultPadding / 2),
                width: 260,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kOffOrangeColor));
          },
        ),
      ));
}

class SpecialForYouWidget extends ConsumerStatefulWidget {
  const SpecialForYouWidget({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _SpecialForYouWidgetState();
}

class _SpecialForYouWidgetState extends ConsumerState<SpecialForYouWidget> {
  @override
  Widget build(BuildContext context) {
    final specialForYou = ref.watch(specialForYouProvider);
    return specialForYou.isNotEmpty
        ? SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: specialForYou.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CategoryScreen(category: specialForYou[index]),
                        ));
                  },
                  child: Container(
                    margin: const EdgeInsetsDirectional.only(
                        end: kDefaultPadding / 2),
                    padding: const EdgeInsets.all(kDefaultPadding / 2),
                    width: 260,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.network(specialForYou[index].icon!,
                            width: 55),
                        const SizedBox(width: kDefaultPadding / 2),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              specialForYou[index].name!,
                              style: const TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                            ref
                                .watch(
                                    categoryProvider(specialForYou[index].id!))
                                .when(data: (data) {
                              return Text(
                                data.length == 1
                                    ? '${data.length} Product'
                                    : '${data.length} Products',
                                style:  TextStyle(
                                  color: Theme.of(context).textTheme.bodyText1?.color,
                                  fontSize: 16,
                                ),
                              );
                            }, error: (error, stack) {
                              return const Text(
                                'No Products',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              );
                            }, loading: () {
                              return const CupertinoActivityIndicator();
                            }),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        : _loaderList(context);
  }
}
