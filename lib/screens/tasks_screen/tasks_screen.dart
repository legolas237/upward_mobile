import 'package:flutter/material.dart';

import 'package:upward_mobile/theme/palette.dart';
import 'package:upward_mobile/theme/theme_provider.dart';
import 'package:upward_mobile/widgets/app_scaffold.dart';

// ignore: must_be_immutable
class TasksScreen extends StatefulWidget {
  static const String routePath = "/home";

  TasksScreen({
    super.key,
  });

  late Palette palette;

  @override
  State<StatefulWidget> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    // Get theme palette
    widget.palette = ThemeProvider.of(context)!.theme.palette;

    return ScaffoldWidget(
      automaticallyImplyLeading: false,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      body: Container(),
    );
  }
}
