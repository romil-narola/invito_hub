import 'package:flutter/material.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/contacts/screens/contacts_picker_screen.dart';
import '../../features/invitations/screens/create_invitation_screen.dart';
import '../../features/invitations/screens/preview_invitation_screen.dart';
import '../../features/invitations/screens/invitation_details_screen.dart';
import '../../features/invitations/screens/history_screen.dart';
import '../../features/invitations/screens/event_gallery_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../features/settings/screens/help_center_screen.dart';
import '../../features/settings/screens/privacy_policy_screen.dart';
import '../../features/invitations/models/invitation.dart';
import '../../features/notifications/screens/notifications_screen.dart';

class AppRouter {
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  static const String contactsRoute = '/contacts';
  static const String createInvitationRoute = '/create-invitation';
  static const String previewInvitationRoute = '/preview-invitation';
  static const String invitationDetailsRoute = '/invitation-details';
  static const String historyRoute = '/history';
  static const String settingsRoute = '/settings';
  static const String helpCenterRoute = '/help-center';
  static const String privacyPolicyRoute = '/privacy-policy';
  static const String eventGalleryRoute = '/event-gallery';
  static const String notificationsRoute = '/notifications';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case contactsRoute:
        return MaterialPageRoute(builder: (_) => const ContactsPickerScreen());
      case createInvitationRoute:
        final inv = settings.arguments as Invitation?;
        return MaterialPageRoute(
          builder: (_) => CreateInvitationScreen(invitationToEdit: inv),
        );
      case previewInvitationRoute:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => PreviewInvitationScreen(
            invitation: args?['invitation'],
            contacts: args?['contacts'] ?? [],
          ),
        );
      case invitationDetailsRoute:
        final inv = settings.arguments as Invitation;
        return MaterialPageRoute(
          builder: (_) => InvitationDetailsScreen(invitation: inv),
        );
      case historyRoute:
        return MaterialPageRoute(builder: (_) => const HistoryScreen());
      case settingsRoute:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case helpCenterRoute:
        return MaterialPageRoute(builder: (_) => const HelpCenterScreen());
      case privacyPolicyRoute:
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen());
      case eventGalleryRoute:
        return MaterialPageRoute(builder: (_) => const EventGalleryScreen());
      case notificationsRoute:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
