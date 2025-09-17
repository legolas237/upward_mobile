import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

import 'package:upward_mobile/models/task_text.dart';

@immutable
class TaskTextTest {
  static TaskText generateFake() {
    final faker = Faker();

    return TaskText(
      faker.guid.guid(),
      content: faker.randomGenerator.string(20, min: 10),
    );
  }
}
