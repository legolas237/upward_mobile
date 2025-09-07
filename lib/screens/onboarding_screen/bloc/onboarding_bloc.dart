import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:upward_mobile/models/user.dart';
import 'package:upward_mobile/repositories/user_repository.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(const OnboardingState()) {

    // Init events emission ...
    on<EnrollUser>(_onEnrollUser);
  }

  final UserRepository _repository = UserRepository();

  Future<void> _onEnrollUser(EnrollUser event, Emitter<OnboardingState> emit,) async {
    emit(state.copyWith(
      status: OnboardingStatus.processing,
    ));

    // Just 6 seconds
    await Future.delayed(const Duration(seconds: 2));

    try {
      // Create user
      final user = User(name: event.name);

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
