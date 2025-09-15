import 'package:flutter/material.dart';
import 'package:upward_mobile/models/task_element.dart';

part 'task_check.g.dart';

@immutable
class TaskCheck extends TaskElement {
  const TaskCheck(String id, {
    this.completed = false,
    required this.content,
  }) : super(key: typeKey, id: id);

  final bool completed;
  final String content;

  static const String typeKey = 'TaskCheck';

  factory TaskCheck.fromJson(Map<String, dynamic> json) {
    return _$FromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      ..._$ToJson(this),
    };
  }

  TaskCheck copyWith({
    bool? completed,
    String? content,
  }) {
    return TaskCheck(
      id,
      completed: completed ?? this.completed,
      content: content ?? this.content,
    );
  }

  @override
  List<Object?> get props {
    return [...super.props, completed, content];
  }
}
