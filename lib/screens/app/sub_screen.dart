import 'package:flutter/material.dart';
import 'package:tokoto/Models/product.dart';
import 'package:tokoto/constant/constant.dart';
import 'package:tokoto/widgets/app_app_bar.dart';
import 'package:tokoto/widgets/product_card.dart';
class SubScreen extends StatelessWidget {
  final String text;
  final List<ProductModel> list;
  const SubScreen({
    required this.text,
    required this.list,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(text:text, automaticallyImplyLeading: true),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: list.isNotEmpty
            ? GridView.count(
          childAspectRatio: 0.59,
          primary: false,
          crossAxisCount: 2,
          scrollDirection: Axis.vertical,
          crossAxisSpacing: kDefaultPadding / 2,
          children: List.generate(
            list.length,
                (index) => index % 2 == 0
                ? ProductCard(
              product: list[index],
            )
                : Container(
              margin: const EdgeInsets.only(top: kDefaultPadding),
              child: ProductCard(
                product: list[index],
              ),
            ),
          ),
        )
            : Center(child: Image.asset('images/empty.png')),
      ),
    );
  }
}