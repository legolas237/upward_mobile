import 'package:test/test.dart';

import 'package:upward_mobile/models/task.dart';
import 'package:upward_mobile/models/task_check.dart';
import 'package:upward_mobile/models/task_text.dart';
import 'package:upward_mobile/utilities/hooks.dart';

void main() {
  var task = Task(id: Hooks.generateRandomId());

  group('Testing Text Task Model', () {
    // Text task
    final textTask = TaskText(
      Hooks.generateRandomId(),
      content: "My first note",
    );

    test('The task item should be added', () {
      task.addTaskElement(textTask);
      expect(task.elements.containsKey(textTask.id), true);
    });

    test('The task item should be updated', () {
      final newTaskItem = textTask.copyWith(
        content: "My updated note",
      );
      task.addTaskElement(newTaskItem);

      expect(task.elements.keys.contains(newTaskItem.id), true,);
      expect((task.elements[newTaskItem.id] as TaskText?)?.content == "My updated note" , true,);
    });

    test('The text task item id must remain unchanged', () {
      final newTaskItem = textTask.copyWith(
        content: "New clone task item",
      );

      expect(newTaskItem.id == textTask.id, true);
    });

    test('The task item should be removed', () {
      task.removeTaskElement(textTask);
      expect(task.elements.containsKey(textTask.id), false);
    });
  });

  group('Testing Check Task Model', () {
    // Check task
    final checkTask = TaskCheck(
      Hooks.generateRandomId(),
      content: "Shopping this weekend",
    );

    test('A new check item task should be added', () {
      task.addTaskElement(checkTask);
      expect(task.elements.containsKey(checkTask.id), true);
    });

    test('The check task item must be checked', () {
      final newTaskItem = checkTask.copyWith(
        completed: true,
      );
      task.addTaskElement(newTaskItem);

      expect((task.elements[newTaskItem.id] as TaskCheck?)?.completed, true,);
    });

    test('The check task item should be updated', () {
      final newTaskItem = checkTask.copyWith(
        content: "We finished shopping",
      );
      task.addTaskElement(newTaskItem);

      expect(task.elements.keys.contains(newTaskItem.id), true,);
      expect((task.elements[newTaskItem.id] as TaskCheck?)?.content == "We finished shopping" , true,);
    });

    test('The check task item id must remain unchanged', () {
      final newTaskItem = checkTask.copyWith(
        content: "Another clone task item",
      );

      expect(newTaskItem.id == checkTask.id, true);
    });

    test('The check task item should be removed', () {
      task.removeTaskElement(checkTask);
      expect(task.elements.containsKey(checkTask.id), false);
    });
  });
}