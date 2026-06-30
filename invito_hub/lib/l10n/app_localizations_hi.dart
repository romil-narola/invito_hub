// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get errorInvalidPhoneNumber => 'कृपया एक वैध फ़ोन नंबर दर्ज करें';

  @override
  String get loginWelcomeTitle => 'InvitoHub में\nआपका स्वागत है';

  @override
  String get loginWelcomeSubtitle => 'सबको आमंत्रित करें, तुरंत।';

  @override
  String get loginPhoneNumberLabel => 'फ़ोन नंबर';

  @override
  String get loginPhoneNumberHint => '+91 98765 43210';

  @override
  String get loginSendOtpButton => 'OTP भेजें';

  @override
  String get loginOrContinueWith => 'या इसके साथ जारी रखें';

  @override
  String get loginContinueWithGoogle => 'Google के साथ जारी रखें';

  @override
  String get errorInvalidOtp => 'कृपया एक वैध 6-अंकीय OTP दर्ज करें';

  @override
  String get otpScreenTitle => 'OTP सत्यापित करें';

  @override
  String get otpInstructionText =>
      'आपके फ़ोन पर भेजा गया 6-अंकीय कोड दर्ज करें।';

  @override
  String get otpHintText => '------';

  @override
  String get otpVerifyButton => 'सत्यापित करें';

  @override
  String get greetingMorning => 'सुप्रभात,';

  @override
  String get greetingAfternoon => 'शुभ दोपहर,';

  @override
  String get greetingEvening => 'शुभ संध्या,';

  @override
  String get homeWelcomeBack => 'वापसी पर स्वागत है!';

  @override
  String get homeWhatToDoToday => 'आज आप क्या करना चाहेंगे?';

  @override
  String get homeActionCreateTitle => 'बनाएं';

  @override
  String get homeActionCreateSubtitle => 'नया आमंत्रण';

  @override
  String get homeActionHistoryTitle => 'इतिहास';

  @override
  String get homeActionHistorySubtitle => 'भेजे गए आमंत्रण';

  @override
  String get homeRecentActivity => 'हाल की गतिविधि';

  @override
  String get homeNoRecentInvitations => 'हाल ही में कोई आमंत्रण नहीं भेजा गया।';

  @override
  String get homeFabNewInvite => 'नया आमंत्रण';

  @override
  String guestNameWithPhone(String phone) {
    return 'अतिथि ($phone)';
  }

  @override
  String get errorSelectDateTime => 'कृपया तिथि और समय चुनें';

  @override
  String get errorSelectContacts => 'कृपया कम से कम एक संपर्क चुनें';

  @override
  String get createScreenEditTitle => 'आमंत्रण संपादित करें';

  @override
  String get createScreenCreateTitle => 'आमंत्रण बनाएं';

  @override
  String get createScreenEventDetails => 'कार्यक्रम विवरण';

  @override
  String get createScreenInvitationType => 'आमंत्रण का प्रकार';

  @override
  String get createScreenEventTitleLabel =>
      'कार्यक्रम का शीर्षक (उदा., जॉन का जन्मदिन)';

  @override
  String get errorRequiredField => 'आवश्यक फ़ील्ड';

  @override
  String get createScreenHostedByLabel => 'द्वारा आयोजित';

  @override
  String get createScreenDateLabel => 'दिनांक';

  @override
  String get createScreenSelectDate => 'दिनांक चुनें';

  @override
  String get createScreenTimeLabel => 'समय';

  @override
  String get createScreenSelectTime => 'समय चुनें';

  @override
  String get createScreenLocationLabel => 'स्थान / पता';

  @override
  String get createScreenMessageTitle => 'संदेश';

  @override
  String get createScreenCustomMessageLabel => 'कस्टम संदेश';

  @override
  String get createScreenAttachmentsTitle => 'संलग्नक';

  @override
  String get createScreenAttachDocuments => 'दस्तावेज़ संलग्न करें';

  @override
  String get createScreenGuestsTitle => 'अतिथि';

  @override
  String get createScreenSelectContacts => 'संपर्क चुनें';

  @override
  String createScreenContactsSelected(int count) {
    return '$count संपर्क चुने गए';
  }

  @override
  String get createScreenPreviewChanges => 'परिवर्तनों का पूर्वावलोकन करें';

  @override
  String get createScreenPreviewInvitation => 'आमंत्रण का पूर्वावलोकन करें';

  @override
  String get settingsScreenTitle => 'सेटिंग्स';

  @override
  String get settingsPreferencesTitle => 'प्राथमिकताएं';

  @override
  String get settingsPushNotifications => 'सूचनाएं';

  @override
  String get settingsPushNotificationsSubtitle => 'रिमाइंडर और अपडेट';

  @override
  String get settingsDarkMode => 'डार्क मोड';

  @override
  String get settingsDarkModeSubtitle => 'ऐप थीम टॉगल करें';

  @override
  String get settingsLanguage => 'भाषा';

  @override
  String get settingsSelectLanguage => 'भाषा चुनें';

  @override
  String get settingsSupportTitle => 'समर्थन';

  @override
  String get settingsHelpCenter => 'सहायता केंद्र';

  @override
  String get settingsPrivacyPolicy => 'गोपनीयता नीति';

  @override
  String get settingsLogout => 'लॉग आउट करें';

  @override
  String get editProfileScreenTitle => 'प्रोफ़ाइल संपादित करें';

  @override
  String get editProfileFullNameLabel => 'पूरा नाम';

  @override
  String get errorEnterName => 'कृपया अपना नाम दर्ज करें';

  @override
  String get editProfileEmailLabel => 'ईमेल पता';

  @override
  String get errorEnterEmail => 'कृपया अपना ईमेल दर्ज करें';

  @override
  String get errorInvalidEmail => 'कृपया एक वैध ईमेल दर्ज करें';

  @override
  String get editProfilePhoneLabel => 'फ़ोन नंबर';

  @override
  String get errorEnterPhone => 'कृपया अपना फ़ोन नंबर दर्ज करें';

  @override
  String get editProfileSuccessMessage => 'प्रोफ़ाइल सफलतापूर्वक अपडेट की गई!';

  @override
  String get editProfileSaveChanges => 'परिवर्तन सहेजें';

  @override
  String get editProfileChangePicture => 'प्रोफ़ाइल चित्र बदलें';

  @override
  String get editProfileChooseGallery => 'गैलरी से चुनें';

  @override
  String get editProfileTakePhoto => 'फोटो लें';

  @override
  String get editProfileRemovePhoto => 'तस्वीर हटाएं';

  @override
  String get contactsPickerTitle => 'संपर्क चुनें';

  @override
  String contactsPickerDone(int count) {
    return 'हो गया ($count)';
  }

  @override
  String get contactsPermissionError =>
      'दोस्तों को आमंत्रित करने के लिए हमें आपके संपर्कों तक पहुंच की आवश्यकता है।';

  @override
  String contactsGenericError(String error) {
    return 'त्रुटि: $error';
  }

  @override
  String get contactsOpenSettings => 'ऐप सेटिंग्स खोलें';

  @override
  String get contactsRetry => 'पुनः प्रयास करें';

  @override
  String get contactsSearchHint => 'संपर्क खोजें...';

  @override
  String get contactsNoPhoneNumber => 'कोई फ़ोन नंबर नहीं';

  @override
  String get historyScreenTitle => 'भेजे गए निमंत्रण';

  @override
  String historyGuestsInvited(int count) {
    return 'अतिथि: $count आमंत्रित';
  }

  @override
  String get previewScreenErrorWhatsApp => 'WhatsApp नहीं खुल सका';

  @override
  String get previewScreenErrorSMS => 'SMS ऐप नहीं खुल सका';

  @override
  String previewScreenErrorGeneric(String error) {
    return 'त्रुटि: $error';
  }

  @override
  String get previewScreenErrorTitle => 'त्रुटि';

  @override
  String get previewScreenErrorMissingData => 'निमंत्रण डेटा मौजूद नहीं है';

  @override
  String get previewScreenTitle => 'पूर्वावलोकन';

  @override
  String get previewScreenWhatsAppLabel => 'WhatsApp';

  @override
  String get previewScreenSMSLabel => 'SMS';

  @override
  String editProfileErrorPickImage(String error) {
    return 'छवि चुनने में विफल: $error';
  }

  @override
  String get historyScreenNoInvitations => 'अभी तक कोई निमंत्रण नहीं भेजा गया।';

  @override
  String historyScreenDate(String date) {
    return 'दिनांक: $date';
  }

  @override
  String previewScreenReadyToSend(int count) {
    return 'क्या आप $count अतिथि(यों) को भेजने के लिए तैयार हैं?';
  }

  @override
  String get detailsScreenTitle => 'डैशबोर्ड';

  @override
  String get detailsScreenViewCard => 'आमंत्रण कार्ड देखें';

  @override
  String get detailsScreenRsvpSummary => 'RSVP सारांश';

  @override
  String get detailsScreenAttending => 'उपस्थित';

  @override
  String get detailsScreenPending => 'लंबित';

  @override
  String get detailsScreenDeclined => 'अस्वीकृत';

  @override
  String get detailsScreenGuestList => 'अतिथि सूची';
}
