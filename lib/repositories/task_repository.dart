import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:upward_mobile/models/task.dart';
import 'package:upward_mobile/utilities/config.dart';

@immutable
class TaskRepository {
  /// All tasks
  ///
  /// return: List of Task
  Future<List<Task>> tasks() async {
    final box = Hive.box(Constants.upwardTable);
    final List tasks = box.get(Constants.tasksColumn) ?? [];

    return tasks.map((json) {
      return Task.fromJson(Map<String, dynamic>.from(json));
    }).toList();
  }

  /// Add task
  ///
  /// Task: task
  /// return: void
  Future<void> addTask(Task task) async {
    final box = Hive.box(Constants.upwardTable);
    final List<Task> allTasks = await tasks();

    // Add task
    task.date = DateTime.now();
    // Find if exist
    final index = allTasks.indexWhere((element) {
      return element.id == task.id;
    });

    if(index >= 0) {
      allTasks[index] = task;
    } else {
      allTasks.insert(0, task);
    }

    // Set table column
    box.put(Constants.tasksColumn, allTasks.map((element) {
      return element.toJson();
    }).toList());
  }

  /// Delete tasks
  ///
  /// List: deletedTasks
  /// return: void
  Future<void> deleteTasks(List<Task> deletedTasks) async {
    final box = Hive.box(Constants.upwardTable);
    final List<Task> allTasks = await tasks();

    final List<String> taskIds = deletedTasks.map((task) {
      return task.id;
    }).toList();
    final filters = allTasks.where((element) {
      return !taskIds.contains(element.id);
    }).toList();

    // Set table column
    box.put(Constants.tasksColumn, filters.map((element) {
      return element.toJson();
    }).toList());
  }
}
