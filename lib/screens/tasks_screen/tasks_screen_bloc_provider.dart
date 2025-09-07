import 'package:flutter/material.dart';

import 'package:upward_mobile/screens/tasks_screen/tasks_screen.dart';

@immutable
class TasksScreenBlocProvider extends StatelessWidget {
  const TasksScreenBlocProvider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TasksScreen();
  }
}