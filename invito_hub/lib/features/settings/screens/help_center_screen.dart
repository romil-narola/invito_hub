import 'package:flutter/material.dart';
import 'package:invito_hub/l10n/app_localizations.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settingsHelpCenter),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildHelpItem(
            context,
            'How do I create a new invitation?',
            'Tap the "New Invite" button on the Home screen. Fill out the event details, choose a template, and attach any relevant documents. Then proceed to preview and send it.',
          ),
          _buildHelpItem(
            context,
            'Can I send invitations to multiple people?',
            'Yes. When creating an invitation, you can select multiple contacts from your phonebook. The app will help you send individual messages via WhatsApp or SMS to each selected contact.',
          ),
          _buildHelpItem(
            context,
            'How do I edit my profile?',
            'Go to the Settings screen and tap the pencil/edit icon next to your profile picture. You can update your name, email, phone number, and profile picture there.',
          ),
          _buildHelpItem(
            context,
            'How do I change the app language?',
            'Go to the Settings screen, tap on "Language" under Preferences, and select your preferred language (e.g., English, Hindi, Gujarati).',
          ),
          const SizedBox(height: 32),
          Center(
            child: Text(
              'Still need help? Contact support at support@invitohub.com',
              style: TextStyle(color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpItem(BuildContext context, String question, String answer) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ExpansionTile(
        shape: const Border(),
        collapsedShape: const Border(),
        title: Text(
          question,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        childrenPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            answer,
            style: TextStyle(color: Colors.grey.shade700, height: 1.5),
          ),
        ],
      ),
    );
  }
}
