import 'dart:io';
import 'package:flutter/material.dart';

import 'package:upward_mobile/models/task_element.dart';
import 'package:upward_mobile/utilities/hooks.dart';

part 'task_attachment.g.dart';

enum AttachmentType { image, vocal, doc }

extension AttachmentTypeExtenstion on AttachmentType {
  String get value {
    switch (this) {
      case AttachmentType.image:
        return "image";
      case AttachmentType.vocal:
        return "vocal";
      case AttachmentType.doc:
        return "doc";
    }
  }

  static AttachmentType to(String value) {
    if(value == "vocal") return AttachmentType.vocal;
    if(value == "doc") return AttachmentType.doc;

    return AttachmentType.image;
  }
}

@immutable
class TaskAttachment extends TaskElement {
  const TaskAttachment(String id, {
    this.file,
    required this.type,
  }) : super(key: typeKey, id: id);

  final File? file;
  final AttachmentType type;

  static const String typeKey = 'TaskAttachment';

  @override
  factory TaskAttachment.fromJson(Map<String, dynamic> json) {
    return _$FromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      ..._$ToJson(this),
    };
  }

  TaskAttachment copyWith({
    File? file,
    AttachmentType? type,
  }) {
    return TaskAttachment(
      id,
      type: type ?? this.type,
      file: file ?? this.file,
    );
  }

  @override
  List<Object?> get props {
    return [...super.props, type, file, key];
  }
}
