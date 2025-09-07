// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get helloWorld => 'Hello Guys';

  @override
  String get next => 'I continue';

  @override
  String get onboardingTitle =>
      'Simplify your daily life by organizing your activities with ease.';

  @override
  String get setYourPreferredLanguage => 'Select your preferred language';

  @override
  String get whatIsYourName => 'What can we call you?';

  @override
  String get fullName => 'Last & First Name(s)';

  @override
  String get anErrorOccurred => 'Unable to continue. An error has occurred.';
}
