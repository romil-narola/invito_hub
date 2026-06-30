import 'package:flutter/material.dart';

enum InvitationType {
  birthday('Birthday', Icons.cake),
  anniversary('Anniversary', Icons.favorite),
  marriage('Marriage', Icons.volunteer_activism),
  death('Death / Memorial', Icons.nature),
  babyShower('Baby Shower', Icons.child_care),
  graduation('Graduation', Icons.school),
  housewarming('Housewarming', Icons.home),
  corporate('Corporate', Icons.business),
  retirement('Retirement', Icons.work_off),
  engagement('Engagement', Icons.diamond),
  holidayParty('Holiday Party', Icons.park),
  dinnerParty('Dinner Party', Icons.restaurant),
  farewell('Farewell', Icons.flight_takeoff),
  networking('Networking', Icons.people),
  reunion('Reunion', Icons.group),
  other('Other', Icons.event);

  final String displayName;
  final IconData icon;

  const InvitationType(this.displayName, this.icon);

  List<Color> get gradientColors {
    switch (this) {
      case InvitationType.birthday:
        return const [Color(0xFF4A00E0), Color(0xFF8E2DE2)];
      case InvitationType.anniversary:
        return const [Color(0xFF800000), Color(0xFFC70039)];
      case InvitationType.marriage:
        return const [Color(0xFF355C7D), Color(0xFF6C5B7B)];
      case InvitationType.death:
        return const [Color(0xFF141E30), Color(0xFF243B55)];
      case InvitationType.babyShower:
        return const [Color(0xFF000851), Color(0xFF1CB5E0)];
      case InvitationType.graduation:
        return const [Color(0xFF1F1C2C), Color(0xFF928DAB)];
      case InvitationType.housewarming:
        return const [Color(0xFF0B486B), Color(0xFFF56217)];
      case InvitationType.corporate:
        return const [Color(0xFF0F2027), Color(0xFF203A43)];
      case InvitationType.retirement:
        return const [Color(0xFF1A2980), Color(0xFF26D0CE)];
      case InvitationType.engagement:
        return const [Color(0xFF5B247A), Color(0xFF1BCEDF)];
      case InvitationType.holidayParty:
        return const [Color(0xFF134E5E), Color(0xFF71B280)];
      case InvitationType.dinnerParty:
        return const [Color(0xFF23074D), Color(0xFFCC5333)];
      case InvitationType.farewell:
        return const [Color(0xFF000000), Color(0xFF53346D)];
      case InvitationType.networking:
        return const [Color(0xFF021B79), Color(0xFF0575E6)];
      case InvitationType.reunion:
        return const [Color(0xFF136A8A), Color(0xFF267871)];
      case InvitationType.other:
        return const [Color(0xFF240B36), Color(0xFFC31432)];
    }
  }
}
