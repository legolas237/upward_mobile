import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

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
    Locale('fr'),
  ];

  /// The conventional newborn programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Hello Guys'**
  String get helloWorld;

  ///
  ///
  /// In en, this message translates to:
  /// **'Hello !'**
  String get hello;

  ///
  ///
  /// In en, this message translates to:
  /// **'I continue'**
  String get next;

  ///
  ///
  /// In en, this message translates to:
  /// **'Select your preferred language'**
  String get setYourPreferredLanguage;

  ///
  ///
  /// In en, this message translates to:
  /// **'To continue, please enter your name.'**
  String get whatIsYourName;

  ///
  ///
  /// In en, this message translates to:
  /// **'First & Last name(s)'**
  String get fullName;

  ///
  ///
  /// In en, this message translates to:
  /// **'Unable to continue. An error has occurred.'**
  String get anErrorOccurred;

  ///
  ///
  /// In en, this message translates to:
  /// **'Free yourself from chaos. Organize your tasks, live with peace of mind.'**
  String get onboardingTitle;

  /// No description provided for @startToWrite.
  ///
  /// In en, this message translates to:
  /// **'Start writing'**
  String get startToWrite;

  ///
  ///
  /// In en, this message translates to:
  /// **'This information helps us provide you with an even better experience.'**
  String get whyEnterName;

  ///
  ///
  /// In en, this message translates to:
  /// **'Add a new task'**
  String get addTask;

  ///
  ///
  /// In en, this message translates to:
  /// **'Oops Error!'**
  String get error;

  ///
  ///
  /// In en, this message translates to:
  /// **'It\'s empty around here'**
  String get isEmptyAroundHere;

  ///
  ///
  /// In en, this message translates to:
  /// **'To start organizing, add tasks to your board'**
  String get emptyTasks;

  ///
  ///
  /// In en, this message translates to:
  /// **'Unclassified'**
  String get unclassified;

  ///
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get completed;

  ///
  ///
  /// In en, this message translates to:
  /// **'Not complete'**
  String get uncompleted;

  ///
  ///
  /// In en, this message translates to:
  /// **'Partially complete'**
  String get partiallyCompleted;

  ///
  ///
  /// In en, this message translates to:
  /// **'Enter title'**
  String get title;

  ///
  ///
  /// In en, this message translates to:
  /// **'Task description'**
  String get taskContent;

  ///
  ///
  /// In en, this message translates to:
  /// **'Continue writing'**
  String get continueWriting;

  ///
  ///
  /// In en, this message translates to:
  /// **'Enter item'**
  String get enterCheckListDescription;

  ///
  ///
  /// In en, this message translates to:
  /// **'Saving ...'**
  String get saving;

  ///
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  ///
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allTasks;

  ///
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get takeOnePicture;

  ///
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get chooseIntoGallery;

  ///
  ///
  /// In en, this message translates to:
  /// **'Change the activity status'**
  String get changeStatus;

  ///
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  ///
  ///
  /// In en, this message translates to:
  /// **'Authorization required to\naccess the microphone'**
  String get permanentlyDenied;
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
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
