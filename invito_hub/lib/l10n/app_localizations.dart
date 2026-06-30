import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_gu.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('gu'),
    Locale('hi'),
  ];

  /// No description provided for @errorInvalidPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number'**
  String get errorInvalidPhoneNumber;

  /// No description provided for @loginWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to\nInvitoHub'**
  String get loginWelcomeTitle;

  /// No description provided for @loginWelcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Invite everyone, instantly.'**
  String get loginWelcomeSubtitle;

  /// No description provided for @loginPhoneNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get loginPhoneNumberLabel;

  /// No description provided for @loginPhoneNumberHint.
  ///
  /// In en, this message translates to:
  /// **'+1 (234) 567-8900'**
  String get loginPhoneNumberHint;

  /// No description provided for @loginSendOtpButton.
  ///
  /// In en, this message translates to:
  /// **'Send OTP'**
  String get loginSendOtpButton;

  /// No description provided for @loginOrContinueWith.
  ///
  /// In en, this message translates to:
  /// **'Or continue with'**
  String get loginOrContinueWith;

  /// No description provided for @loginContinueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get loginContinueWithGoogle;

  /// No description provided for @errorInvalidOtp.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid 6-digit OTP'**
  String get errorInvalidOtp;

  /// No description provided for @otpScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify OTP'**
  String get otpScreenTitle;

  /// No description provided for @otpInstructionText.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code sent to your phone.'**
  String get otpInstructionText;

  /// No description provided for @otpHintText.
  ///
  /// In en, this message translates to:
  /// **'------'**
  String get otpHintText;

  /// No description provided for @otpVerifyButton.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get otpVerifyButton;

  /// No description provided for @greetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning,'**
  String get greetingMorning;

  /// No description provided for @greetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon,'**
  String get greetingAfternoon;

  /// No description provided for @greetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening,'**
  String get greetingEvening;

  /// No description provided for @homeWelcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back!'**
  String get homeWelcomeBack;

  /// No description provided for @homeWhatToDoToday.
  ///
  /// In en, this message translates to:
  /// **'What would you like to do today?'**
  String get homeWhatToDoToday;

  /// No description provided for @homeActionCreateTitle.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get homeActionCreateTitle;

  /// No description provided for @homeActionCreateSubtitle.
  ///
  /// In en, this message translates to:
  /// **'New invite'**
  String get homeActionCreateSubtitle;

  /// No description provided for @homeActionHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get homeActionHistoryTitle;

  /// No description provided for @homeActionHistorySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sent invites'**
  String get homeActionHistorySubtitle;

  /// No description provided for @homeRecentActivity.
  ///
  /// In en, this message translates to:
  /// **'Recent Activity'**
  String get homeRecentActivity;

  /// No description provided for @homeNoRecentInvitations.
  ///
  /// In en, this message translates to:
  /// **'No recent invitations sent.'**
  String get homeNoRecentInvitations;

  /// No description provided for @homeFabNewInvite.
  ///
  /// In en, this message translates to:
  /// **'New Invite'**
  String get homeFabNewInvite;

  /// No description provided for @guestNameWithPhone.
  ///
  /// In en, this message translates to:
  /// **'Guest ({phone})'**
  String guestNameWithPhone(String phone);

  /// No description provided for @errorSelectDateTime.
  ///
  /// In en, this message translates to:
  /// **'Please select Date & Time'**
  String get errorSelectDateTime;

  /// No description provided for @errorSelectContacts.
  ///
  /// In en, this message translates to:
  /// **'Please select at least one contact'**
  String get errorSelectContacts;

  /// No description provided for @createScreenEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Invitation'**
  String get createScreenEditTitle;

  /// No description provided for @createScreenCreateTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Invitation'**
  String get createScreenCreateTitle;

  /// No description provided for @createScreenEventDetails.
  ///
  /// In en, this message translates to:
  /// **'Event Details'**
  String get createScreenEventDetails;

  /// No description provided for @createScreenInvitationType.
  ///
  /// In en, this message translates to:
  /// **'Invitation Type'**
  String get createScreenInvitationType;

  /// No description provided for @createScreenEventTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Event Title (e.g., John\'s Birthday)'**
  String get createScreenEventTitleLabel;

  /// No description provided for @errorRequiredField.
  ///
  /// In en, this message translates to:
  /// **'Required field'**
  String get errorRequiredField;

  /// No description provided for @createScreenHostedByLabel.
  ///
  /// In en, this message translates to:
  /// **'Hosted By'**
  String get createScreenHostedByLabel;

  /// No description provided for @createScreenDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get createScreenDateLabel;

  /// No description provided for @createScreenSelectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get createScreenSelectDate;

  /// No description provided for @createScreenTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get createScreenTimeLabel;

  /// No description provided for @createScreenSelectTime.
  ///
  /// In en, this message translates to:
  /// **'Select Time'**
  String get createScreenSelectTime;

  /// No description provided for @createScreenLocationLabel.
  ///
  /// In en, this message translates to:
  /// **'Location / Address'**
  String get createScreenLocationLabel;

  /// No description provided for @createScreenMessageTitle.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get createScreenMessageTitle;

  /// No description provided for @createScreenCustomMessageLabel.
  ///
  /// In en, this message translates to:
  /// **'Custom Message'**
  String get createScreenCustomMessageLabel;

  /// No description provided for @createScreenAttachmentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Attachments'**
  String get createScreenAttachmentsTitle;

  /// No description provided for @createScreenAttachDocuments.
  ///
  /// In en, this message translates to:
  /// **'Attach Documents'**
  String get createScreenAttachDocuments;

  /// No description provided for @createScreenGuestsTitle.
  ///
  /// In en, this message translates to:
  /// **'Guests'**
  String get createScreenGuestsTitle;

  /// No description provided for @createScreenSelectContacts.
  ///
  /// In en, this message translates to:
  /// **'Select Contacts'**
  String get createScreenSelectContacts;

  /// No description provided for @createScreenContactsSelected.
  ///
  /// In en, this message translates to:
  /// **'{count} Contacts Selected'**
  String createScreenContactsSelected(int count);

  /// No description provided for @createScreenPreviewChanges.
  ///
  /// In en, this message translates to:
  /// **'Preview Changes'**
  String get createScreenPreviewChanges;

  /// No description provided for @createScreenPreviewInvitation.
  ///
  /// In en, this message translates to:
  /// **'Preview Invitation'**
  String get createScreenPreviewInvitation;

  /// No description provided for @settingsScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsScreenTitle;

  /// No description provided for @settingsPreferencesTitle.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get settingsPreferencesTitle;

  /// No description provided for @settingsPushNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsPushNotifications;

  /// No description provided for @settingsPushNotificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Reminders and updates'**
  String get settingsPushNotificationsSubtitle;

  /// No description provided for @settingsDarkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get settingsDarkMode;

  /// No description provided for @settingsDarkModeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Toggle app theme'**
  String get settingsDarkModeSubtitle;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsSelectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get settingsSelectLanguage;

  /// No description provided for @settingsSupportTitle.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get settingsSupportTitle;

  /// No description provided for @settingsHelpCenter.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get settingsHelpCenter;

  /// No description provided for @settingsPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get settingsPrivacyPolicy;

  /// No description provided for @settingsLogout.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get settingsLogout;

  /// No description provided for @editProfileScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfileScreenTitle;

  /// No description provided for @editProfileFullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get editProfileFullNameLabel;

  /// No description provided for @errorEnterName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get errorEnterName;

  /// No description provided for @editProfileEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get editProfileEmailLabel;

  /// No description provided for @errorEnterEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get errorEnterEmail;

  /// No description provided for @errorInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get errorInvalidEmail;

  /// No description provided for @editProfilePhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get editProfilePhoneLabel;

  /// No description provided for @errorEnterPhone.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number'**
  String get errorEnterPhone;

  /// No description provided for @editProfileSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully!'**
  String get editProfileSuccessMessage;

  /// No description provided for @editProfileSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get editProfileSaveChanges;

  /// No description provided for @editProfileChangePicture.
  ///
  /// In en, this message translates to:
  /// **'Change Profile Picture'**
  String get editProfileChangePicture;

  /// No description provided for @editProfileChooseGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get editProfileChooseGallery;

  /// No description provided for @editProfileTakePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a Photo'**
  String get editProfileTakePhoto;

  /// No description provided for @editProfileRemovePhoto.
  ///
  /// In en, this message translates to:
  /// **'Remove Photo'**
  String get editProfileRemovePhoto;

  /// No description provided for @contactsPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Contacts'**
  String get contactsPickerTitle;

  /// No description provided for @contactsPickerDone.
  ///
  /// In en, this message translates to:
  /// **'Done ({count})'**
  String contactsPickerDone(int count);

  /// No description provided for @contactsPermissionError.
  ///
  /// In en, this message translates to:
  /// **'We need access to your contacts to let you invite friends.'**
  String get contactsPermissionError;

  /// No description provided for @contactsGenericError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String contactsGenericError(String error);

  /// No description provided for @contactsOpenSettings.
  ///
  /// In en, this message translates to:
  /// **'Open App Settings'**
  String get contactsOpenSettings;

  /// No description provided for @contactsRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get contactsRetry;

  /// No description provided for @contactsSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search contacts...'**
  String get contactsSearchHint;

  /// No description provided for @contactsNoPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'No phone number'**
  String get contactsNoPhoneNumber;

  /// No description provided for @historyScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Sent Invitations'**
  String get historyScreenTitle;

  /// No description provided for @historyGuestsInvited.
  ///
  /// In en, this message translates to:
  /// **'Guests: {count} invited'**
  String historyGuestsInvited(int count);

  /// No description provided for @previewScreenErrorWhatsApp.
  ///
  /// In en, this message translates to:
  /// **'Could not open WhatsApp'**
  String get previewScreenErrorWhatsApp;

  /// No description provided for @previewScreenErrorSMS.
  ///
  /// In en, this message translates to:
  /// **'Could not open SMS app'**
  String get previewScreenErrorSMS;

  /// No description provided for @previewScreenErrorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String previewScreenErrorGeneric(String error);

  /// No description provided for @previewScreenErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get previewScreenErrorTitle;

  /// No description provided for @previewScreenErrorMissingData.
  ///
  /// In en, this message translates to:
  /// **'Invitation data is missing'**
  String get previewScreenErrorMissingData;

  /// No description provided for @previewScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get previewScreenTitle;

  /// No description provided for @previewScreenWhatsAppLabel.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get previewScreenWhatsAppLabel;

  /// No description provided for @previewScreenSMSLabel.
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get previewScreenSMSLabel;

  /// No description provided for @editProfileErrorPickImage.
  ///
  /// In en, this message translates to:
  /// **'Failed to pick image: {error}'**
  String editProfileErrorPickImage(String error);

  /// No description provided for @historyScreenNoInvitations.
  ///
  /// In en, this message translates to:
  /// **'No invitations sent yet.'**
  String get historyScreenNoInvitations;

  /// No description provided for @historyScreenDate.
  ///
  /// In en, this message translates to:
  /// **'Date: {date}'**
  String historyScreenDate(String date);

  /// No description provided for @previewScreenReadyToSend.
  ///
  /// In en, this message translates to:
  /// **'Ready to send to {count} guest(s)?'**
  String previewScreenReadyToSend(int count);

  /// No description provided for @detailsScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get detailsScreenTitle;

  /// No description provided for @detailsScreenViewCard.
  ///
  /// In en, this message translates to:
  /// **'View Invitation Card'**
  String get detailsScreenViewCard;

  /// No description provided for @detailsScreenRsvpSummary.
  ///
  /// In en, this message translates to:
  /// **'RSVP Summary'**
  String get detailsScreenRsvpSummary;

  /// No description provided for @detailsScreenAttending.
  ///
  /// In en, this message translates to:
  /// **'Attending'**
  String get detailsScreenAttending;

  /// No description provided for @detailsScreenPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get detailsScreenPending;

  /// No description provided for @detailsScreenDeclined.
  ///
  /// In en, this message translates to:
  /// **'Declined'**
  String get detailsScreenDeclined;

  /// No description provided for @detailsScreenGuestList.
  ///
  /// In en, this message translates to:
  /// **'Guest List'**
  String get detailsScreenGuestList;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'gu', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'gu':
      return AppLocalizationsGu();
    case 'hi':
      return AppLocalizationsHi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
