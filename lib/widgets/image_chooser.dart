import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:upward_mobile/l10n/app_localizations.dart' show AppLocalizations;
import 'package:upward_mobile/theme/palette.dart';
import 'package:upward_mobile/theme/theme_provider.dart';
import 'package:upward_mobile/widgets/borderless_wrapper.dart';

// ignore: must_be_immutable
class ImageChooserWidget extends StatelessWidget {
  ImageChooserWidget({
    super.key,
    this.onSave,
  });

  late Palette palette;

  final Function(File?)? onSave;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.theme.palette;

    return BorderlessWrapperWidget(
      top: true, bottom: false,
      child: Container(
        color: palette.annotationColor(1.0),
        padding: const EdgeInsets.all(20.0),
        child: Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 20.0,
          children: [
            _buildChooserItem(
              context,
              icon: Icons.camera_alt_outlined,
              text: AppLocalizations.of(context)!.takeOnePicture,
              callback: () {
                ImagePicker().pickImage(
                  source: ImageSource.camera,
                  imageQuality: 100,
                ).then((result) {
                  if (result != null) {
                    File file = File(result.path);
                    onSave?.call(file);
                  }
                });
              },
            ),
            _buildChooserItem(
              context,
              icon: Icons.browse_gallery_outlined,
              text: AppLocalizations.of(context)!.chooseIntoGallery,
              callback: () {
                FilePicker.platform.pickFiles(
                  type: FileType.image,
                ).then((result) {
                  if (result != null) {
                    File file = File(result.files.single.path!);
                    onSave?.call(file);
                  }
                });
              },
            ),
          ],
        )
      ),
    );
  }

  Widget _buildChooserItem(BuildContext context, {required IconData icon, required String text, VoidCallback? callback,}) {
    return GestureDetector(
      onTap: callback,
      child: SizedBox(
        width: (MediaQuery.of(context).size.width / 2) * 0.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: palette.isDark ? palette.captionColor(0.1) : palette.primaryColor(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 22.0,
                color: palette.isDark ? palette.iconColor(1.0) : palette.primaryColor(1.0),
              ),
            ),
            const SizedBox(height: 14.0),
            Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 13.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}