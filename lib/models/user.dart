import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:upward_mobile/config/config.dart';

part 'user.g.dart';

@immutable
@HiveType(
  typeId: Constants.userHiveAdapterId,
  adapterName: Constants.userHiveAdapterName,
)
class User extends Equatable {
  const User({required this.name, this.birthDate});

  @HiveField(0)
  final String name;

  @HiveField(1)
  final DateTime? birthDate;

  factory User.fromJson(Map<String, dynamic> json) {
    return _$FromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ToJson(this);
  }

  User copyWith({String? name, DateTime? birthDate}) {
    return User(
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
    );
  }

  @override
  List<Object?> get props {
    return [name, birthDate];
  }
}
