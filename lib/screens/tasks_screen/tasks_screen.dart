import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:upward_mobile/models/task.dart';
import 'package:upward_mobile/models/user.dart';
import 'package:upward_mobile/l10n/app_localizations.dart' show AppLocalizations;
import 'package:upward_mobile/repositories/user_repository.dart';
import 'package:upward_mobile/screens/create_task_screen/create_task_screen.dart';
import 'package:upward_mobile/theme/palette.dart';
import 'package:upward_mobile/theme/theme_provider.dart';
import 'package:upward_mobile/utilities/config.dart';
import 'package:upward_mobile/utilities/hooks.dart';
import 'package:upward_mobile/viewmodels/tasks/tasks_viewmodel.dart';
import 'package:upward_mobile/widgets/app_bar_action.dart';
import 'package:upward_mobile/widgets/app_scaffold.dart';
import 'package:upward_mobile/widgets/base_inkwell.dart';
import 'package:upward_mobile/widgets/borderless_wrapper.dart';
import 'package:upward_mobile/widgets/error_column.dart';
import 'package:upward_mobile/widgets/inline_status.dart';
import 'package:upward_mobile/widgets/retro_spinner.dart';

// ignore: must_be_immutable
class TasksScreen extends StatefulWidget {
  static const String routePath = "/task";

  TasksScreen({
    super.key,
  });

  late Palette palette;
  late User user;

  @override
  State<StatefulWidget> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  late TaskStatus _status;
  late Map<String, Task> _selectedTasks;

  @override
  void initState() {
    super.initState();

    _selectedTasks = {};
    _status = TaskStatus.all;
  }

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    widget.palette = ThemeProvider.of(context)!.theme.palette;
    // Vars ...
    widget.user = RepositoryProvider.of<UserRepository>(context).user()!;

