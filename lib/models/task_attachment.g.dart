// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_attachment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

TaskAttachment _$FromJson(Map<String, dynamic> json) {
  return TaskAttachment(
    json['id'],
    file: json['file'] != null ? Hooks.retrievedFile(json['file']) : null,
    type: AttachmentTypeExtenstion.to(json['type']),
  );
}

Map<String, dynamic> _$ToJson(TaskAttachment instance) => <String, dynamic> {
  "file": instance.file?.path,
  "type": instance.type.value,
};

