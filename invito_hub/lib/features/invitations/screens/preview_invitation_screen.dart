import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:open_filex/open_filex.dart';
import 'package:invito_hub/l10n/app_localizations.dart';
import '../models/invitation.dart';
import '../models/invitation_type.dart';
import '../repository/mock_invitation_repository.dart';

class PreviewInvitationScreen extends StatefulWidget {
  final Invitation? invitation;
  final List<Contact> contacts;

  const PreviewInvitationScreen({
    super.key,
    this.invitation,
    required this.contacts,
  });

  @override
  State<PreviewInvitationScreen> createState() =>
      _PreviewInvitationScreenState();
}

class _PreviewInvitationScreenState extends State<PreviewInvitationScreen> {
  bool _isSending = false;

  Future<void> _sendViaWhatsApp() async {
    if (widget.invitation == null) return;

    setState(() => _isSending = true);

    // Construct the message
    final message = _buildMessage();

    String phone = '';
    if (widget.contacts.isNotEmpty && widget.contacts.first.phones.isNotEmpty) {
      phone = widget.contacts.first.phones.first.number.replaceAll(
        RegExp(r'\D'),
        '',
      );
    }

    final url = Uri.parse(
      'https://wa.me/$phone?text=${Uri.encodeComponent(message)}',
    );

    try {
      await MockInvitationRepository().saveInvitation(widget.invitation!);

      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(context)!.previewScreenErrorWhatsApp,
              ),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(
                context,
              )!.previewScreenErrorGeneric(e.toString()),
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
        Navigator.popUntil(context, (route) => route.isFirst);
      }
    }
  }

  Future<void> _sendViaSMS() async {
    if (widget.invitation == null) return;

    setState(() => _isSending = true);

    final message = _buildMessage();

    // Create a comma-separated list of phone numbers for SMS
    final phoneNumbers = widget.contacts
        .where((c) => c.phones.isNotEmpty)
        .map((c) => c.phones.first.number)
        .join(',');

    final uri = Uri(
      scheme: 'sms',
      path: phoneNumbers,
      queryParameters: <String, String>{'body': message},
    );

    try {
      await MockInvitationRepository().saveInvitation(widget.invitation!);

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(context)!.previewScreenErrorSMS,
              ),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(
                context,
              )!.previewScreenErrorGeneric(e.toString()),
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
        Navigator.popUntil(context, (route) => route.isFirst);
      }
    }
  }

  String _buildMessage() {
    final inv = widget.invitation!;
    final dateStr = DateFormat('EEEE, MMMM d, yyyy').format(inv.dateTime);
    final timeStr = DateFormat('jm').format(inv.dateTime);

    return '''
🎉 You're Invited! 🎉

${inv.eventTitle}

Hosted by: ${inv.hostName}

📅 Date: $dateStr
⏰ Time: $timeStr
📍 Location: ${inv.location?.isNotEmpty == true ? inv.location : 'TBA'}

${inv.customMessage}

See you there!
''';
  }

  @override
  Widget build(BuildContext context) {
    if (widget.invitation == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.previewScreenErrorTitle),
        ),
        body: Center(
          child: Text(
            AppLocalizations.of(context)!.previewScreenErrorMissingData,
          ),
        ),
      );
    }

    final inv = widget.invitation!;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.previewScreenTitle),
        actionsPadding: EdgeInsets.only(right: 14),
        actions: [
          if (widget.invitation != null)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/create-invitation',
                  arguments: widget.invitation,
                );
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  colors: _getTemplateColors(inv),
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: _getTemplateColors(inv).first.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(32),
              width: double.infinity,
              child: _buildCardContent(inv),
            ),
            if (inv.attachedDocuments.isNotEmpty) ...[
              const SizedBox(height: 24),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 64.0 * 5),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: inv.attachedDocuments.length,
                  itemBuilder: (context, index) {
                    final docPath = inv.attachedDocuments[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                        onTap: () async {
                          final messenger = ScaffoldMessenger.of(context);
                          final result = await OpenFilex.open(docPath);
                          if (result.type != ResultType.done && mounted) {
                            messenger.showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Could not open document: ${result.message}',
                                ),
                              ),
                            );
                          }
                        },
                        tileColor: Colors.grey.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        leading: const Icon(
                          Icons.description,
                          color: Color(0xFF6C63FF),
                        ),
                        title: Text(
                          docPath.split('/').last.split('\\').last,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: const Icon(Icons.open_in_new, size: 16),
                      ),
                    );
                  },
                ),
              ),
            ],
            const SizedBox(height: 24),
            Text(
              AppLocalizations.of(
                context,
              )!.previewScreenReadyToSend(widget.contacts.length),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isSending ? null : _sendViaWhatsApp,
                    icon: const Icon(Icons.chat),
                    label: Text(
                      AppLocalizations.of(context)!.previewScreenWhatsAppLabel,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF25D366),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isSending ? null : _sendViaSMS,
                    icon: const Icon(Icons.sms, size: 20),
                    label: Text(
                      AppLocalizations.of(context)!.previewScreenSMSLabel,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Event added to your calendar (Mock)'),
                    ),
                  );
                },
                icon: const Icon(Icons.edit_calendar),
                label: const Text('Add to Calendar'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardContent(Invitation inv) {
    return Column(
      children: [
        _AnimatedEventIcon(type: inv.type, icon: inv.type.icon),
        const SizedBox(height: 24),
        Text(
          inv.type.displayName.toUpperCase(),
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.6),
            letterSpacing: 4,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          inv.eventTitle,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            letterSpacing: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        Container(width: 48, height: 1, color: Colors.white.withValues(alpha: 0.3)),
        const SizedBox(height: 32),
        _buildInfoRow(
          Icons.calendar_today,
          DateFormat('EEEE, MMM d, yyyy').format(inv.dateTime),
        ),
        const SizedBox(height: 16),
        _buildInfoRow(Icons.access_time, DateFormat('jm').format(inv.dateTime)),
        if (inv.location?.isNotEmpty == true) ...[
          const SizedBox(height: 16),
          _buildInfoRow(
            Icons.location_on,
            inv.location!,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Opening Maps for ${inv.location}... (Mock)'),
                ),
              );
            },
          ),
        ],
        const SizedBox(height: 40),
        Text(
          inv.customMessage,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.white.withValues(alpha: 0.9),
            height: 1.5,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        Text(
          'Hosted by ${inv.hostName}',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Colors.white.withValues(alpha: 0.5),
            fontStyle: FontStyle.italic,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String text, {VoidCallback? onTap}) {
    final row = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white.withValues(alpha: 0.7), size: 20),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              decoration: onTap != null ? TextDecoration.underline : null,
              decorationColor: Colors.white.withValues(alpha: 0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: row);
    }
    return row;
  }

  List<Color> _getTemplateColors(Invitation inv) {
    if (inv.templateName == 'Party') {
      return [const Color(0xFFFF512F), const Color(0xFFDD2476)];
    }
    if (inv.templateName == 'Modern') {
      return [const Color(0xFF141E30), const Color(0xFF243B55)];
    }
    if (inv.templateName == 'Elegant') {
      return [const Color(0xFFD4AF37), const Color(0xFF8E793E)];
    }
    if (inv.templateName == 'Minimal') {
      return [const Color(0xFF434343), const Color(0xFF000000)];
    }
    if (inv.templateName == 'Classic') {
      return [const Color(0xFF000428), const Color(0xFF004E92)];
    }
    return inv.type.gradientColors; // Fallback
  }
}

