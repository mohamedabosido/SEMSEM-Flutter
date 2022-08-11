import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tokoto/Models/product.dart';
import 'package:tokoto/api/controller/favorite_api_controller.dart';
import 'package:tokoto/constant/constant.dart';
import 'package:tokoto/screens/app/product_detail_screen.dart';

class ProductCard extends ConsumerWidget {
  final ProductModel product;

  const ProductCard({
    required this.product,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    return Container(
      margin: const EdgeInsetsDirectional.only(end: kDefaultPadding / 2),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(product: product),
                  ));
            },
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(product.images!.entries.first.value.first),
            ),
          ),
          const SizedBox(height: kDefaultPadding / 2),
          Text(
            product.title!,
            maxLines: 2,
            style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).textTheme.bodyText1?.color),
          ),
          const SizedBox(height: kDefaultPadding / 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$ ${product.price}',
                style: const TextStyle(
                  fontSize: 24,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (favorites.contains(product)) {
                    ref
                        .read(favoritesProvider.notifier)
                        .delete(product: product);
                  } else {
                    ref.read(favoritesProvider.notifier).add(product: product);
                  }
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor:
                      favorites.contains(product) &&
                              Theme.of(context).brightness == Brightness.light
                          ? kOffRedColor
                          : Theme.of(context).backgroundColor,
                  child: Icon(
                    Icons.favorite,
                    color: favorites.contains(product)
                        ? Colors.red
                        : kUnSelectedColor,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
