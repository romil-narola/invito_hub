import 'package:equatable/equatable.dart';

enum NotificationType { fundRequest, general, rsvpUpdate }

class AppNotification extends Equatable {
  final String id;
  final String title;
  final String message;
  final DateTime date;
  final bool isRead;
  final NotificationType type;
  final Map<String, dynamic>? metadata;

  const AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.date,
    this.isRead = false,
    this.type = NotificationType.general,
    this.metadata,
  });

  AppNotification copyWith({
    String? id,
    String? title,
    String? message,
    DateTime? date,
    bool? isRead,
    NotificationType? type,
    Map<String, dynamic>? metadata,
  }) {
    return AppNotification(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      date: date ?? this.date,
      isRead: isRead ?? this.isRead,
      type: type ?? this.type,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  List<Object?> get props => [id, title, message, date, isRead, type, metadata];
}
