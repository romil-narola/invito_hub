import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/app_notification.dart';
import '../repository/mock_notification_repository.dart';
import '../../invitations/repository/mock_invitation_repository.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final _repository = MockNotificationRepository();
  List<AppNotification> _notifications = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    final notifications = await _repository.getNotifications();

    // Sort by date descending
    notifications.sort((a, b) => b.date.compareTo(a.date));

    setState(() {
      _notifications = notifications;
      _isLoading = false;
    });
  }

  Future<void> _markAllAsRead() async {
    await _repository.markAllAsRead();
    _loadNotifications();
  }

  Future<void> _markAsRead(String id) async {
    await _repository.markAsRead(id);
    _loadNotifications();
  }

  Widget _buildNotificationIcon(NotificationType type) {
    switch (type) {
      case NotificationType.fundRequest:
        return const CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.attach_money, color: Colors.white),
        );
      case NotificationType.rsvpUpdate:
        return const CircleAvatar(
          backgroundColor: Colors.green,
          child: Icon(Icons.how_to_reg, color: Colors.white),
        );
      case NotificationType.general:
        return CircleAvatar(
          backgroundColor: Colors.grey.shade400,
          child: const Icon(Icons.notifications, color: Colors.white),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasUnread = _notifications.any((n) => !n.isRead);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          if (hasUnread)
            TextButton(
              onPressed: _markAllAsRead,
              child: const Text('Mark all as read'),
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _notifications.isEmpty
          ? const Center(child: Text('No notifications yet.'))
          : ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _notifications.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final notification = _notifications[index];
                return _buildNotificationTile(notification);
              },
            ),
    );
  }

  Widget _buildNotificationTile(AppNotification notification) {
    final bool isFundRequest =
        notification.type == NotificationType.fundRequest;

    return InkWell(
      onTap: () {
        if (!notification.isRead) {
          _markAsRead(notification.id);
        }
      },
      child: Container(
        color: notification.isRead
            ? Colors.transparent
            : Colors.blue.withValues(alpha: 0.05),
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNotificationIcon(notification.type),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: TextStyle(
                            fontWeight: notification.isRead
                                ? FontWeight.normal
                                : FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        DateFormat.MMMd().add_jm().format(notification.date),
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    notification.message,
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  if (isFundRequest && !notification.isRead) ...[
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () async {
                        if (!notification.isRead) {
                          _markAsRead(notification.id);
                        }

                        if (notification.metadata != null &&
                            notification.metadata!['invitationId'] != null) {
                          final invId =
                              notification.metadata!['invitationId'] as String;
                          final amount =
                              (notification.metadata!['amount'] as num?)
                                  ?.toDouble() ??
                              0.0;
                          final repo = MockInvitationRepository();
                          final invites = await repo.getInvitations();
                          final index = invites.indexWhere(
                            (i) => i.id == invId,
                          );
                          if (index != -1) {
                            final inv = invites[index];
                            final newExpenses =
                                (inv.currentExpenses ?? 0.0) - amount;
                            await repo.saveInvitation(
                              inv.copyWith(currentExpenses: newExpenses),
                            );
                          }
                        }

                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Payment simulated successfully! (Mock)',
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Settle Up'),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
