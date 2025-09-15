import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

import 'package:upward_mobile/l10n/app_localizations.dart' show AppLocalizations;
import 'package:upward_mobile/theme/palette.dart';
import 'package:upward_mobile/theme/theme_provider.dart';
import 'package:upward_mobile/utilities/config.dart';
import 'package:upward_mobile/utilities/hooks.dart';
import 'package:upward_mobile/widgets/base_inkwell.dart';
import 'package:upward_mobile/widgets/borderless_wrapper.dart';
import 'package:upward_mobile/widgets/periodic_time.dart';

// ignore: must_be_immutable
class WaveRecordWidget extends StatefulWidget {
  WaveRecordWidget({
    super.key,
    this.onSave,
  });

  late Palette palette;

  final Function(File?)? onSave;

  @override
  State<StatefulWidget> createState() => _WaveRecordWidgetState();
}

class _WaveRecordWidgetState extends State<WaveRecordWidget> {
  bool _isRecording = false;
  late PermissionStatus? _permissionStatus;
  late final AudioRecorder _audioRecorder;

  @override
  void initState() {
    _audioRecorder = AudioRecorder();
    _permissionStatus = null;
    super.initState();
  }

  @override
  void dispose() {
    _audioRecorder.dispose();
    super.dispose();
  }

  Future<void> _startRecording() async {
    try {
      String filePath = await getApplicationDocumentsDirectory().then((value) {
        return '${value.path}/${Hooks.generateRandomId()}${DateTime.now().millisecondsSinceEpoch}.wav';
      });

      await _audioRecorder.start(
        const RecordConfig(
          encoder: AudioEncoder.wav,
        ),
        path: filePath,
      );
    } catch (error, trace) {
      debugPrint(error.toString());
      debugPrint(trace.toString());
    }
  }

  Future<void> _stopRecording() async {
    try {
      String? path = await _audioRecorder.stop();

      widget.onSave?.call(File(path!));

      setState(() {
        _isRecording = false;
      });
      debugPrint('********* Record path: $path');
    } catch (error, trace) {
      debugPrint(error.toString());
      debugPrint(trace.toString());
    }
  }

  Future<void> _cancelRecord() async {
    try {
      if(_isRecording) {
        await _audioRecorder.cancel();
      }

      widget.onSave?.call(null);
    } catch (error, trace) {
      debugPrint(error.toString());
      debugPrint(trace.toString());
    }
  }

  void _record() async {
    if (_isRecording == false) {
      _permissionStatus = await Permission.microphone.request();

      if (_permissionStatus == PermissionStatus.granted) {
        setState(() {
          _isRecording = true;
        });
        await _startRecording();
      } else if (_permissionStatus == PermissionStatus.permanentlyDenied) {
        debugPrint('*********** Permission permanently denied');
        setState(() => {});
      }
    } else {
      await _stopRecording();
      setState(() {
        _isRecording = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    widget.palette = ThemeProvider.of(context)!.theme.palette;

    return BorderlessWrapperWidget(
      top: true, bottom: false,
      child: Container(
        height: 80.0,
        color: widget.palette.annotationColor(1.0),
        padding: const EdgeInsets.only(
          left: Constants.horizontalPadding, right: 16.0,
        ),
        child: Builder(
          builder: (_) {
            if(_permissionStatus == PermissionStatus.permanentlyDenied) {
              return Center(
                child: Text(
                  AppLocalizations.of(context)!.permanentlyDenied,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              );
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IncrementalTimerWidget(
                        startRecording: _isRecording,
                      ),
                    ],
                  ),
                ),
                RecordingWaveWidget(
                  startRecording: _isRecording,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if(!_isRecording) BaseInkWellWidget(
                        callback: () => _record(),
                        overlayColor: Colors.transparent,
                        tileColor: Colors.transparent,
                        child: Container(
                          alignment: Alignment.center,
                          child: Icon(
                            MdiIcons.microphoneOutline,
                            color: Theme.of(context).colorScheme.error,
                            size: 26.0,
                          ),
                        ),
                      ),
                      if(_isRecording) BaseInkWellWidget(
                        callback: () => _stopRecording(),
                        overlayColor: Colors.transparent,
                        tileColor: Colors.transparent,
                        child: Container(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.stop_outlined,
                            color: Theme.of(context).colorScheme.error,
                            size: 32.0,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      BaseInkWellWidget(
                        callback: () => _cancelRecord(),
                        overlayColor: Colors.transparent,
                        tileColor: Colors.transparent,
                        child: Container(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.close_outlined,
                            color: widget.palette.iconColor(1.0),
                            size: 24.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// Widgets

// ignore: must_be_immutable
class RecordingWaveWidget extends StatefulWidget {
  RecordingWaveWidget({
    super.key,
    this.startRecording = false,
    this.minimal = false,
  });

  late Palette palette;

  final bool startRecording;
  final bool minimal;

  @override
  State<StatefulWidget> createState() => _RecordingWaveWidgetState();
}

class _RecordingWaveWidgetState extends State<RecordingWaveWidget> {
  late List<double> _heights;
  Timer? _timer;

  @override
  void initState() {
    _initState();
    super.initState();
  }

  @override
  void didUpdateWidget(RecordingWaveWidget oldWidget) {
    if(widget.startRecording != oldWidget.startRecording) {
      _initState();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    widget.palette = ThemeProvider.of(context)!.theme.palette;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _heights.map((height) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 3,
          height: widget.minimal
              ? (MediaQuery.sizeOf(context).height * height) * 0.4
              : (MediaQuery.sizeOf(context).height * height) * 0.5,
          margin: const EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(
            color: widget.palette.primaryColor(1.0),
            borderRadius: BorderRadius.circular(50),
          ),
        );
      }).toList(),
    );
  }

  void _startAnimating() {
    _timer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
      setState(() {
        _heights.add(_heights.removeAt(0));
      });
    });
  }

  void _initState() {
    if(widget.startRecording) {
      _heights = widget.minimal ? [0.02, 0.03, 0.1, 0.03, 0.02] : [0.02, 0.03, 0.04, 0.1, 0.04, 0.03, 0.02];
      _startAnimating();
    } else {
      _heights = List<double>.filled(
        !widget.minimal ? 7 : 5, 0.02,
        growable: true,
      );
    }
  }
}