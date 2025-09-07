// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get helloWorld => 'Bonjour les gars';

  @override
  String get next => 'Je continue';

  @override
  String get onboardingTitle =>
      'Simplifiez votre quotidien en organisant vos activités en toute simplicité.';

  @override
  String get setYourPreferredLanguage => 'Choisir votre langue préférée';

  @override
  String get whatIsYourName => 'Comment pouvons-nous vous appeler?';

  @override
  String get fullName => 'Nom(s) & Prénom(s)';

  @override
  String get anErrorOccurred =>
      'Impossible de continuer. Une erreur est survenue.';
}
