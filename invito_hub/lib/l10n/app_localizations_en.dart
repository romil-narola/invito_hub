// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get errorInvalidPhoneNumber => 'Please enter a valid phone number';

  @override
  String get loginWelcomeTitle => 'Welcome to\nInvitoHub';

  @override
  String get loginWelcomeSubtitle => 'Invite everyone, instantly.';

  @override
  String get loginPhoneNumberLabel => 'Phone Number';

  @override
  String get loginPhoneNumberHint => '+1 (234) 567-8900';

  @override
  String get loginSendOtpButton => 'Send OTP';

  @override
  String get loginOrContinueWith => 'Or continue with';

  @override
  String get loginContinueWithGoogle => 'Continue with Google';

  @override
  String get errorInvalidOtp => 'Please enter a valid 6-digit OTP';

  @override
  String get otpScreenTitle => 'Verify OTP';

  @override
  String get otpInstructionText => 'Enter the 6-digit code sent to your phone.';

  @override
  String get otpHintText => '------';

  @override
  String get otpVerifyButton => 'Verify';

  @override
  String get greetingMorning => 'Good Morning,';

  @override
  String get greetingAfternoon => 'Good Afternoon,';

  @override
  String get greetingEvening => 'Good Evening,';

  @override
  String get homeWelcomeBack => 'Welcome back!';

  @override
  String get homeWhatToDoToday => 'What would you like to do today?';

  @override
  String get homeActionCreateTitle => 'Create';

  @override
  String get homeActionCreateSubtitle => 'New invite';

  @override
  String get homeActionHistoryTitle => 'History';

  @override
  String get homeActionHistorySubtitle => 'Sent invites';

  @override
  String get homeRecentActivity => 'Recent Activity';

  @override
  String get homeNoRecentInvitations => 'No recent invitations sent.';

  @override
  String get homeFabNewInvite => 'New Invite';

  @override
  String guestNameWithPhone(String phone) {
    return 'Guest ($phone)';
  }

  @override
  String get errorSelectDateTime => 'Please select Date & Time';

  @override
  String get errorSelectContacts => 'Please select at least one contact';

  @override
  String get createScreenEditTitle => 'Edit Invitation';

  @override
  String get createScreenCreateTitle => 'Create Invitation';

  @override
  String get createScreenEventDetails => 'Event Details';

  @override
  String get createScreenInvitationType => 'Invitation Type';

  @override
  String get createScreenEventTitleLabel =>
      'Event Title (e.g., John\'s Birthday)';

  @override
  String get errorRequiredField => 'Required field';

  @override
  String get createScreenHostedByLabel => 'Hosted By';

  @override
  String get createScreenDateLabel => 'Date';

  @override
  String get createScreenSelectDate => 'Select Date';

  @override
  String get createScreenTimeLabel => 'Time';

  @override
  String get createScreenSelectTime => 'Select Time';

  @override
  String get createScreenLocationLabel => 'Location / Address';

  @override
  String get createScreenMessageTitle => 'Message';

  @override
  String get createScreenCustomMessageLabel => 'Custom Message';

  @override
  String get createScreenAttachmentsTitle => 'Attachments';

  @override
  String get createScreenAttachDocuments => 'Attach Documents';

  @override
  String get createScreenGuestsTitle => 'Guests';

  @override
  String get createScreenSelectContacts => 'Select Contacts';

  @override
  String createScreenContactsSelected(int count) {
    return '$count Contacts Selected';
  }

  @override
  String get createScreenPreviewChanges => 'Preview Changes';

  @override
  String get createScreenPreviewInvitation => 'Preview Invitation';

  @override
  String get settingsScreenTitle => 'Settings';

  @override
  String get settingsPreferencesTitle => 'Preferences';

  @override
  String get settingsPushNotifications => 'Notifications';

  @override
  String get settingsPushNotificationsSubtitle => 'Reminders and updates';

  @override
  String get settingsDarkMode => 'Dark Mode';

  @override
  String get settingsDarkModeSubtitle => 'Toggle app theme';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsSelectLanguage => 'Select Language';

  @override
  String get settingsSupportTitle => 'Support';

  @override
  String get settingsHelpCenter => 'Help Center';

  @override
  String get settingsPrivacyPolicy => 'Privacy Policy';

  @override
  String get settingsLogout => 'Log Out';

  @override
  String get editProfileScreenTitle => 'Edit Profile';

  @override
  String get editProfileFullNameLabel => 'Full Name';

  @override
  String get errorEnterName => 'Please enter your name';

  @override
  String get editProfileEmailLabel => 'Email Address';

  @override
  String get errorEnterEmail => 'Please enter your email';

  @override
  String get errorInvalidEmail => 'Please enter a valid email';

  @override
  String get editProfilePhoneLabel => 'Phone Number';

  @override
  String get errorEnterPhone => 'Please enter your phone number';

  @override
  String get editProfileSuccessMessage => 'Profile updated successfully!';

  @override
  String get editProfileSaveChanges => 'Save Changes';

  @override
  String get editProfileChangePicture => 'Change Profile Picture';

  @override
  String get editProfileChooseGallery => 'Choose from Gallery';

  @override
  String get editProfileTakePhoto => 'Take a Photo';

  @override
  String get editProfileRemovePhoto => 'Remove Photo';

  @override
  String get contactsPickerTitle => 'Select Contacts';

  @override
  String contactsPickerDone(int count) {
    return 'Done ($count)';
  }

  @override
  String get contactsPermissionError =>
      'We need access to your contacts to let you invite friends.';

  @override
  String contactsGenericError(String error) {
    return 'Error: $error';
  }

  @override
  String get contactsOpenSettings => 'Open App Settings';

  @override
  String get contactsRetry => 'Retry';

  @override
  String get contactsSearchHint => 'Search contacts...';

  @override
  String get contactsNoPhoneNumber => 'No phone number';

  @override
  String get historyScreenTitle => 'Sent Invitations';

  @override
  String historyGuestsInvited(int count) {
    return 'Guests: $count invited';
  }

  @override
  String get previewScreenErrorWhatsApp => 'Could not open WhatsApp';

  @override
  String get previewScreenErrorSMS => 'Could not open SMS app';

  @override
  String previewScreenErrorGeneric(String error) {
    return 'Error: $error';
  }

  @override
  String get previewScreenErrorTitle => 'Error';

  @override
  String get previewScreenErrorMissingData => 'Invitation data is missing';

  @override
  String get previewScreenTitle => 'Preview';

  @override
  String get previewScreenWhatsAppLabel => 'WhatsApp';

  @override
  String get previewScreenSMSLabel => 'SMS';

  @override
  String editProfileErrorPickImage(String error) {
    return 'Failed to pick image: $error';
  }

  @override
  String get historyScreenNoInvitations => 'No invitations sent yet.';

  @override
  String historyScreenDate(String date) {
    return 'Date: $date';
  }

  @override
  String previewScreenReadyToSend(int count) {
    return 'Ready to send to $count guest(s)?';
  }

  @override
  String get detailsScreenTitle => 'Dashboard';

  @override
  String get detailsScreenViewCard => 'View Invitation Card';

  @override
  String get detailsScreenRsvpSummary => 'RSVP Summary';

  @override
  String get detailsScreenAttending => 'Attending';

  @override
  String get detailsScreenPending => 'Pending';

  @override
  String get detailsScreenDeclined => 'Declined';

  @override
  String get detailsScreenGuestList => 'Guest List';
}