class _AnimatedEventIcon extends StatefulWidget {
  final InvitationType type;
  final IconData icon;

  const _AnimatedEventIcon({required this.type, required this.icon});

  @override
  State<_AnimatedEventIcon> createState() => _AnimatedEventIconState();
}

class _AnimatedEventIconState extends State<_AnimatedEventIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    switch (widget.type) {
      case InvitationType.birthday:
      case InvitationType.babyShower:
      case InvitationType.reunion:
        _controller.duration = const Duration(seconds: 1);
        _animation = Tween<double>(begin: -8.0, end: 8.0).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        );
        break;
      case InvitationType.anniversary:
      case InvitationType.marriage:
      case InvitationType.engagement:
        _controller.duration = const Duration(milliseconds: 800);
        _animation = Tween<double>(begin: 1.0, end: 1.3).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        );
        break;
      case InvitationType.death:
      case InvitationType.corporate:
      case InvitationType.retirement:
        _controller.duration = const Duration(seconds: 2);
        _animation = Tween<double>(begin: 0.4, end: 1.0).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        );
        break;
      default:
        _controller.duration = const Duration(milliseconds: 500);
        _animation = Tween<double>(begin: -0.15, end: 0.15).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        );
        break;
    }
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        switch (widget.type) {
          case InvitationType.birthday:
          case InvitationType.babyShower:
          case InvitationType.reunion:
            return Transform.translate(
              offset: Offset(0, _animation.value),
              child: child,
            );
          case InvitationType.anniversary:
          case InvitationType.marriage:
          case InvitationType.engagement:
            return Transform.scale(scale: _animation.value, child: child);
          case InvitationType.death:
          case InvitationType.corporate:
          case InvitationType.retirement:
            return Opacity(opacity: _animation.value, child: child);
          default:
            return Transform.rotate(angle: _animation.value, child: child);
        }
      },
      child: Icon(widget.icon, size: 36, color: Colors.white.withValues(alpha: 0.9)),
    );
  }
}
