import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'task_element.g.dart';

@immutable
class TaskElement extends Equatable{
   final String id;
   final String key;

   const TaskElement({
     required this.key,
     required this.id
  });

   factory TaskElement.fromJson(Map<String, dynamic> json) {
     return _$FromJson(json);
   }

   Map<String, dynamic> toJson() {
     return _$ToJson(this);
   }

  @override
  List<Object?> get props => [key, id];
}
