import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tokoto/api/controller/notification_controller.dart';
import 'package:tokoto/constant/constant.dart';
import 'package:tokoto/screens/app/profile_sub_screens/feedback_product_screen.dart';
import 'package:tokoto/widgets/app_app_bar.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationsProvider);
    // ref.read(notificationsProvider.notifier).mackAllRead();
    return Scaffold(
      appBar: const AppAppBar(text: 'Notification'),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: notifications.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Activity',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FeedbackProductScreen(
                                      product: notifications[index].product),
                                ));
                          },
                          child: Slidable(
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  autoClose: true,
                                  onPressed: (BuildContext context) {
                                    ref
                                        .read(notificationsProvider.notifier)
                                        .delete(
                                            notification: notifications[index]);
                                  },
                                  backgroundColor: Theme.of(context).backgroundColor,
                                  foregroundColor: Colors.red,
                                  icon: Icons.delete_outline_rounded,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ],
                            ),
                            child: Container(
                              margin:
                                  const EdgeInsets.only(top: kDefaultPadding),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Theme.of(context).backgroundColor,
                                  radius: 25,
                                  child: SvgPicture.asset('images/Parcel.svg'),
                                ),
                                title: Text(
                                  'Order ${notifications[index].type}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Order ${notifications[index].id} has been completed & arrived at the destination address ( Please rates your order )',
                                      style:  TextStyle(
                                        fontSize: 18,
                                        color: Theme.of(context).textTheme.bodyText1?.color?.withOpacity(0.8),
                                      ),
                                    ),
                                    const SizedBox(height: kDefaultPadding / 6),
                                    Text(
                                      notifications[index].time.toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Color(0xffBBBBBB),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              )
            : Center(child: Image.asset('images/notification.png')),
      ),
    );
  }
}
