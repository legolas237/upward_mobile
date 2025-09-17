import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:upward_mobile/l10n/app_localizations.dart' show AppLocalizations;
import 'package:upward_mobile/models/task_attachment.dart';
import 'package:upward_mobile/models/task_check.dart';
import 'package:upward_mobile/models/task_element.dart';
import 'package:upward_mobile/models/task_text.dart';
import 'package:upward_mobile/utilities/hooks.dart';

part 'task.g.dart';

enum TaskStatus { all, unclassified, completed, uncompleted, partiallyCompleted }

extension TaskStatusExtenstion on TaskStatus {
  String get value {
    switch (this) {
      case TaskStatus.all:
        return "all";
      case TaskStatus.unclassified:
        return "unclassified";
      case TaskStatus.completed:
        return "completed";
      case TaskStatus.uncompleted:
        return "uncompleted";
      case TaskStatus.partiallyCompleted:
        return "partiallyCompleted";
    }
  }

  Color get color {
    switch (this) {
      case TaskStatus.all:
        return Color(0XFFFF8F00);
      case TaskStatus.unclassified:
        return Color(0XFFFF8F00);
      case TaskStatus.completed:
        return Color(0XFF00838F);
      case TaskStatus.uncompleted:
        return Color(0XFF0277BD);
      case TaskStatus.partiallyCompleted:
        return Color(0XFFD84315);
    }
  }

  Function get message {
    switch (this) {
      case TaskStatus.all:
        return (context) => AppLocalizations.of(context)!.allTasks;
      case TaskStatus.unclassified:
        return (context) => AppLocalizations.of(context)!.unclassified;
      case TaskStatus.completed:
        return (context) => AppLocalizations.of(context)!.completed;
      case TaskStatus.uncompleted:
        return (context) => AppLocalizations.of(context)!.uncompleted;
      case TaskStatus.partiallyCompleted:
        return (context) => AppLocalizations.of(context)!.partiallyCompleted;
    }
  }

  static TaskStatus to(String value) {
    if(value == "completed") return TaskStatus.completed;
    if(value == "uncompleted") return TaskStatus.uncompleted;
    if(value == "partiallyCompleted") return TaskStatus.partiallyCompleted;
    if(value == "all") return TaskStatus.all;

    return TaskStatus.unclassified;
  }
}

// ignore: must_be_immutable
class Task extends Equatable {
  Task({
    required this.id,
    this.title,
    this.content,
    this.elements = const <String, TaskElement>{},
    this.backgroundKey,
    this.status = TaskStatus.unclassified,
    this.date,
  });

  TaskStatus status;
  final String id;
  DateTime? date;
  String? title;
  String? content;
  Map<String, TaskElement> elements;

  // Configuration
  final String? backgroundKey;

  factory Task.fromJson(Map<String, dynamic> json) {
    return _$FromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ToJson(this);
  }

  factory Task.empty() {
    return Task(
      id: Hooks.generateRandomId(),
      title: "",
      elements: const <String, TaskElement>{},
      backgroundKey: null,
      status: TaskStatus.unclassified,
      date: null,
    );
  }

  Task copyWith({
    String? title,
    String? content,
    Map<String, TaskElement>? elements,
    TaskStatus? status,
    String? backgroundKey,
    DateTime? date,
  }) {
    return Task(
      id: id,
      status: status ?? this.status,
      content: content ?? this.content,
      title: title ?? this.title,
      elements: elements ?? this.elements,
      backgroundKey: backgroundKey ?? this.backgroundKey,
      date: date ?? this.date,
    );
  }

  @override
  List<Object?> get props {
    return [id, title, elements, backgroundKey, status, content, date,];
  }

  // Utilities

  bool isNotEmpty() {
    return elements.isNotEmpty || title?.isNotEmpty == true;
  }

  Task addTaskElement(TaskElement element) {
    elements = {
      ...elements,
      element.id: element,
    };

    return this;
  }

  Task removeTaskElement(TaskElement element) {
    elements.remove(element.id);

    return this;
  }

  Map taskStatistics() {
    Map result = {};

    for(var key in elements.keys) {
      final item = elements[key]!;

      if(item is TaskAttachment || item is TaskCheck) {
        String itemKey = "";
        if(item is TaskAttachment) {
          itemKey = item.type == AttachmentType.image ? "image" : "record";
        }

        if(item is TaskCheck) {
          itemKey = "checklist";
        }

        if(itemKey.isNotEmpty) {
          if(! result.containsKey(itemKey)) {
            result[itemKey] = 0;
          }
          result[itemKey] = result[itemKey] + 1;
        }
      }
    }

    return result;
  }
}
