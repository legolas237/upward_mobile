import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:upward_mobile/models/user.dart';
import 'package:upward_mobile/repositories/user_repository.dart';

part 'onboarding_model.dart';

/// Handle onboarding screen state
class OnboardingViewmodel extends Cubit<OnboardingModel> {
  OnboardingViewmodel({
    required UserRepository repository,
  }) : _repository = repository, super(OnboardingModel());

  final UserRepository _repository;

  Future<void> enrollUser(String name) async {
    emit(state.copyWith(
      status: OnboardingStatus.processing,
    ));

    // Just 6 seconds
    await Future.delayed(const Duration(seconds: 2));

    try {
      // Create user
      final user = User(name: name);

      // Store user
      await _repository.auth(user);

      emit(state.copyWith(
        status: OnboardingStatus.success,
      ));
      return;
    } catch (exception, stackTrace) {
      debugPrint(exception.toString());
      debugPrint(stackTrace.toString());
    }

    emit(state.copyWith(
      status: OnboardingStatus.failed,
    ));
  }
}
