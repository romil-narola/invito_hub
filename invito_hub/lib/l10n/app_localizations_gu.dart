// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Gujarati (`gu`).
class AppLocalizationsGu extends AppLocalizations {
  AppLocalizationsGu([String locale = 'gu']) : super(locale);

  @override
  String get errorInvalidPhoneNumber => 'કૃપા કરીને માન્ય ફોન નંબર દાખલ કરો';

  @override
  String get loginWelcomeTitle => 'InvitoHub માં\nતમારું સ્વાગત છે';

  @override
  String get loginWelcomeSubtitle => 'બધાને આમંત્રિત કરો, તરત જ.';

  @override
  String get loginPhoneNumberLabel => 'ફોન નંબર';

  @override
  String get loginPhoneNumberHint => '+91 98765 43210';

  @override
  String get loginSendOtpButton => 'OTP મોકલો';

  @override
  String get loginOrContinueWith => 'અથવા આની સાથે ચાલુ રાખો';

  @override
  String get loginContinueWithGoogle => 'Google સાથે ચાલુ રાખો';

  @override
  String get errorInvalidOtp => 'કૃપા કરીને માન્ય 6-અંકનો OTP દાખલ કરો';

  @override
  String get otpScreenTitle => 'OTP ચકાસો';

  @override
  String get otpInstructionText => 'તમારા ફોન પર મોકલેલો 6-અંકનો કોડ દાખલ કરો.';

  @override
  String get otpHintText => '------';

  @override
  String get otpVerifyButton => 'ચકાસો';

  @override
  String get greetingMorning => 'શુભ સવાર,';

  @override
  String get greetingAfternoon => 'શુભ બપોર,';

  @override
  String get greetingEvening => 'શુભ સાંજ,';

  @override
  String get homeWelcomeBack => 'પાછા ફરવા બદલ સ્વાગત છે!';

  @override
  String get homeWhatToDoToday => 'આજે તમે શું કરવા માંગો છો?';

  @override
  String get homeActionCreateTitle => 'બનાવો';

  @override
  String get homeActionCreateSubtitle => 'નવું આમંત્રણ';

  @override
  String get homeActionHistoryTitle => 'ઇતિહાસ';

  @override
  String get homeActionHistorySubtitle => 'મોકલેલા આમંત્રણો';

  @override
  String get homeRecentActivity => 'તાજેતરની પ્રવૃત્તિ';

  @override
  String get homeNoRecentInvitations =>
      'તાજેતરમાં કોઈ આમંત્રણ મોકલવામાં આવ્યું નથી.';

  @override
  String get homeFabNewInvite => 'નવું આમંત્રણ';

  @override
  String guestNameWithPhone(String phone) {
    return 'અતિથિ ($phone)';
  }

  @override
  String get errorSelectDateTime => 'કૃપા કરીને તારીખ અને સમય પસંદ કરો';

  @override
  String get errorSelectContacts => 'કૃપા કરીને ઓછામાં ઓછો એક સંપર્ક પસંદ કરો';

  @override
  String get createScreenEditTitle => 'આમંત્રણ સંપાદિત કરો';

  @override
  String get createScreenCreateTitle => 'આમંત્રણ બનાવો';

  @override
  String get createScreenEventDetails => 'ઇવેન્ટની વિગતો';

  @override
  String get createScreenInvitationType => 'આમંત્રણનો પ્રકાર';

  @override
  String get createScreenEventTitleLabel =>
      'ઇવેન્ટનું શીર્ષક (દા.ત., જ્હોનનો જન્મદિવસ)';

  @override
  String get errorRequiredField => 'જરૂરી ફીલ્ડ';

  @override
  String get createScreenHostedByLabel => 'દ્વારા આયોજિત';

  @override
  String get createScreenDateLabel => 'તારીખ';

  @override
  String get createScreenSelectDate => 'તારીખ પસંદ કરો';

  @override
  String get createScreenTimeLabel => 'સમય';

  @override
  String get createScreenSelectTime => 'સમય પસંદ કરો';

  @override
  String get createScreenLocationLabel => 'સ્થાન / સરનામું';

  @override
  String get createScreenMessageTitle => 'સંદેશ';

  @override
  String get createScreenCustomMessageLabel => 'કસ્ટમ સંદેશ';

  @override
  String get createScreenAttachmentsTitle => 'જોડાણો';

  @override
  String get createScreenAttachDocuments => 'દસ્તાવેજો જોડો';

  @override
  String get createScreenGuestsTitle => 'અતિથિઓ';

  @override
  String get createScreenSelectContacts => 'સંપર્કો પસંદ કરો';

  @override
  String createScreenContactsSelected(int count) {
    return '$count સંપર્કો પસંદ કરેલા';
  }

  @override
  String get createScreenPreviewChanges => 'ફેરફારોનું પૂર્વાવલોકન કરો';

  @override
  String get createScreenPreviewInvitation => 'આમંત્રણનું પૂર્વાવલોકન કરો';

  @override
  String get settingsScreenTitle => 'સેટિંગ્સ';

  @override
  String get settingsPreferencesTitle => 'પસંદગીઓ';

  @override
  String get settingsPushNotifications => 'સૂચનાઓ';

