import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tokoto/api/controller/favorite_api_controller.dart';
import 'package:tokoto/constant/constant.dart';
import 'package:tokoto/widgets/app_app_bar.dart';
import 'package:tokoto/widgets/product_card.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    return Scaffold(
      appBar: const AppAppBar(
        text: 'Favorites',
        automaticallyImplyLeading: false,
      ),
      body: favorites.isNotEmpty
          ? GridView.count(
              padding: const EdgeInsets.all(kDefaultPadding),
              childAspectRatio: 0.59,
              primary: false,
              crossAxisCount: 2,
              scrollDirection: Axis.vertical,
              crossAxisSpacing: kDefaultPadding / 2,
              children: List.generate(
                favorites.length,
                (index) => index % 2 == 0
                    ? ProductCard(product: favorites[index])
                    : Container(
                        margin: const EdgeInsets.only(top: kDefaultPadding),
                        child: ProductCard(product: favorites[index]),
                      ),
              ),
            )
          : Center(child: Image.asset('images/empty.png')),
    );
  }
}
