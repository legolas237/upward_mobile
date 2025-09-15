part of 'localization_viewmodel.dart';

@immutable
class LocalizationModel extends Equatable {
  const LocalizationModel({
    required this.language,
  });

  final String language;

  LocalizationModel change({
    required String language,
  }) {
    return LocalizationModel(
      language: language,
    );
  }

  @override
  List<Object?> get props => [language];
}
