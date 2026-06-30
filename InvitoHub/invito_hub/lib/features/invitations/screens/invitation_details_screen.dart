// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:invito_hub/l10n/app_localizations.dart';
import '../models/invitation.dart';
import '../../notifications/repository/mock_notification_repository.dart';
import '../../notifications/models/app_notification.dart';
import '../models/rsvp_status.dart';
import '../repository/mock_invitation_repository.dart';

class InvitationDetailsScreen extends StatefulWidget {
  final Invitation invitation;

  const InvitationDetailsScreen({super.key, required this.invitation});

  @override
  State<InvitationDetailsScreen> createState() =>
      _InvitationDetailsScreenState();
}

class _InvitationDetailsScreenState extends State<InvitationDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Invitation>>(
      valueListenable: MockInvitationRepository().invitationsNotifier,
      builder: (context, invitations, child) {
        final currentInvitation = invitations.firstWhere(
          (inv) => inv.id == widget.invitation.id,
          orElse: () => widget.invitation,
        );
        int attendingCount = 0;
        int declinedCount = 0;
        int pendingCount = 0;

        for (final contact in currentInvitation.invitedContacts) {
          final status = currentInvitation.rsvps[contact] ?? RSVPStatus.pending;
          if (status == RSVPStatus.attending) {
            attendingCount++;
          } else if (status == RSVPStatus.declined) {
            declinedCount++;
          } else {
            pendingCount++;
          }
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.detailsScreenTitle),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card (Fixed at top)
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: currentInvitation.type.gradientColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: currentInvitation.type.gradientColors.first
                            .withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            currentInvitation.type.icon,
                            color: Colors.white,
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              currentInvitation.eventTitle,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: Colors.white70,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            DateFormat.yMMMd().format(
                              currentInvitation.dateTime,
                            ),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            final dummyContacts = currentInvitation
                                .invitedContacts
                                .map((phone) {
                                  return Contact(
                                    id: '',
                                    displayName: AppLocalizations.of(
                                      context,
                                    )!.guestNameWithPhone(phone),
                                    phones: [Phone(phone)],
                                  );
                                })
                                .toList();
                            Navigator.pushNamed(
                              context,
                              '/preview-invitation',
                              arguments: {
                                'invitation': currentInvitation,
                                'contacts': dummyContacts,
                              },
                            );
                          },
                          icon: const Icon(Icons.remove_red_eye),
                          label: Text(
                            AppLocalizations.of(context)!.detailsScreenViewCard,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor:
                                currentInvitation.type.gradientColors.first,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Scrollable Content starts here
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Stats Row
                      Text(
                        AppLocalizations.of(context)!.detailsScreenRsvpSummary,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatCard(
                            AppLocalizations.of(
                              context,
                            )!.detailsScreenAttending,
                            attendingCount,
                            Colors.green,
                          ),
                          _buildStatCard(
                            AppLocalizations.of(context)!.detailsScreenPending,
                            pendingCount,
                            Colors.orange,
                          ),
                          _buildStatCard(
                            AppLocalizations.of(context)!.detailsScreenDeclined,
                            declinedCount,
                            Colors.red,
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // Reminders Toggle (Mock)
                      StatefulBuilder(
                        builder: (context, setStateLocal) {
                          bool isEnabled = currentInvitation.remindersEnabled;
                          return SwitchListTile(
                            title: const Text(
                              'Send 24h Automated Reminders',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: const Text(
                              'Notify guests who haven\'t RSVP\'d',
                            ),
                            value: isEnabled,
                            activeThumbColor: const Color(0xFF6C63FF),
                            onChanged: (val) {
                              setStateLocal(() => isEnabled = val);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Reminders ${val ? "enabled" : "disabled"} (Mock)',
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 24),

                      // Co-Hosts Section
                      if (currentInvitation.coHosts.isNotEmpty) ...[
                        const Text(
                          'Co-Hosts',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          children: currentInvitation.coHosts
                              .map(
                                (host) => Chip(
                                  avatar: CircleAvatar(child: Text(host[0])),
                                  label: Text(host),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 24),
                      ],

                      // Budget Tracker (Mock)
                      if (currentInvitation.estimatedBudget != null &&
                          currentInvitation.currentExpenses != null) ...[
                        const Text(
                          'Budget Tracker',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.grey.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Spent: \$${currentInvitation.currentExpenses}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Budget: \$${currentInvitation.estimatedBudget}',
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              LinearProgressIndicator(
                                value:
                                    currentInvitation.currentExpenses! /
                                    currentInvitation.estimatedBudget!,
                                backgroundColor: Colors.grey.shade300,
                                color:
                                    currentInvitation.currentExpenses! >
                                        currentInvitation.estimatedBudget!
                                    ? Colors.red
                                    : Colors.green,
                                minHeight: 8,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              if (currentInvitation.coHosts.isNotEmpty &&
                                  (currentInvitation.currentExpenses ?? 0) >
                                      0) ...[
                                const SizedBox(height: 16),
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton.icon(
                                    onPressed: () {
                                      _showSplitExpensesDialog(
                                        context,
                                        currentInvitation,
                                      );
                                    },
                                    icon: const Icon(Icons.payments),
                                    label: const Text('Split with Co-Hosts'),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],

                      // Share Web Link (Mock)
                      const Text(
                        'Share Web Link',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Colors.grey.shade300),
                        ),
                        leading: const Icon(
                          Icons.link,
                          color: Color(0xFF6C63FF),
                        ),
                        title: Text(
                          'invitohub.com/e/${currentInvitation.id.substring(0, 8)}',
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.copy),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Link copied! (Mock)'),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),

                      // View Event Gallery (Mock)
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(context, '/event-gallery');
                          },
                          icon: const Icon(Icons.photo_library),
                          label: const Text('View Event Gallery'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Guest List
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(
                              context,
                            )!.detailsScreenGuestList,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () => _showBulkUpdateDialog(context),
                            icon: const Icon(Icons.library_add_check, size: 18),
                            label: const Text('Bulk Update'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: currentInvitation.invitedContacts.length,
                        itemBuilder: (context, index) {
                          final phone =
                              currentInvitation.invitedContacts[index];
                          final status =
                              currentInvitation.rsvps[phone] ??
                              RSVPStatus.pending;

                          IconData icon;
                          Color color;
                          String statusText;

                          switch (status) {
                            case RSVPStatus.attending:
                              icon = Icons.check_circle;
                              color = Colors.green;
                              statusText = AppLocalizations.of(
                                context,
                              )!.detailsScreenAttending;
                              break;
                            case RSVPStatus.declined:
                              icon = Icons.cancel;
                              color = Colors.red;
                              statusText = AppLocalizations.of(
                                context,
                              )!.detailsScreenDeclined;
                              break;
                            case RSVPStatus.pending:
                              icon = Icons.access_time_filled;
                              color = Colors.orange;
                              statusText = AppLocalizations.of(
                                context,
                              )!.detailsScreenPending;
                              break;
                          }

                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              onTap: () =>
                                  _showRsvpDialog(context, phone, status),
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey.shade200,
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                ),
                              ),
                              title: Text(
                                AppLocalizations.of(
                                  context,
                                )!.guestNameWithPhone(phone),
                              ),
                              subtitle: Text(
                                phone,
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                              trailing: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: color.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(icon, color: color, size: 16),
                                    const SizedBox(width: 6),
                                    Text(
                                      statusText,
                                      style: TextStyle(
                                        color: color,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showRsvpDialog(
    BuildContext context,
    String phone,
    RSVPStatus currentStatus,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(
            top: 24,
            left: 24,
            right: 24,
            bottom: 48,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Manually Update RSVP',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                AppLocalizations.of(context)!.guestNameWithPhone(phone),
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              ...RSVPStatus.values.map((status) {
                return RadioListTile<RSVPStatus>(
                  title: Text(status.name.toUpperCase()),
                  value: status,
                  groupValue: currentStatus,
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        widget.invitation.rsvps[phone] = val;
                      });
                      Navigator.pop(context);
                    }
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  void _showSplitExpensesDialog(BuildContext context, Invitation invitation) {
    final totalSpent = invitation.currentExpenses ?? 0;
    final totalPeople = invitation.coHosts.length + 1; // Co-hosts + Host
    final splitAmount = (totalSpent / totalPeople).toStringAsFixed(2);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(
            top: 24,
            left: 24,
            right: 24,
            bottom: 48,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Expense Splitting',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                'Total Spent: \$$totalSpent',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              const Text(
                'Breakdown:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: const Text('You (Host)'),
                trailing: Text(
                  '\$$splitAmount',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ...invitation.coHosts.map(
                (host) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(child: Text(host[0])),
                  title: Text(host),
                  trailing: Text(
                    '\$$splitAmount',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context);

                    // Create a mock notification for the co-hosts
                    final notification = AppNotification(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      title: 'Fund Request',
                      message:
                          'You requested \$$splitAmount from your co-hosts for ${invitation.eventTitle}.',
                      date: DateTime.now(),
                      type: NotificationType.fundRequest,
                      metadata: {
                        'amount': double.tryParse(splitAmount) ?? 0.0,
                        'invitationId': invitation.id,
                      },
                    );
                    await MockNotificationRepository().addNotification(
                      notification,
                    );

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Requests sent to co-hosts (Mock)'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Request Funds',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showBulkUpdateDialog(BuildContext context) {
    Set<String> selectedPhones = {};
    RSVPStatus selectedStatus = RSVPStatus.attending;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Container(
              padding: EdgeInsets.only(
                top: 24,
                left: 24,
                right: 24,
                bottom: MediaQuery.of(context).viewInsets.bottom + 48,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Bulk Update RSVPs',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setSheetState(() {
                            if (selectedPhones.length ==
                                widget.invitation.invitedContacts.length) {
                              selectedPhones.clear();
                            } else {
                              selectedPhones.addAll(
                                widget.invitation.invitedContacts,
                              );
                            }
                          });
                        },
                        child: Text(
                          selectedPhones.length ==
                                  widget.invitation.invitedContacts.length
                              ? 'Deselect All'
                              : 'Select All',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.4,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.invitation.invitedContacts.length,
                      itemBuilder: (context, index) {
                        final phone = widget.invitation.invitedContacts[index];
                        final name = AppLocalizations.of(
                          context,
                        )!.guestNameWithPhone(phone);
                        return CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(name),
                          subtitle: Text(phone),
                          value: selectedPhones.contains(phone),
                          onChanged: (val) {
                            setSheetState(() {
                              if (val == true) {
                                selectedPhones.add(phone);
                              } else {
                                selectedPhones.remove(phone);
                              }
                            });
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Set Status To:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: RSVPStatus.values.map((status) {
                      return ChoiceChip(
                        label: Text(status.name.toUpperCase()),
                        selected: selectedStatus == status,
                        onSelected: (val) {
                          if (val) {
                            setSheetState(() {
                              selectedStatus = status;
                            });
                          }
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: selectedPhones.isEmpty
                          ? null
                          : () {
                              setState(() {
                                for (final phone in selectedPhones) {
                                  widget.invitation.rsvps[phone] =
                                      selectedStatus;
                                }
                              });
                              Navigator.pop(context);
                            },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'Update ${selectedPhones.length} Guests',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildStatCard(String label, int count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}
