import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tokoto/api/controller/cart_api_controller.dart';
import 'package:tokoto/constant/constant.dart';
import 'package:tokoto/helpers/helpers.dart';
import 'package:tokoto/widgets/app_app_bar.dart';
import 'package:tokoto/widgets/voucher_code_widget.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> with Helpers {
  @override
  Widget build(BuildContext context) {
    final carts = ref.watch(cartsProvider);
    return Scaffold(
        bottomNavigationBar: VoucherCodeWidget(
          text: 'Check out',
          onPressed: () {
            if (carts.isNotEmpty) {
              Navigator.pushNamed(context, '/check_out_screen');
            } else {
              showSnackBar(
                  context: context,
                  message: 'Please Add Products to Cart',
                  error: true);
            }
          },
        ),
        appBar: const AppAppBar(text: 'My Cart'),
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(top: kDefaultPadding),
              sliver: CupertinoSliverRefreshControl(
                onRefresh: () async {
                  ref.refresh(cartsProvider);
                  ref.refresh(cartTotalProvider);
                },
              ),
            ),
            carts.isNotEmpty
                ? SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                      childCount: carts.length,
                      (context, index) {
                        return Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                autoClose: true,
                                onPressed: (BuildContext context) {
                                  ref.read(cartsProvider.notifier).delete(
                                      product: carts.keys.toList()[index]);
                                },
                                backgroundColor:
                                    Theme.of(context).backgroundColor,
                                foregroundColor: Colors.red,
                                icon: Icons.delete_outline_rounded,
                                borderRadius: BorderRadius.circular(15),
                                // label: 'Archive',
                              ),
                            ],
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(top: kDefaultPadding),
                            child: ListTile(
                              leading: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).backgroundColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Image.network(
                                    carts.keys
                                        .toList()[index]
                                        .images!
                                        .entries
                                        .first
                                        .value
                                        .first,
                                    fit: BoxFit.cover),
                              ),
                              title: Text(
                                carts.keys.toList()[index].title!,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Row(
                                children: [
                                  Text(
                                    '\$ ${carts.keys.toList()[index].price}',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: kPrimaryColor),
                                  ),
                                  const SizedBox(width: kDefaultPadding / 3),
                                  Text(
                                    'x${carts.values.toList()[index]}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.color,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )),
                  )
                : SliverToBoxAdapter(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height - 300,
                      child:
                          Center(child: Image.asset('images/empty-cart.png')),
                    ),
                  )
          ],
        ));
  }
}
