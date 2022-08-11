import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tokoto/Models/notification.dart';

final notificationsProvider =
    StateNotifierProvider<GetNotifications, List<NotificationModel>>((ref) {
  return GetNotifications();
});

class GetNotifications extends StateNotifier<List<NotificationModel>> {
  GetNotifications() : super([]);

  void add({required NotificationModel notification}) {
    if (!state.contains(notification)) {
      state = [...state, notification];
    }
  }

  void delete({required NotificationModel notification}) {
    state = [
      for (final N in state)
        if (N.id != N.id) N,
    ];
  }
}

final unReadNotificationProvider = StateProvider<int>((ref) {
  final notifications = ref.watch(notificationsProvider);
  int counter = 0;
  for (final n in notifications) {
    if (n.isRead == false) {
      counter++;
    }
  }
  return counter;
});
