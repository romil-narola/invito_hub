import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/app_notification.dart';

class MockNotificationRepository {
  static final MockNotificationRepository _instance =
      MockNotificationRepository._internal();
  factory MockNotificationRepository() => _instance;
  final ValueNotifier<List<AppNotification>> notificationsNotifier =
      ValueNotifier<List<AppNotification>>([]);

  MockNotificationRepository._internal() {
    notificationsNotifier.value = List.unmodifiable(_notifications);
  }

  final List<AppNotification> _notifications = [
    AppNotification(
      id: 'notif-1',
      title: 'Fund Request',
      message: 'Romil Narola requested \$175.00 for Sarah\'s Graduation Party.',
      date: DateTime.now().subtract(const Duration(minutes: 5)),
      isRead: false,
      type: NotificationType.fundRequest,
      metadata: const {'invitationId': 'mock-id-1', 'amount': 175.0},
    ),
    AppNotification(
      id: 'notif-2',
      title: 'RSVP Update',
      message: 'Alice has accepted your invitation to the Weekend BBQ.',
      date: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: true,
      type: NotificationType.rsvpUpdate,
    ),
    AppNotification(
      id: 'notif-3',
      title: 'Reminder',
      message: 'Annual Tech Meetup is coming up in 2 days!',
      date: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
      type: NotificationType.general,
    ),
  ];

  void _notifyListeners() {
    notificationsNotifier.value = List.unmodifiable(_notifications);
  }

  Future<List<AppNotification>> getNotifications() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_notifications);
  }

  Future<void> markAsRead(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
      _notifyListeners();
    }
  }

  Future<void> markAllAsRead() async {
    await Future.delayed(const Duration(milliseconds: 200));
    for (int i = 0; i < _notifications.length; i++) {
      _notifications[i] = _notifications[i].copyWith(isRead: true);
    }
    _notifyListeners();
  }

  Future<void> addNotification(AppNotification notification) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _notifications.insert(0, notification);
    _notifyListeners();
  }
}
