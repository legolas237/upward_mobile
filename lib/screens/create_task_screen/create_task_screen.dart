import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:upward_mobile/models/command_editor.dart';
import 'package:upward_mobile/models/task.dart';
import 'package:upward_mobile/l10n/app_localizations.dart' show AppLocalizations;
import 'package:upward_mobile/models/task_attachment.dart';
import 'package:upward_mobile/models/task_check.dart';
import 'package:upward_mobile/models/task_text.dart';
import 'package:upward_mobile/screens/image_viewer_screen/image_viewer_screen.dart';
import 'package:upward_mobile/theme/palette.dart';
import 'package:upward_mobile/theme/theme_provider.dart';
import 'package:upward_mobile/utilities/config.dart';
import 'package:upward_mobile/utilities/hooks.dart';
import 'package:upward_mobile/utilities/logger.dart';
import 'package:upward_mobile/viewmodels/tasks/tasks_viewmodel.dart';
import 'package:upward_mobile/widgets/app_bar_action.dart';
import 'package:upward_mobile/widgets/app_scaffold.dart';
import 'package:upward_mobile/widgets/base_inkwell.dart';
import 'package:upward_mobile/widgets/borderless_wrapper.dart';
import 'package:upward_mobile/widgets/checkbox.dart';
import 'package:upward_mobile/widgets/editor_commands.dart';
import 'package:upward_mobile/widgets/image_chooser.dart';
import 'package:upward_mobile/widgets/play_record.dart';
import 'package:upward_mobile/widgets/simple_input.dart';
import 'package:upward_mobile/widgets/spinner.dart';
import 'package:upward_mobile/widgets/task_status_chooser.dart';
import 'package:upward_mobile/widgets/wave_record.dart';

/// Create task screen
// ignore: must_be_immutable
class CreateTasksScreen extends StatefulWidget {
  static const String routePath = "/create-task";

  CreateTasksScreen({
    super.key,
    this.task,
  });

  late Palette palette;

  final Task? task;

  @override
  State<StatefulWidget> createState() => _CreateTasksScreenState();
}

class _CreateTasksScreenState extends State<CreateTasksScreen> {
  late Task _task;

  // Simple form
  late FocusNode _mainNode;

  // Command editor
  late CommandEditor? _command;

  // For record ....
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  TaskAttachment? _currentRecord;

  @override
  void initState() {
    super.initState();

    _audioPlayer = AudioPlayer();
    // Add listener ...
    _listenPlayerState();

    _command = null;
    _task = widget.task ?? Task.empty();
    _mainNode = FocusNode();
  }

