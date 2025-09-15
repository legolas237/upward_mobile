import 'package:flutter/material.dart';
import 'package:upward_mobile/l10n/app_localizations.dart' show AppLocalizations;

import 'package:upward_mobile/models/task.dart';
import 'package:upward_mobile/theme/palette.dart';
import 'package:upward_mobile/theme/theme_provider.dart';
import 'package:upward_mobile/utilities/config.dart';
import 'package:upward_mobile/utilities/hooks.dart';
import 'package:upward_mobile/widgets/app_scaffold.dart';
import 'package:upward_mobile/widgets/base_inkwell.dart';
import 'package:upward_mobile/widgets/inline_status.dart';

// ignore: must_be_immutable
class TaskStatusChooserWidget extends StatelessWidget {
  TaskStatusChooserWidget({
    super.key,
    required this.status,
    this.onSelect,
  });

  late Palette palette;

  final TaskStatus status;
  final Function(TaskStatus)? onSelect;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.theme.palette;

    return BaseInkWellWidget(
      callback: () => _statusBottomSheet(context),
      borderRadius: BorderRadius.circular(100.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 4.0, horizontal: 6.0,
        ),
        child: Row(
          children: [
            Container(
              height: 12.0, width: 12.0,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: status.color,
                  width: 2.0,
                ),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6.0),
            Text(
              status.message(context),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 12.0,
              ),
            ),
            const SizedBox(width: 4.0),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Icon(
                Icons.expand_more_outlined,
                size: 14.0,
                color: palette.textColor(1.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Bottom sheet

  void _statusBottomSheet(BuildContext context) {
    Hooks.removeFocus();

    showModalBottomSheet<void>(
      context: context,
      enableDrag: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          constraints: BoxConstraints(
            minHeight: 100.0,
            maxHeight: MediaQuery.of(context).size.height - ScaffoldWidget.appBarMaxHeight,
          ),
          padding: MediaQuery.of(context).viewInsets,
          decoration: BoxDecoration(
            color: palette.scaffoldColor(1.0),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(Constants.bottomSheetRadius),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: Constants.verticalPadding,
                  bottom: Constants.verticalPadding,
                  left: Constants.horizontalPadding,
                  right: MediaQuery.of(context).size.width * 0.4,
                ),
                child: Text(
                  AppLocalizations.of(context)!.changeStatus,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 20.0,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Constants.horizontalPadding,
                ),
                child: Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: TaskStatus.values.where((element) => element != TaskStatus.all).map((element) {
                    if(element == TaskStatus.all) return const SizedBox();

                    return InlineStatusWidget(
                      isSelected: status == element,
                      status: element,
                      fontSize: 14.0,
                      callback: () {
                        onSelect?.call(element);
                        Navigator.pop(context);
                      },
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        );
      },
    );
  }
}
