import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:faker/faker.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';

import 'package:upward_mobile/models/task.dart';
import 'package:upward_mobile/repositories/task_repository.dart';
import 'package:upward_mobile/utilities/config.dart';
import 'package:upward_mobile/viewmodels/tasks/tasks_viewmodel.dart';
import '../../models/task_test.dart';

// ignore: must_be_immutable
class MockTaskRepository extends Mock implements TaskRepository {}

class MockTasksViewModel extends MockCubit<TasksModel> implements TasksViewModel {
  MockTasksViewModel(this.repository);

  final MockTaskRepository repository;
}

void main() async {
  late MockTaskRepository repository;
  late MockTasksViewModel cubit;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();

    // Repository
    repository = MockTaskRepository();
    cubit = MockTasksViewModel(repository);

    // Set mock app document directory
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/path_provider'), (MethodCall methodCall) async {
        return '.';
      },
    );
  });

  // Init hive
  Hive.init('.');
  await Hive.openBox(Constants.upwardTable);

  // Fake data
  final faker = Faker();
  final List<Task> tasks = List.filled(
    faker.randomGenerator.integer(10),
    TaskTest.generateFake(),
  );

  group('TasksViewModel', () {
    test('Cubit should have initial state to TasksModel(status: TasksModelStatus.initial)', (){
      expect(cubit.state.status == TasksModelStatus.initial, true);
    });

    // blocTest<TasksViewModel, TasksModel>(
    //   'emits TasksModel(status: TasksModelStatus.initial) when nothing is called',
    //   build: () => cubit,
    //   expect: () => [],
    // );
    //
    // blocTest<TasksViewModel, TasksModel>(
    //   'emits [TasksModel(status = TasksModelStatus.loaded, tasks: [tasks.first])] when addTask is called',
    //   build: () {
    //     when(repository.tasks()).thenAnswer((_) async => []);
    //     return MockTasksViewModel(repository);
    //   },
    //   act: (cubit) => cubit.addTask(tasks.first),
    //   expect: () => [
    //     TasksModel(status: TasksModelStatus.processing),
    //     TasksModel(status: TasksModelStatus.loaded, tasks: [tasks.first]),
    //   ],
    //   verify: (_) {
    //     verify(repository.tasks()).called(1);
    //   },
    // );
  });

  tearDown(() async {
    cubit.close();

    // Try to clear all
    final box = Hive.box(Constants.upwardTable);
    await box.clear();
    await box.deleteFromDisk();
  });
}