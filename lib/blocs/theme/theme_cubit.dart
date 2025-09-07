import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit([this.status]) : super(ThemeState(status: status));

  final ThemeStatusEnum? status;

  Future<void> themeChanged(ThemeStatusEnum status) async {
    emit(state.change(status: status));
  }
}
