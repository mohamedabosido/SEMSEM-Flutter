import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tokoto/Models/notification.dart';
import 'package:tokoto/api/controller/cart_api_controller.dart';
import 'package:tokoto/api/controller/notification_controller.dart';
import 'package:tokoto/api/controller/order_api_controller.dart';
import 'package:tokoto/constant/constant.dart';
import 'package:tokoto/prefs/user_preferences_controller.dart';
import 'package:tokoto/screens/app/product_detail_screen.dart';
import 'package:tokoto/widgets/app_app_bar.dart';
import 'package:tokoto/widgets/header_widget.dart';
import 'package:tokoto/widgets/voucher_code_widget.dart';

class CheckOutScreen extends ConsumerStatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends ConsumerState<CheckOutScreen> {
  int currentIndex = 0;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final carts = ref.watch(cartsProvider);
    return Scaffold(
      appBar: const AppAppBar(text: 'Check Out'),
      bottomNavigationBar: VoucherCodeWidget(
        text: 'Pay Now',
        onPressed: () {
          carts.forEach((key, value) {
            ref.read(notificationsProvider.notifier).add(
                  notification: NotificationModel(
                    id: Random().nextInt(100),
                    type: 'Success',
                    // uid: UserPreferencesController().uid,
                    product: key,
                    isRead: false,
                  ),
                );
            ref.read(ordersProvider.notifier).add(product: key, count: value);
          });
          Navigator.pushReplacementNamed(context, '/order_success_screen');
          carts.clear();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: ListView(
          children: [
            HeaderWidget(
                text: 'Your Chart',
                onPressed: () {
                  Navigator.pushNamed(context, '/cart_screen');
                }),
            const SizedBox(height: kDefaultPadding / 2),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: carts.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(
                                product: carts.keys.toList()[index]),
                          ));
                    },
                    child: Container(
                      margin: const EdgeInsetsDirectional.only(
                          end: kDefaultPadding / 3),
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
                  );
                },
              ),
            ),
            const SizedBox(height: kDefaultPadding),
            HeaderWidget(
                text: 'Your Address',
                subText: 'Edit Address',
                onPressed: () {
                  Navigator.pushNamed(context, '/my_account_screen');
                }),
            const SizedBox(height: kDefaultPadding / 3),
            Text(
              UserPreferencesController().user.address,
              style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.color
                      ?.withOpacity(0.6),
                  fontSize: 18),
            ),
            const SizedBox(height: kDefaultPadding),
            HeaderWidget(
                text: 'Shipping Options',
                subText: 'Choose Service',
                onPressed: () {}),
            const SizedBox(height: kDefaultPadding / 3),
            ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child:
                    Image.asset('images/fedex-express.png', fit: BoxFit.cover),
              ),
              title: const Text(
                '\$131.18',
                style: TextStyle(color: kPrimaryColor, fontSize: 18),
              ),
              subtitle: Text(
                'Will be received on July 12, 2020',
                style: TextStyle(
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.color
                        ?.withOpacity(0.6),
                    fontSize: 18),
              ),
            ),
            const SizedBox(height: kDefaultPadding),
            HeaderWidget(
                text: 'Payment Methods', subText: 'View All', onPressed: () {}),
            const SizedBox(height: kDefaultPadding / 3),
            SizedBox(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsetsDirectional.only(
                          end: kDefaultPadding / 3),
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(10),
                        border: currentIndex == index
                            ? Border.all(color: kPrimaryColor)
                            : const Border(),
                        image: DecorationImage(
                          image: AssetImage(
                            paymentMethod[index],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
