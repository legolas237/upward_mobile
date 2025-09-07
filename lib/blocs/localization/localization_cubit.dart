import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:upward_mobile/utilities/config.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(
    LocalizationState(
      language: Hive.box(Constants.upwardTable).get(
        Constants.localeColumn,
      ) as String? ?? Constants.defaultLocale,
    ),
  );

  Future<void> languageHasChanged(String language) async {
    await Hive.box(Constants.upwardTable).put(
      Constants.localeColumn,
      language,
    );

    // Notify
    emit(state.change(
      language: language,
    ));
  }
}
