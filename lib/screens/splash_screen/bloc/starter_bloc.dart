import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:upward_mobile/blocs/auth/auth_bloc.dart';
import 'package:upward_mobile/repositories/user_repository.dart';

part 'starter_event.dart';
part 'starter_state.dart';

class StarterBloc extends Bloc<StarterEvent, StarterState> {
  StarterBloc({
    required UserRepository repository,
  }) : _repository = repository, super(const StarterState()) {

    // Init events emission ...
    on<InitAuth>(_onInitAuth);
  }

  final UserRepository _repository;

  Future<void> _onInitAuth(InitAuth event, Emitter<StarterState> emit,) async {
    // Just 6 seconds
    await Future.delayed(const Duration(seconds: 5));

    try {
      final user = await _repository.provider.user();
      _repository.statusChange(
        status: user != null ? AuthStatus.authenticated : AuthStatus.unknown,
        user: user,
      );

      emit(state.copyWith(
        status: StarterStatus.success,
      ));
      return;
    } catch (exception, stackTrace) {
      debugPrint(exception.toString());
      debugPrint(stackTrace.toString());
    }

    emit(state.copyWith(
      status: StarterStatus.failed,
    ));
  }
}