  @override
  String get settingsPushNotificationsSubtitle => 'રિમાઇન્ડર્સ અને અપડેટ્સ';

  @override
  String get settingsDarkMode => 'ડાર્ક મોડ';

  @override
  String get settingsDarkModeSubtitle => 'એપ થીમ ટૉગલ કરો';

  @override
  String get settingsLanguage => 'ભાષા';

  @override
  String get settingsSelectLanguage => 'ભાષા પસંદ કરો';

  @override
  String get settingsSupportTitle => 'આધાર';

  @override
  String get settingsHelpCenter => 'સહાય કેન્દ્ર';

  @override
  String get settingsPrivacyPolicy => 'ગોપનીયતા નીતિ';

  @override
  String get settingsLogout => 'લૉગ આઉટ કરો';

  @override
  String get editProfileScreenTitle => 'પ્રોફાઇલ સંપાદિત કરો';

  @override
  String get editProfileFullNameLabel => 'પૂરું નામ';

  @override
  String get errorEnterName => 'કૃપા કરીને તમારું નામ દાખલ કરો';

  @override
  String get editProfileEmailLabel => 'ઇમેઇલ સરનામું';

  @override
  String get errorEnterEmail => 'કૃપા કરીને તમારું ઇમેઇલ દાખલ કરો';

  @override
  String get errorInvalidEmail => 'કૃપા કરીને માન્ય ઇમેઇલ દાખલ કરો';

  @override
  String get editProfilePhoneLabel => 'ફોન નંબર';

  @override
  String get errorEnterPhone => 'કૃપા કરીને તમારો ફોન નંબર દાખલ કરો';

  @override
  String get editProfileSuccessMessage => 'પ્રોફાઇલ સફળતાપૂર્વક અપડેટ થઈ!';

  @override
  String get editProfileSaveChanges => 'ફેરફારો સાચવો';

  @override
  String get editProfileChangePicture => 'પ્રોફાઇલ ચિત્ર બદલો';

  @override
  String get editProfileChooseGallery => 'ગેલેરીમાંથી પસંદ કરો';

  @override
  String get editProfileTakePhoto => 'ફોટો લો';

  @override
  String get editProfileRemovePhoto => 'ફોટો દૂર કરો';

  @override
  String get contactsPickerTitle => 'સંપર્કો પસંદ કરો';

  @override
  String contactsPickerDone(int count) {
    return 'થઈ ગયું ($count)';
  }

  @override
  String get contactsPermissionError =>
      'મિત્રોને આમંત્રિત કરવા માટે અમને તમારા સંપર્કોની ઍક્સેસની જરૂર છે.';

  @override
  String contactsGenericError(String error) {
    return 'ભૂલ: $error';
  }

  @override
  String get contactsOpenSettings => 'એપ સેટિંગ્સ ખોલો';

  @override
  String get contactsRetry => 'ફરી પ્રયાસ કરો';

  @override
  String get contactsSearchHint => 'સંપર્કો શોધો...';

  @override
  String get contactsNoPhoneNumber => 'કોઈ ફોન નંબર નથી';

  @override
  String get historyScreenTitle => 'મોકલેલા આમંત્રણો';

  @override
  String historyGuestsInvited(int count) {
    return 'અતિથિઓ: $count આમંત્રિત';
  }

  @override
  String get previewScreenErrorWhatsApp => 'WhatsApp ખોલી શકાયું નથી';

  @override
  String get previewScreenErrorSMS => 'SMS એપ ખોલી શકાઈ નથી';

  @override
  String previewScreenErrorGeneric(String error) {
    return 'ભૂલ: $error';
  }

  @override
  String get previewScreenErrorTitle => 'ભૂલ';

  @override
  String get previewScreenErrorMissingData => 'આમંત્રણ ડેટા ખૂટે છે';

  @override
  String get previewScreenTitle => 'પૂર્વાવલોકન';

  @override
  String get previewScreenWhatsAppLabel => 'WhatsApp';

  @override
  String get previewScreenSMSLabel => 'SMS';

  @override
  String editProfileErrorPickImage(String error) {
    return 'છબી પસંદ કરવામાં નિષ્ફળ: $error';
  }

  @override
  String get historyScreenNoInvitations =>
      'હજી સુધી કોઈ આમંત્રણ મોકલવામાં આવ્યું નથી.';

  @override
  String historyScreenDate(String date) {
    return 'તારીખ: $date';
  }

  @override
  String previewScreenReadyToSend(int count) {
    return 'શું તમે $count અતિથિ(ઓ)ને મોકલવા માટે તૈયાર છો?';
  }

  @override
  String get detailsScreenTitle => 'ડેશબોર્ડ';

  @override
  String get detailsScreenViewCard => 'આમંત્રણ કાર્ડ જુઓ';

  @override
  String get detailsScreenRsvpSummary => 'RSVP સારાંશ';

  @override
  String get detailsScreenAttending => 'ઉપસ્થિત';

  @override
  String get detailsScreenPending => 'બાકી';

  @override
  String get detailsScreenDeclined => 'નકારવામાં';

  @override
  String get detailsScreenGuestList => 'અતિથિ સૂચિ';
}
