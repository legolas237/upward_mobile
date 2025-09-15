import 'package:flutter/material.dart';
import 'package:upward_mobile/models/task_element.dart';

part 'task_text.g.dart';

@immutable
class TaskText extends TaskElement {
  const TaskText(String id, {
    required this.content,
  }) : super(key: typeKey, id: id);

  final String content;

  static const String typeKey = 'TaskText';

  factory TaskText.fromJson(Map<String, dynamic> json) {
    return _$FromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      ..._$ToJson(this),
    };
  }

  TaskText copyWith({
    String? content,
  }) {
    return TaskText(
      id,
      content: content ?? this.content,
    );
  }

  @override
  List<Object?> get props {
    return [...super.props, content];
  }
}
