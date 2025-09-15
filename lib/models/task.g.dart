// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

Task _$FromJson(Map<String, dynamic> json) {
  Map<String, TaskElement> elements = {};
  final map = json['elements'] as Map;

  for(var key in map.keys) {
    final item = Map<String, dynamic>.from(map[key]);

    switch(item['key']) {
      case TaskText.typeKey:
        elements[key] = TaskText.fromJson(item);
        break;
      case TaskAttachment.typeKey:
        elements[key] = TaskAttachment.fromJson(item);
        break;
      case TaskCheck.typeKey:
        elements[key] = TaskCheck.fromJson(item);
        break;
      default:
        elements[key] = TaskElement.fromJson(item);
        break;
    }
  }

  return Task(
    id: json['id'],
    title: json['title'],
    content: json['content'],
    backgroundKey: json['background_key'],
    date: json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
    status: TaskStatusExtenstion.to(json['status']),
    elements: elements,
  );
}

Map<String, dynamic> _$ToJson(Task instance) {
  Map elements = {};
  for(var key in instance.elements.keys) {
    elements[key] = instance.elements[key]!.toJson();
  }

  return {
    "id": instance.id,
    "title": instance.title,
    "content": instance.content,
    "background_key": instance.backgroundKey,
    "status": instance.status.value,
    "elements": elements,
    "date": instance.date?.toString(),
  };
}

