import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:upward_mobile/models/command_editor.dart';
import 'package:upward_mobile/models/task.dart';
import 'package:upward_mobile/models/task_attachment.dart';
import 'package:upward_mobile/models/task_check.dart';
import 'package:upward_mobile/models/task_element.dart';
import 'package:upward_mobile/models/task_text.dart';
import 'package:upward_mobile/theme/palette.dart';
import 'package:upward_mobile/theme/theme_provider.dart';
import 'package:upward_mobile/utilities/config.dart';
import 'package:upward_mobile/utilities/hooks.dart';
import 'package:upward_mobile/widgets/base_inkwell.dart';

// ignore: must_be_immutable
class CommandsEditorWidget extends StatelessWidget {
  CommandsEditorWidget({
    super.key,
    required this.task,
    this.callback,
  });

  late Palette palette;

  final Task task;
  final Function(CommandEditor, TaskElement?)? callback;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.theme.palette;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.minHorizontalPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _commandsEditor.map((command) {
          return BaseInkWellWidget(
            callback: () {
              Hooks.removeFocus();

              if(command.key == Constants.textCommand) {
                final lastElement = task.elements.isNotEmpty ? task.elements.values.last : null;

                if(lastElement is TaskAttachment || lastElement is TaskCheck) {
                  callback?.call(command, TaskText(
                    "${Hooks.generateRandomId()}_${task.elements.length + 1}${DateTime.now().millisecondsSinceEpoch}",
                    content: "",
                  ));
                } else {
                  callback?.call(command, null);
                }
              }

              if(command.key == Constants.checklistCommand) {
                callback?.call(command, TaskCheck(
                  "${Hooks.generateRandomId()}_${task.elements.length + 1}${DateTime.now().millisecondsSinceEpoch}",
                  content: "",
                ));
              }

              if(command.key == Constants.microCommand) {
                callback?.call(command, null);
              }

              if(command.key == Constants.imageCommand) {
                callback?.call(command, null);
              }

              if(command.key == Constants.templateCommand) {}
            },
            borderRadius: BorderRadius.circular(100.0),
            tileColor: Colors.transparent,
            overlayColor: palette.overlayLightColor(1.0),
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 4.0,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0, vertical: 10.0,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Icon(
                command.icon,
                color: palette.iconColor(1.0),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  List<CommandEditor> get _commandsEditor {
    return [
      CommandEditor(
        key: Constants.textCommand,
        icon: MdiIcons.formatTextVariantOutline,
      ),
      CommandEditor(
        key: Constants.checklistCommand,
        icon: MdiIcons.checkCircleOutline,
      ),
      CommandEditor(
        key: Constants.microCommand,
        icon: MdiIcons.microphoneOutline,
      ),
      CommandEditor(
        key: Constants.imageCommand,
        icon: MdiIcons.imagePlusOutline,
      ),
      CommandEditor(
        key: Constants.templateCommand,
        icon: MdiIcons.imageAutoAdjust,
      ),
    ];
  }
}
