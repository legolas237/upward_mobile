import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:upward_mobile/repositories/storage_repository.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(
    LocalizationState(
      language: StorageRepository.getLocale(),
    ),
  );

  Future<void> languageHasChanged(String language) async {
    await StorageRepository.setLanguage(language);
    // Notify
    emit(state.change(
      language: language,
    ));
  }
}
