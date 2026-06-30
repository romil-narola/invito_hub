import '../models/guest_group.dart';

class MockGuestGroupRepository {
  static final MockGuestGroupRepository _instance =
      MockGuestGroupRepository._internal();
  factory MockGuestGroupRepository() => _instance;
  MockGuestGroupRepository._internal();

  final List<GuestGroup> _groups = [
    const GuestGroup(
      id: 'g1',
      name: 'Family',
      contactPhones: ['+1234567890', '+0987654321', '+1122334455'],
    ),
    const GuestGroup(
      id: 'g2',
      name: 'Colleagues',
      contactPhones: ['+1555555555', '+1666666666'],
    ),
    const GuestGroup(
      id: 'g3',
      name: 'Football Team',
      contactPhones: ['+1777777777'],
    ),
  ];

  Future<List<GuestGroup>> getGroups() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_groups);
  }
}
