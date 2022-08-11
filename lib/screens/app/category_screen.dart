import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tokoto/Models/category.dart';
import 'package:tokoto/api/controller/products_api_controller.dart';
import 'package:tokoto/constant/constant.dart';
import 'package:tokoto/widgets/app_app_bar.dart';
import 'package:tokoto/widgets/product_card.dart';
import 'package:flutter/cupertino.dart';

class CategoryScreen extends ConsumerWidget {
  final CategoryModel category;

  const CategoryScreen({required this.category, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoryProvider(category.id!));
    return Scaffold(
      appBar: AppAppBar(text: category.name!, automaticallyImplyLeading: true),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()
        ),
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              ref.refresh(categoryProvider(category.id!));
            },
          ),
          SliverPadding(
            padding: const EdgeInsets.all(kDefaultPadding),
            sliver: categories.when(
              data: (data) {
                return data.isNotEmpty
                    ? SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          childCount: data.length,
                          (context, index) {
                            return index % 2 == 0
                                ? ProductCard(
                                    product: data[index],
                                  )
                                : Container(
                                    margin: const EdgeInsets.only(
                                        top: kDefaultPadding),
                                    child: ProductCard(
                                      product: data[index],
                                    ),
                                  );
                          },
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.59,
                          crossAxisSpacing: kDefaultPadding / 2,
                        ),
                      )
                    : SliverToBoxAdapter(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height - 100,
                        child: Center(
                          child: Image.asset('images/empty.png'),
                        ),
                      ),
                    );
              },
              error: (error, stack) {
                return SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 100,
                    child: Center(
                      child: Image.asset('images/empty.png'),
                    ),
                  ),
                );
              },
              loading: () {
                return  SliverToBoxAdapter(
                  child:  SizedBox(
                    height: MediaQuery.of(context).size.height - 100,
                    child: const Center(
                      child: CupertinoActivityIndicator(
                        radius: 25,
                        animating: true,
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
