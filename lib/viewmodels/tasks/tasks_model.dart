part of 'tasks_viewmodel.dart';

enum TasksModelStatus { initial, processing, loaded, intermediate, error }

@immutable
class TasksModel extends Equatable {
  const TasksModel({
    this.tasks = const <Task>[],
    this.status = TasksModelStatus.initial,
  });

  final TasksModelStatus status;
  final List<Task> tasks;

  TasksModel copyWith({
    List<Task>? tasks,
    TasksModelStatus? status,
  }) {
    return TasksModel(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
    );
  }

  @override
  List<Object?> get props => [tasks, status];
}
