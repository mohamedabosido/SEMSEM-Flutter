import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tokoto/api/controller/products_api_controller.dart';
import 'package:tokoto/constant/constant.dart';
import 'package:tokoto/widgets/product_card.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchList = ref.watch(searchListProvider);
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        children: [
          TextFormField(
            initialValue: ref.watch(keywordProvider),
            textInputAction: TextInputAction.search,
            onChanged: (String value) {
              ref.read(keywordProvider.notifier).state = value;
            },
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1?.color,
              fontSize: 18,
            ),
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
          const SizedBox(height: kDefaultPadding),
          searchList.when(
            data: (data) {
              return data.isNotEmpty
                  ? Expanded(
                      child: GridView.count(
                        childAspectRatio: 0.59,
                        primary: false,
                        crossAxisCount: 2,
                        scrollDirection: Axis.vertical,
                        crossAxisSpacing: kDefaultPadding / 2,
                        children: List.generate(
                          data.length,
                          (index) => index % 2 == 0
                              ? ProductCard(
                                  product: data[index],
                                )
                              : Container(
                                  margin: const EdgeInsets.only(
                                      top: kDefaultPadding),
                                  child: ProductCard(
                                    product: data[index],
                                  ),
                                ),
                        ),
                      ),
                    )
                  : Center(
                      heightFactor: 10,
                      child: Image.asset('images/empty.png'),
                    );
            },
            error: (error, stack) {
              return Center(
                heightFactor: 10,
                child: Image.asset('images/empty.png'),
              );
            },
            loading: () {
              return const Center(
                heightFactor: 10,
                child: CupertinoActivityIndicator(
                  radius: 25,
                  animating: true,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
