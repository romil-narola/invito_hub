import 'package:equatable/equatable.dart';
import 'invitation_type.dart';
import 'rsvp_status.dart';

class Invitation extends Equatable {
  final String id;
  final InvitationType type;
  final String eventTitle;
  final String hostName;
  final DateTime dateTime;
  final String? location;
  final String customMessage;
  final List<String> invitedContacts;
  final DateTime createdAt;
  final List<String> attachedDocuments;
  final Map<String, RSVPStatus> rsvps;
  final String? templateName;
  final bool remindersEnabled;
  final List<String> coHosts;
  final double? estimatedBudget;
  final double? currentExpenses;

  const Invitation({
    required this.id,
    required this.type,
    required this.eventTitle,
    required this.hostName,
    required this.dateTime,
    this.location,
    required this.customMessage,
    required this.invitedContacts,
    required this.createdAt,
    this.attachedDocuments = const [],
    this.rsvps = const {},
    this.templateName,
    this.remindersEnabled = false,
    this.coHosts = const [],
    this.estimatedBudget,
    this.currentExpenses,
  });

  Invitation copyWith({
    String? id,
    InvitationType? type,
    String? eventTitle,
    String? hostName,
    DateTime? dateTime,
    String? location,
    String? customMessage,
    List<String>? invitedContacts,
    DateTime? createdAt,
    List<String>? attachedDocuments,
    Map<String, RSVPStatus>? rsvps,
    String? templateName,
    bool? remindersEnabled,
    List<String>? coHosts,
    double? estimatedBudget,
    double? currentExpenses,
  }) {
    return Invitation(
      id: id ?? this.id,
      type: type ?? this.type,
      eventTitle: eventTitle ?? this.eventTitle,
      hostName: hostName ?? this.hostName,
      dateTime: dateTime ?? this.dateTime,
      location: location ?? this.location,
      customMessage: customMessage ?? this.customMessage,
      invitedContacts: invitedContacts ?? this.invitedContacts,
      createdAt: createdAt ?? this.createdAt,
      attachedDocuments: attachedDocuments ?? this.attachedDocuments,
      rsvps: rsvps ?? this.rsvps,
      templateName: templateName ?? this.templateName,
      remindersEnabled: remindersEnabled ?? this.remindersEnabled,
      coHosts: coHosts ?? this.coHosts,
      estimatedBudget: estimatedBudget ?? this.estimatedBudget,
      currentExpenses: currentExpenses ?? this.currentExpenses,
    );
  }

  @override
  List<Object?> get props => [
    id,
    type,
    eventTitle,
    hostName,
    dateTime,
    location,
    customMessage,
    invitedContacts,
    createdAt,
    attachedDocuments,
    rsvps,
    templateName,
    remindersEnabled,
    coHosts,
    estimatedBudget,
    currentExpenses,
  ];
}
