import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_model.dart';

class ThemeViewmodel extends Cubit<ThemeModel> {
  ThemeViewmodel([this.status]) : super(ThemeModel(status: status));

  final ThemeStatusEnum? status;

  Future<void> themeChanged(ThemeStatusEnum status) async {
    emit(state.change(status: status));
  }
}
