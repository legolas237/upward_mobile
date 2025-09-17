import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

import 'package:upward_mobile/models/task_check.dart';

@immutable
class TaskCheckTest {
  static TaskCheck generateFake() {
    final faker = Faker();

    return TaskCheck(
      faker.guid.guid(),
      content: faker.randomGenerator.string(20, min: 10),
      completed: faker.randomGenerator.boolean(),
    );
  }
}
