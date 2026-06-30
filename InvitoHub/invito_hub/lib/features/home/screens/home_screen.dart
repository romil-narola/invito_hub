import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/routing/app_router.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_event.dart';
import '../../invitations/repository/mock_invitation_repository.dart';
import 'package:intl/intl.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:invito_hub/l10n/app_localizations.dart';
import '../../invitations/models/invitation.dart';
import '../../notifications/repository/mock_notification_repository.dart';
import '../../notifications/models/app_notification.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Invitation>> _invitationsFuture;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _invitationsFuture = MockInvitationRepository().getInvitations();
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _loadData();
    });
    await _invitationsFuture;
  }

  String _getGreeting(BuildContext context) {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return AppLocalizations.of(context)!.greetingMorning;
    } else if (hour < 17) {
      return AppLocalizations.of(context)!.greetingAfternoon;
    } else {
      return AppLocalizations.of(context)!.greetingEvening;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Attractive Custom Header
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 20,
              left: 24,
              right: 14,
              bottom: 30,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Profile & Greeting
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          child: const Icon(Icons.person_outline, size: 28),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _getGreeting(context),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              'Romil Narola',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Actions
                    Row(
                      children: [
                        ValueListenableBuilder<List<AppNotification>>(
                          valueListenable: MockNotificationRepository()
                              .notificationsNotifier,
                          builder: (context, notifications, child) {
                            final unreadCount = notifications
                                .where((n) => !n.isRead)
                                .length;
                            return Stack(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.notifications_outlined,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRouter.notificationsRoute,
                                    );
                                  },
                                ),
                                if (unreadCount > 0)
                                  Positioned(
                                    right: 8,
                                    top: 8,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        '$unreadCount',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.settings_outlined),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRouter.settingsRoute,
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.logout_rounded),
                          onPressed: () {
                            context.read<AuthBloc>().add(SignOutEvent());
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Text(
                  AppLocalizations.of(context)!.homeWelcomeBack,
                  style: Theme.of(
                    context,
                  ).textTheme.displayMedium?.copyWith(fontSize: 32),
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context)!.homeWhatToDoToday,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
                ),
              ],
            ),
          ),

          // Content below header
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 2,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildActionCard(
                              context,
                              title: AppLocalizations.of(
                                context,
                              )!.homeActionCreateTitle,
                              subtitle: AppLocalizations.of(
                                context,
                              )!.homeActionCreateSubtitle,
                              icon: Icons.add_circle_outline,
                              color: const Color(0xFF6C63FF),
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRouter.createInvitationRoute,
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildActionCard(
                              context,
                              title: AppLocalizations.of(
                                context,
                              )!.homeActionHistoryTitle,
                              subtitle: AppLocalizations.of(
                                context,
                              )!.homeActionHistorySubtitle,
                              icon: Icons.history,
                              color: const Color(0xFFFF6584),
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRouter.historyRoute,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        AppLocalizations.of(context)!.homeRecentActivity,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<Invitation>>(
                    future: _invitationsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final invitations = snapshot.data ?? [];
                      if (invitations.isEmpty) {
                        return RefreshIndicator(
                          onRefresh: _handleRefresh,
                          child: ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: [
                              const SizedBox(height: 40),
                              Icon(
                                Icons.inbox,
                                size: 64,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(height: 16),
                              Center(
                                child: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.homeNoRecentInvitations,
                                  style: TextStyle(color: Colors.grey.shade500),
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      final recentInvites = invitations.take(3).toList();
                      return RefreshIndicator(
                        onRefresh: _handleRefresh,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: recentInvites.length,
                          itemBuilder: (context, index) {
                            final inv = recentInvites[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                leading: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFF6C63FF,
                                    ).withValues(alpha: 0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    inv.type.icon,
                                    color: const Color(0xFF6C63FF),
                                  ),
                                ),
                                title: Text(
                                  inv.eventTitle,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  DateFormat.yMMMd().format(inv.dateTime),
                                ),
                                trailing: const Icon(
                                  Icons.chevron_right,
                                  size: 16,
                                ),
                                onTap: () {
                                  final dummyContacts = inv.invitedContacts.map(
                                    (phone) {
                                      return Contact(
                                        id: '',
                                        displayName: AppLocalizations.of(
                                          context,
                                        )!.guestNameWithPhone(phone),
                                        phones: [Phone(phone)],
                                      );
                                    },
                                  ).toList();

                                  Navigator.pushNamed(
                                    context,
                                    AppRouter.previewInvitationRoute,
                                    arguments: {
                                      'invitation': inv,
                                      'contacts': dummyContacts,
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, AppRouter.createInvitationRoute);
        },
        icon: const Icon(Icons.add),
        label: Text(AppLocalizations.of(context)!.homeFabNewInvite),
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: color,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
