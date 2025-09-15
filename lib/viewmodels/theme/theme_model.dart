part of 'theme_viewmodel.dart';

enum ThemeStatusEnum { light, dark }

class ThemeModel extends Equatable {
  const ThemeModel({
    this.status = ThemeStatusEnum.dark,
  });

  final ThemeStatusEnum? status;

  ThemeModel change({
    required ThemeStatusEnum status,
  }) {
    return ThemeModel(
      status: status,
    );
  }

  @override
  List<Object?> get props => [status];
}
