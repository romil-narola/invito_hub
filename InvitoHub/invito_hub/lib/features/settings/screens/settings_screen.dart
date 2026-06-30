import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invito_hub/l10n/app_localizations.dart';
import 'package:invito_hub/core/theme/theme_cubit.dart';
import 'package:invito_hub/core/language/language_cubit.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_event.dart';
import 'edit_profile_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final currentLanguageCode = Localizations.localeOf(context).languageCode;
    final languageName = currentLanguageCode == 'hi'
        ? 'Hindi'
        : currentLanguageCode == 'gu'
        ? 'Gujarati'
        : 'English';

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settingsScreenTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          // Profile Section
          Row(
            children: [
              Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6C63FF), Color(0xFFFF6584)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6C63FF).withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'JD',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Doe',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '+1 234 567 8900',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Color(0xFF6C63FF)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfileScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 40),

          // Preferences Section
          Text(
            AppLocalizations.of(context)!.settingsPreferencesTitle,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          _buildSwitchTile(
            icon: Icons.notifications_active,
            title: AppLocalizations.of(context)!.settingsPushNotifications,
            subtitle: AppLocalizations.of(
              context,
            )!.settingsPushNotificationsSubtitle,
            value: _notificationsEnabled,
            onChanged: (val) => setState(() => _notificationsEnabled = val),
          ),
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              final isDark =
                  themeMode == ThemeMode.dark ||
                  (themeMode == ThemeMode.system &&
                      MediaQuery.of(context).platformBrightness ==
                          Brightness.dark);
              return _buildSwitchTile(
                icon: Icons.dark_mode,
                title: AppLocalizations.of(context)!.settingsDarkMode,
                subtitle: AppLocalizations.of(
                  context,
                )!.settingsDarkModeSubtitle,
                value: isDark,
                onChanged: (val) {
                  context.read<ThemeCubit>().toggleTheme(val);
                },
              );
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: _buildIcon(Icons.language),
            title: Text(
              AppLocalizations.of(context)!.settingsLanguage,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(languageName),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              _showLanguagePicker();
            },
          ),

          const SizedBox(height: 32),

          // Support Section
          Text(
            AppLocalizations.of(context)!.settingsSupportTitle,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: _buildIcon(Icons.help_outline),
            title: Text(
              AppLocalizations.of(context)!.settingsHelpCenter,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.pushNamed(context, '/help-center');
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: _buildIcon(Icons.privacy_tip_outlined),
            title: Text(
              AppLocalizations.of(context)!.settingsPrivacyPolicy,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.pushNamed(context, '/privacy-policy');
            },
          ),

          const SizedBox(height: 48),

          // Logout Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                context.read<AuthBloc>().add(SignOutEvent());
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              icon: const Icon(Icons.logout, color: Colors.red),
              label: Text(
                AppLocalizations.of(context)!.settingsLogout,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Center(
            child: Text(
              'InvitoHub v1.0.0',
              style: TextStyle(color: Colors.grey.shade500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF6C63FF).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: const Color(0xFF6C63FF)),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      secondary: _buildIcon(icon),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
      activeThumbColor: const Color(0xFF6C63FF),
    );
  }

  void _showLanguagePicker() {
    final currentLanguageCode = Localizations.localeOf(context).languageCode;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (bottomSheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.settingsSelectLanguage,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('English'),
                trailing: currentLanguageCode == 'en'
                    ? const Icon(Icons.check, color: Color(0xFF6C63FF))
                    : null,
                onTap: () {
                  context.read<LanguageCubit>().setLanguage('en');
                  Navigator.pop(bottomSheetContext);
                },
              ),
              ListTile(
                title: const Text('Hindi'),
                trailing: currentLanguageCode == 'hi'
                    ? const Icon(Icons.check, color: Color(0xFF6C63FF))
                    : null,
                onTap: () {
                  context.read<LanguageCubit>().setLanguage('hi');
                  Navigator.pop(bottomSheetContext);
                },
              ),
              ListTile(
                title: const Text('Gujarati'),
                trailing: currentLanguageCode == 'gu'
                    ? const Icon(Icons.check, color: Color(0xFF6C63FF))
                    : null,
                onTap: () {
                  context.read<LanguageCubit>().setLanguage('gu');
                  Navigator.pop(bottomSheetContext);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
