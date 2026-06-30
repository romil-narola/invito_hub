import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invito_hub/l10n/app_localizations.dart';
import '../models/invitation.dart';
import '../models/rsvp_status.dart';
import '../repository/mock_invitation_repository.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final MockInvitationRepository _repository = MockInvitationRepository();
  List<Invitation> _invitations = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final invitations = await _repository.getInvitations();
    setState(() {
      _invitations = invitations;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.historyScreenTitle),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _invitations.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox, size: 64, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.historyScreenNoInvitations,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _invitations.length,
              itemBuilder: (context, index) {
                final inv = _invitations[index];
                int attending = 0;
                int declined = 0;
                int pending = 0;
                for (final contact in inv.invitedContacts) {
                  final status = inv.rsvps[contact] ?? RSVPStatus.pending;
                  if (status == RSVPStatus.attending) {
                    attending++;
                  } else if (status == RSVPStatus.declined) {
                    declined++;
                  } else {
                    pending++;
                  }
                }

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C63FF).withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        inv.type.icon,
                        color: const Color(0xFF6C63FF),
                      ),
                    ),
                    title: Text(
                      inv.eventTitle,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          AppLocalizations.of(context)!.historyScreenDate(
                            DateFormat.yMMMd().format(inv.dateTime),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.check_circle,
                              size: 14,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '$attending',
                              style: const TextStyle(fontSize: 12),
                            ),
                            const SizedBox(width: 12),
                            const Icon(
                              Icons.cancel,
                              size: 14,
                              color: Colors.red,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '$declined',
                              style: const TextStyle(fontSize: 12),
                            ),
                            const SizedBox(width: 12),
                            const Icon(
                              Icons.access_time_filled,
                              size: 14,
                              color: Colors.orange,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '$pending',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/invitation-details',
                        arguments: inv,
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
