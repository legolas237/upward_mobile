part of 'theme_cubit.dart';

enum ThemeStatusEnum { light, dark }

class ThemeState extends Equatable {
  const ThemeState({
    this.status = ThemeStatusEnum.dark,
  });

  final ThemeStatusEnum? status;

  ThemeState change({
    required ThemeStatusEnum status,
  }) {
    return ThemeState(
      status: status,
    );
  }

  @override
  List<Object?> get props => [status];
}
