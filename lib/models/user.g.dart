// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      name: fields[0] as String,
      birthDate: fields[1] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.birthDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is UserAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
  }
}

User _$FromJson(Map<String, dynamic> json) {
  return User(
    name: json['name'],
    birthDate: json['date_of_birth'] != null ? DateTime.parse(json['date_of_birth']) : null,
  );
}

Map<String, dynamic> _$ToJson(User instance) => <String, dynamic> {
  "name": instance.name,
  "date_of_birth": instance.birthDate?.toString(),
};