  @override
  void dispose() {
    _mainNode.dispose();
    _audioPlayer.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    widget.palette = ThemeProvider.of(context)!.theme.palette;

    return BlocConsumer<TasksViewModel, TasksModel>(
      listener: (context, state) {
        if(state.status == TasksModelStatus.loaded || state.status == TasksModelStatus.intermediate) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return ScaffoldWidget(
          resizeToAvoidBottomInset: true,
          centerTitle: false,
          leading: AppBarActionWidget(
            icon: Icons.close_outlined,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            if(state.status != TasksModelStatus.processing && _task.date != null) AppBarActionWidget(
              icon: MdiIcons.trashCanOutline,
              color: widget.palette.iconColor(1.0),
              onPressed: () {
                if(_task.isNotEmpty()) {
                  vLog(_task.toJson());
                  context.read<TasksViewModel>().deleteTasks([_task]);
                }
              },
            ),
            if(state.status != TasksModelStatus.processing) AppBarActionWidget(
              icon: Icons.check_outlined,
              color: widget.palette.iconColor(1.0),
              onPressed: () {
                if(_task.isNotEmpty()) {
                  vLog(_task.toJson());
                  context.read<TasksViewModel>().addTask(_task);
                }
              },
            ),
            if(state.status == TasksModelStatus.processing) ...[
             SizedBox(
               width: 16.0, height: 16.0,
               child: SpinnerWidget(
                 colors: AlwaysStoppedAnimation<Color>(
                   widget.palette.primaryColor(1.0),
                 ),
               ),
             ),
              const SizedBox(width: Constants.horizontalPadding),
            ],
            const SizedBox(width: Constants.appBarIconPadding),
          ],
          body: BorderlessWrapperWidget(
            top: true, bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const SizedBox(height: 14.0),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: Constants.horizontalPadding,
                          right: 12.0,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                Hooks.toHumanDate(DateTime.now(), "EEE dd MMM @HH:mm",),
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 13.0,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14.0),
                            TaskStatusChooserWidget(
                              status: _task.status,
                              onSelect: (status) {
                                setState(() {
                                  _task.status = status;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14.0),
                      // Title
                      Padding(
                        padding: const EdgeInsets.only(
                          left: Constants.horizontalPadding,
                          right: Constants.horizontalPadding,
                        ),
                        child: SimpleInputWidget(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                          textColor: widget.palette.isDark ? widget.palette.textColor(1.0) : widget.palette.primaryColor(1.0),
                          placeHolder: AppLocalizations.of(context)!.title,
                          controller: _task.title?.isNotEmpty == true ? TextEditingController(text: _task.title,) : null,
                          onChanged: (value) {
                            _task.title = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: Constants.horizontalPadding,
                          right: Constants.horizontalPadding,
                          top: 4.0,
                          bottom: 10.0,
                        ),
                        child: SimpleInputWidget(
                          focusNode: _mainNode,
                          fontSize: 16.0,
                          keyboardType: TextInputType.multiline,
                          fontWeight: FontWeight.w500,
                          controller: _task.content?.isNotEmpty == true ? TextEditingController(text: _task.content,) : null,
                          placeHolder: AppLocalizations.of(context)!.taskContent,
                          onChanged: (value) {
                            _task.content = value;
                          },
                        ),
                      ),
                      ..._buildTaskElements(),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                BorderlessWrapperWidget(
                  top: true, bottom: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10.0),
                      CommandsEditorWidget(
                        task: _task,
                        callback: (command, taskElement) {
                          if(command.key == Constants.checklistCommand || command.key == Constants.textCommand) {
                            _command = null;
                          } else{
                            // Set command editor
                            _command = command;
                          }

                          if(taskElement != null) {
                            _task = _task.addTaskElement(taskElement);
                          } else {
                            if(command.key != Constants.microCommand && command.key != Constants.imageCommand) {
                              _mainNode.requestFocus();
                            }
                          }

                          // Update
                          setState(() => {});
                        },
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ),
                if(_command?.key == Constants.microCommand) WaveRecordWidget(
                  onSave: (duration, file) {
                    setState(() {
                      _command = null;
                      if(file != null) {
                        _task = _task.addTaskElement(TaskAttachment(
                          "${Hooks.generateRandomId()}_${_task.elements.length + 1}",
                          file: file,
                          duration: duration,
                          type: AttachmentType.vocal,
                        ));
                      }
                    });
                  },
                ),
                if(_command?.key == Constants.imageCommand) ImageChooserWidget(
                  onSave: (file) {
                    setState(() {
                      _command = null;
                      if(file != null) {
                        _task = _task.addTaskElement(TaskAttachment(
                          "${Hooks.generateRandomId()}_${_task.elements.length + 1}",
                          file: file,
                          type: AttachmentType.image,
                        ));
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Build task element widget
  List<Widget> _buildTaskElements() {
    List<Widget> result = [];
    List<TaskAttachment> attachments = [];
    final elements = _task.elements.values.toList();

    for(var index = 0; index < elements.length; index++) {
      final element = _task.elements.values.toList()[index];

      if(element is TaskAttachment) {
        final nextElement = index + 1 < elements.length ? elements[index + 1] : null;
        attachments.add(element);

        if(nextElement is! TaskAttachment) {
          result.add(_buildAttachments(attachments));
          attachments.clear();
        }
      } else {
        if(element is TaskCheck) {
          result.add(_buildCheckElement(element));
        }

        if(element is TaskText) {
          result.add(_buildTextElement(element));
        }
      }
    }

    return result;
  }

  /// Build text task element widget
  Widget _buildTextElement(TaskText element) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Constants.horizontalPadding,
        right: 10.0,
        top: 10.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: SimpleInputWidget(
              fontSize: 14.0,
              autofocus: true,
              controller: element.content.isNotEmpty == true ? TextEditingController(text: element.content) : null,
              keyboardType: TextInputType.multiline,
              fontWeight: FontWeight.w500,
              placeHolder: AppLocalizations.of(context)!.continueWriting,
              onChanged: (value) {
                _task.elements[element.id] = (_task.elements[element.id] as TaskText).copyWith(
                  content: value,
                );
              },
            ),
          ),
          const SizedBox(width: 20.0),
          BaseInkWellWidget(
            borderRadius: BorderRadiusGeometry.circular(100.0),
            callback: () {
              setState(() {
                _task.removeTaskElement(element);
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                Icons.close_outlined,
                size: 18.0,
                color: widget.palette.captionColor(1.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build check task element widget
  Widget _buildCheckElement(TaskCheck element) {
    final currentElement = _task.elements[element.id] as TaskCheck;

    return Padding(
      padding: const EdgeInsets.only(
        top: 4.0, bottom: 0.0,
        left: 18.0, right: 10.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
            ),
            child: Icon(
              Icons.drag_indicator_outlined,
              color: widget.palette.textColor(1.0),
              size: 20.0,
            ),
          ),
          const SizedBox(width: 10.0),
          CheckBoxWidget(
            value: element.completed,
            callback: (value) {
              setState(() {
                _task.elements[element.id] = currentElement.copyWith(
                  completed: value,
                );
              });
            },
          ),
          const SizedBox(width: 4.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
              ),
              child: SimpleInputWidget(
                fontSize: 15.0,
                autofocus: true,
                enabled: !element.completed,
                keyboardType: TextInputType.multiline,
                fontWeight: FontWeight.w500,
                controller: element.content.isNotEmpty == true ? TextEditingController(text: element.content) : null,
                placeHolder: "",
                textDecoration: element.completed ? TextDecoration.lineThrough : null,
                onChanged: (value) {
                  _task.elements[element.id] = currentElement.copyWith(
                    content: value,
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 14.0),
          Padding(
            padding: const EdgeInsets.only(
              top: 6.0,
            ),
            child: BaseInkWellWidget(
              borderRadius: BorderRadiusGeometry.circular(100.0),
              callback: () {
                setState(() {
                  _task.removeTaskElement(element);
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Icon(
                  Icons.close_outlined,
                  size: 18.0,
                  color: widget.palette.captionColor(1.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build attachment task element widget
  Widget _buildAttachments(List<TaskAttachment> elements) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Constants.horizontalPadding,
        right: Constants.horizontalPadding,
        top: 10.0,
      ),
      child: Wrap(
        spacing: 10.0,
        runSpacing: 10.0,
        children: elements.map((element) {
          return Stack(
            children: [
              if(element.type == AttachmentType.image) GestureDetector(
                onTap: () {
                  if(element.file == null) {
                    Navigator.pushNamed(
                      context,
                      ImageViewerScreen.routePath,
                      arguments: [element.file!.path],
                    );
                  }
                },
                child: Container(
                  height: 130.0, width: 100.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: widget.palette.captionColor(0.1),
                    image: element.file != null ? DecorationImage(
                      image: FileImage(element.file!),
                      fit: BoxFit.cover,
                    ) : null,
                  ),
                ),
              ),
              if(element.type == AttachmentType.vocal) Builder(
                builder: (_) {
                  final isPlaying = _isPlaying && _currentRecord?.id == element.id;

                  return PlayRecordWidget(
                    taskAttachment: element,
                    isPlaying: isPlaying,
                    playOrStop: () {
                      if(isPlaying) _stopPlaying();
                      if(!isPlaying) _playRecording(element);
                    },
                  );
                },
              ),
              PositionedDirectional(
                top: 6.0, end: 6.0,
                child: GestureDetector(
                  onTap: () {
                    _stopPlaying();
                    setState(() {
                      _task.removeTaskElement(element);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.palette.scaffoldColor(1.0),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.close_outlined,
                      size: 11.0,
                      color: widget.palette.iconColor(1.0),
                    ),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  // Utilities

  /// Try to play record
  Future<void> _playRecording(TaskAttachment record) async {
    try {
      setState(() {
        _isPlaying = true;
        _currentRecord = record;
      });

      await _audioPlayer.setFilePath(record.file!.path);
      await _audioPlayer.play();
    } catch (error, trace) {
      debugPrint(error.toString());
      debugPrint(trace.toString());
    }
  }

  /// Stop record player
  Future<void> _stopPlaying() async {
    await _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
      _currentRecord = null;
    });
  }

  /// Listen player state
  void _listenPlayerState() {
    _audioPlayer.playerStateStream.listen((playerState) {
      final processingState = playerState.processingState;

      if(processingState == ProcessingState.completed) {
        setState(() {
          _isPlaying = false;
          _currentRecord = null;
        });
      }
    });
  }
}
