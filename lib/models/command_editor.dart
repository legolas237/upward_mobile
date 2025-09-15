import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class CommandEditor extends Equatable {
  const CommandEditor({
    required this.key,
    required this.icon,
  });

  final String key;
  final IconData icon;

  @override
  List<Object?> get props {
    return [icon, key];
  }
}
