import 'dart:io';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:photo_view/photo_view.dart';

import 'package:photo_view/photo_view_gallery.dart';
import 'package:upward_mobile/theme/palette.dart';
import 'package:upward_mobile/theme/theme_provider.dart';
import 'package:upward_mobile/widgets/app_scaffold.dart';
import 'package:upward_mobile/widgets/borderless_wrapper.dart';
import 'package:upward_mobile/widgets/retro_spinner.dart';

/// Simple image viewer to display an image
// ignore: must_be_immutable
class ImageViewerScreen extends StatefulWidget {
  static const String routePath = "/image-view";

  ImageViewerScreen({
    super.key,
    this.title,
    this.imageUrls = const <String>[],
  });

  late Palette palette;

  final String? title;
  final List<String> imageUrls;

  @override
  State<StatefulWidget> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  late List<ImageProvider> _imageProviders;

  @override
  void initState() {
    super.initState();
    _imageProviders = widget.imageUrls.map((url) {
      return FileImage(File(url));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    widget.palette = ThemeProvider.of(context)!.theme.palette;

    return ScaffoldWidget(
      body: BorderlessWrapperWidget(
        top: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: _imageProviders[index],
                    initialScale: PhotoViewComputedScale.contained * 0.6,
                    heroAttributes: PhotoViewHeroAttributes(tag: _imageProviders[index],),
                    errorBuilder: (context, _, stackTrace) {
                      return Center(
                        child: Icon(
                          MdiIcons.imageFilterHdrOutline,
                          size: 40.0,
                          color: widget.palette.captionColor(1.0),
                        ),
                      );
                    },
                  );
                },
                itemCount: _imageProviders.length,
                backgroundDecoration: BoxDecoration(
                  color: widget.palette.scaffoldColor(1.0),
                ),
                loadingBuilder: (context, event) {
                  return RetroSpinnerWidget();
                },
              ),
            ),
          ],
        )
      ),
    );
  }
}