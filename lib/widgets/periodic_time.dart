import 'dart:async';
import 'package:flutter/material.dart';

import 'package:upward_mobile/theme/palette.dart';
import 'package:upward_mobile/utilities/hooks.dart';

// ignore: must_be_immutable
class IncrementalTimerWidget extends StatefulWidget {
  IncrementalTimerWidget({
    super.key,
    this.startRecording = false,
    this.onDuration,
  });

  late Palette palette;

  final bool startRecording;
  final Function(int)? onDuration;

  @override
  State<StatefulWidget> createState() => _IncrementalTimerWidget();
}

class _IncrementalTimerWidget extends State<IncrementalTimerWidget> {
  int _seconds = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void didUpdateWidget(IncrementalTimerWidget oldWidget) {
    _startTimer();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      Hooks.durationToSmartFormat(_seconds),
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }

  void _startTimer() {
    if(widget.startRecording && _timer == null) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _seconds = _seconds + 1;
        widget.onDuration?.call(_seconds);
        setState(() => {});
      });
    } else {
      _timer?.cancel();
      _timer = null;
    }
  }
}