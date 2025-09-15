// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_check.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

TaskCheck _$FromJson(Map<String, dynamic> json) {
  return TaskCheck(
    json['id'],
    completed: json['completed'] != null && int.parse(json['completed'].toString()) == 1,
    content: json['content'],
  );
}

Map<String, dynamic> _$ToJson(TaskCheck instance) => <String, dynamic> {
  "completed": instance.completed ? 1 : 0,
  "content": instance.content,
};