    return BlocBuilder<TasksViewmodel, TasksModel>(
      builder: (context, state) {
        return ScaffoldWidget(
          automaticallyImplyLeading: false,
          resizeToAvoidBottomInset: false,
          centerTitle: false,
          title: " Hello, ${Hooks.firstWords(widget.user.name, 1)}",
          titleColor: widget.palette.isDark ? widget.palette.textColor(1.0) : widget.palette.primaryColor(1.0),
          actions: [
            if(_selectedTasks.isEmpty) ... [
              if(state.status == TasksModelStatus.loaded || state.status == TasksModelStatus.intermediate) AppBarActionWidget(
                icon: Icons.refresh_outlined,
                onPressed: () {
                  BlocProvider.of<TasksViewmodel>(context).tasks();
                },
              ),
              if(state.status != TasksModelStatus.error) AppBarActionWidget(
                icon: Icons.add_outlined,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    CreateTasksScreen.routePath,
                  );
                },
              ),
              AppBarActionWidget(
                icon: Icons.event_outlined,
                onPressed: () {},
              ),
            ],
            if(_selectedTasks.isNotEmpty && state.status != TasksModelStatus.processing) AppBarActionWidget(
              icon: MdiIcons.trashCanOutline,
              color: widget.palette.iconColor(1.0),
              onPressed: () {
                context.read<TasksViewmodel>().deleteTasks(
                  _selectedTasks.values.toList(),
                );
                // Clear
                _selectedTasks.clear();
              },
            ),
            const SizedBox(width: Constants.appBarIconPadding),
          ],
          floatingActionButton: _selectedTasks.isEmpty && (state.status != TasksModelStatus.error || state.status != TasksModelStatus.processing) ? Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 6.0, horizontal: 2.0,
            ),
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  CreateTasksScreen.routePath,
                );
              },
              backgroundColor: widget.palette.buttonColor(1.0),
              splashColor: widget.palette.buttonOverlayColor(1.0),
              hoverColor: widget.palette.buttonOverlayColor(1.0),
              label: Text(
                AppLocalizations.of(context)!.addTask.toUpperCase(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: widget.palette.buttonTexTColor(1.0),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              icon: Icon(
                Icons.add_outlined,
                color: widget.palette.buttonTexTColor(1.0),
                size: 22.0,
              ),
            ),
          ) : null,
          body: BorderlessWrapperWidget(
            top: true, bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(state.tasks.isNotEmpty) SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18.0,
                    vertical: 18.0,
                  ),
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 14.0,
                    children: TaskStatus.values.map((element) {
                      return InlineStatusWidget(
                        isSelected: _status == element,
                        status: element,
                        callback: () {
                          setState(() {
                            _status = element;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: Builder(
                    builder: (_,) {
                      if(state.status == TasksModelStatus.initial) {
                        BlocProvider.of<TasksViewmodel>(context).tasks();
                      }

                      if(state.status == TasksModelStatus.error) {
                        return ErrorColumnWidget(
                          icon: Icons.error_outline,
                          subTitle: AppLocalizations.of(context)!.anErrorOccurred,
                          callback: () {
                            BlocProvider.of<TasksViewmodel>(context).tasks();
                          },
                        );
                      }

                      if(state.status == TasksModelStatus.loaded || state.status == TasksModelStatus.intermediate) {
                        if(state.tasks.isEmpty) {
                          return ErrorColumnWidget(
                            icon: Icons.sticky_note_2_outlined,
                            title: AppLocalizations.of(context)!.isEmptyAroundHere,
                            subTitle: AppLocalizations.of(context)!.emptyTasks,
                          );
                        }

                        final tasks = _status == TaskStatus.all ? state.tasks : state.tasks.where((task) {
                          return task.status == _status;
                        }).toList();

                        return ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 14,
                              mainAxisSpacing: 14,
                              shrinkWrap: true,
                              childAspectRatio: 0.8,
                              padding: const EdgeInsets.symmetric(
                                horizontal: Constants.horizontalPadding,
                                vertical: 10.0,
                              ),
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                ...tasks.map((task) {
                                  final statistics = task.taskStatistics();
                                  final isSelected = _selectedTasks.containsKey(task.id,);
                                  final bgColor = isSelected
                                      ?  (widget.palette.isDark ? widget.palette.secondaryColor(1.0) : widget.palette.primaryColor(1.0))
                                      : widget.palette.surfaceColor(1.0);
                                  final titleColor = isSelected ?  widget.palette.scaffoldColor(1.0) : widget.palette.textColor(1.0);
                                  final contentColor = isSelected ?  widget.palette.scaffoldColor(1.0) : widget.palette.captionColor(1.0);

                                  return BaseInkWellWidget(
                                    callback: () {
                                      if(_selectedTasks.isNotEmpty) {
                                        _selectTask(task);
                                      } else {
                                        Navigator.pushNamed(
                                          context,
                                          CreateTasksScreen.routePath,
                                          arguments: task,
                                        );
                                      }
                                    },
                                    onLongPress: () => _selectTask(task),
                                    borderRadius: BorderRadius.circular(6.0),
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color: bgColor,
                                            borderRadius: BorderRadius.circular(6.0),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      task.title!,
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                      textAlign: TextAlign.center,
                                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                        fontSize: 17.0,
                                                        height: 1.2,
                                                        color: titleColor,
                                                        fontWeight: FontWeight.w700,
                                                      ),
                                                    ),
                                                    if(task.content?.isNotEmpty == true) ...[
                                                      const SizedBox(height: 6.0),
                                                      Text(
                                                        task.content!,
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        textAlign: TextAlign.center,
                                                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                                          fontSize: 13.0,
                                                          color: contentColor,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 10.0, width: 10.0,
                                                    decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      border: Border.all(
                                                        color: (task.status).color,
                                                        width: 2.0,
                                                      ),
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8.0),
                                                  Flexible(
                                                    child: Text(
                                                      (task.status).message(context),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                        fontSize: 13.0,
                                                        fontWeight: FontWeight.w500,
                                                        color: widget.palette.captionColor(1.0),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              if(statistics.values.isNotEmpty) ...[
                                                const SizedBox(height: 4.0),
                                                Builder(
                                                  builder: (context) {
                                                    return Wrap(
                                                      spacing: 0.0,
                                                      runSpacing: 2.0,
                                                      runAlignment: WrapAlignment.center,
                                                      crossAxisAlignment: WrapCrossAlignment.center,
                                                      alignment: WrapAlignment.center,
                                                      children: statistics.keys.map((key) {
                                                        final count = statistics[key];
                                                        return Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(100.0),
                                                          ),
                                                          padding: const EdgeInsets.only(
                                                            left: 6.0, right: 8.0,
                                                            top: 3.0, bottom: 3.0,
                                                          ),
                                                          child: Row(
                                                            mainAxisSize: MainAxisSize.min,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              if(key == "checklist") Icon(
                                                                MdiIcons.checkCircleOutline,
                                                                size: 14.0,
                                                                color: titleColor,
                                                              ),
                                                              if(key == "image") Icon(
                                                                MdiIcons.imageOutline,
                                                                size: 14.0,
                                                                color: titleColor,
                                                              ),
                                                              if(key == "record") Icon(
                                                                MdiIcons.microphoneOutline,
                                                                size: 15.0,
                                                                color: titleColor,
                                                              ),
                                                              const SizedBox(width: 2.0),
                                                              Text(
                                                                count.toString(),
                                                                maxLines: 1,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                                  fontSize: 12.0,
                                                                  fontWeight: FontWeight.w700,
                                                                  color: titleColor,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }).toList(),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ],
                                          ),
                                        ),
                                        if(isSelected) PositionedDirectional(
                                          top: 6.0, end: 6.0,
                                          child: Icon(
                                            Icons.check_circle,
                                            color: titleColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ],
                        );
                      }

                      return Center(
                        child: RetroSpinnerWidget(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Utilities

  void _selectTask(Task task) {
    final isSelected = _selectedTasks.containsKey(task.id,);

    if(isSelected) {
      _selectedTasks.remove(task.id);
    } else {
      _selectedTasks[task.id] = task;
    }

    // Update ...
    setState(() => {});
  }
}
