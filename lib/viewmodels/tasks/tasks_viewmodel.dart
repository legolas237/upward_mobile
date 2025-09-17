import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:upward_mobile/models/task.dart';
import 'package:upward_mobile/repositories/task_repository.dart';

part 'tasks_model.dart';

/// Handle tasks view model with state
class TasksViewModel extends Cubit<TasksModel> {
  TasksViewModel({
    required TaskRepository repository,
  }) : _repository = repository, super(TasksModel());

  final TaskRepository _repository;

  Future<void> tasks([bool refresh = false]) async {
    if(!refresh) {
      emit(state.copyWith(
        status: TasksModelStatus.processing,
      ));
    }

    try {
      final tasks = await _repository.tasks();

      // Emit new state ...
      emit(state.copyWith(
        status: state.status == TasksModelStatus.loaded ? TasksModelStatus.intermediate : TasksModelStatus.loaded,
        tasks: tasks,
      ));
      return;
    } catch (error, trace) {
      debugPrint(error.toString());
      debugPrint(trace.toString());
    }

    // Emit new state ...
    emit(state.copyWith(
      status: TasksModelStatus.error,
    ));
  }

  Future<void> addTask(Task task) async {
    emit(state.copyWith(
      status: TasksModelStatus.processing,
    ));

    await _repository.addTask(task);

    // Finally get all task
    tasks(true);
  }

  Future<void> deleteTasks(List<Task> allTasks) async {
    await _repository.deleteTasks(allTasks);

    // Finally get all task
    tasks(true);
  }
}
