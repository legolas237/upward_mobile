import 'package:flutter/material.dart';

import 'package:upward_mobile/models/task.dart';
import 'package:upward_mobile/services/task_service.dart';

@immutable
class TaskRepository {
  final TaskService _provider = TaskService();

  Future<List<Task>> tasks() async {
    return await _provider.tasks();
  }

  Future<void> addTask(Task task) async {
    return await _provider.addTask(task);
  }

  Future<void> deleteTasks(List<Task> allTasks) async {
    return await _provider.deleteTasks(allTasks);
  }
}
