import 'package:uuid/uuid.dart';
import 'package:flutter/foundation.dart';
import '../models/invitation.dart';
import '../models/invitation_type.dart';
import '../models/rsvp_status.dart';

class MockInvitationRepository {
  static final MockInvitationRepository _instance =
      MockInvitationRepository._internal();
  factory MockInvitationRepository() => _instance;
  MockInvitationRepository._internal() {
    invitationsNotifier.value = List.unmodifiable(_invitations);
  }

  final ValueNotifier<List<Invitation>> invitationsNotifier =
      ValueNotifier<List<Invitation>>([]);

  final List<Invitation> _invitations = [
    Invitation(
      id: 'mock-id-1',
      type: InvitationType.graduation,
      eventTitle: 'Sarah\'s Graduation Party',
      hostName: 'Sarah',
      dateTime: DateTime.now().add(const Duration(days: 3)),
      location: '123 Main St, Central Park',
      customMessage:
          'Please join us in celebrating Sarah\'s graduation! Food and drinks will be provided.',
      invitedContacts: ['+1234567890', '+0987654321'],
      rsvps: {
        '+1234567890': RSVPStatus.attending,
        '+0987654321': RSVPStatus.pending,
      },
      templateName: 'Party',
      remindersEnabled: true,
      coHosts: ['Alice'],
      estimatedBudget: 500.0,
      currentExpenses: 350.0,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Invitation(
      id: 'mock-id-2',
      type: InvitationType.corporate,
      eventTitle: 'Annual Tech Meetup',
      hostName: 'GDG Group',
      dateTime: DateTime.now().add(const Duration(days: 14)),
      location: 'Tech Hub Center',
      customMessage:
          'Join us for our annual tech meetup where we discuss the latest in Flutter and AI.',
      invitedContacts: ['+1122334455'],
      rsvps: {'+1122334455': RSVPStatus.declined},
      templateName: 'Modern',
      remindersEnabled: false,
      coHosts: ['Bob', 'Charlie'],
      estimatedBudget: 2000.0,
      currentExpenses: 450.0,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Invitation(
      id: 'mock-id-3',
      type: InvitationType.other,
      eventTitle: 'Weekend BBQ',
      hostName: 'John Doe',
      dateTime: DateTime.now().add(const Duration(days: 5)),
      location: 'My Backyard',
      customMessage:
          'Bring your own beverages. Meat and vegan options will be grilling all afternoon.',
      invitedContacts: ['+1555555555', '+1666666666', '+1777777777'],
      rsvps: {
        '+1555555555': RSVPStatus.attending,
        '+1666666666': RSVPStatus.attending,
        '+1777777777': RSVPStatus.declined,
      },
      templateName: 'Classic',
      remindersEnabled: true,
      coHosts: [],
      estimatedBudget: 150.0,
      currentExpenses: 150.0,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];
  final Uuid _uuid = const Uuid();

  Future<void> saveInvitation(Invitation invitation) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network
    final index = _invitations.indexWhere((i) => i.id == invitation.id);
    if (index != -1) {
      _invitations[index] = invitation;
    } else {
      _invitations.insert(0, invitation); // Add to beginning
    }
    invitationsNotifier.value = List.unmodifiable(_invitations);
  }

  Future<List<Invitation>> getInvitations() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network
    return List.unmodifiable(_invitations);
  }

  String generateId() {
    return _uuid.v4();
  }
}
