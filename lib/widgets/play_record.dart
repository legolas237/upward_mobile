import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:upward_mobile/models/task_attachment.dart';

import 'package:upward_mobile/theme/palette.dart';
import 'package:upward_mobile/theme/theme_provider.dart';
import 'package:upward_mobile/utilities/hooks.dart';
import 'package:upward_mobile/widgets/wave_record.dart';

// ignore: must_be_immutable
class PlayRecordWidget extends StatelessWidget {
  PlayRecordWidget({
    super.key,
    required this.taskAttachment,
    this.isPlaying = false,
    this.playOrStop,
  });

  late Palette palette;

  final TaskAttachment taskAttachment;
  final bool isPlaying;
  final VoidCallback? playOrStop;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.theme.palette;

    return Container(
      height: 130.0, width: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: palette.captionColor(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 7.0),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              Hooks.durationToSmartFormat(taskAttachment.duration,),
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontSize: 12.0,
              ),
            ),
          ),
          Expanded(child: SizedBox()),
          SingleChildScrollView(
            padding: const EdgeInsets.only(left: 12.0),
            scrollDirection: Axis.horizontal,
            child: RecordingWaveWidget(
              minimal: true,
              startRecording: isPlaying,
            ),
          ),
          const SizedBox(height: 6.0),
          GestureDetector(
            onTap: () => playOrStop?.call(),
            child: Container(
              decoration: BoxDecoration(
                color: palette.scaffoldColor(1.0),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(6.0),
              margin: const EdgeInsets.all(10.0),
              child: Icon(
                isPlaying ? Icons.stop_outlined : Icons.play_arrow,
                size: 20.0,
                color: palette.iconColor(1.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}