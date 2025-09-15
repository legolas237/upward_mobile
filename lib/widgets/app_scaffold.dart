import 'package:flutter/material.dart';

import 'package:upward_mobile/utilities/config.dart';
import 'package:upward_mobile/theme/palette.dart';
import 'package:upward_mobile/theme/theme_provider.dart';
import 'package:upward_mobile/widgets/annotation_region.dart';

// ignore: must_be_immutable
class ScaffoldWidget extends StatelessWidget {
  ScaffoldWidget({
    super.key,
    this.scaffoldKey,
    required this.body,
    this.title,
    this.centerTitle = true,
    this.actions = const <Widget>[],
    this.automaticallyImplyLeading = true,
    this.bottomNavigationBar,
    this.leading,
    this.backgroundColor,
    this.useAppBar = true,
    this.appBarBackgroundColor,
    this.annotationRegion,
    this.extendBodyBehindAppBar = false,
    this.resizeToAvoidBottomInset = true,
    this.floatingActionButton,
    this.titleSpacing,
    this.titleColor,
  });

  late Palette palette;

  final Widget body;
  final dynamic title;
  final bool useAppBar;
  final bool centerTitle;
  final Color? titleColor;
  final List<Widget> actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final Color? appBarBackgroundColor;
  final Color? annotationRegion;
  final bool extendBodyBehindAppBar;
  final bool resizeToAvoidBottomInset;
  final Widget? floatingActionButton;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final double? titleSpacing;

  // Static
  static double appBarMaxHeight = Constants.appBarMaxHeight;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.theme.palette;
    // Var ...
    var annotationRegionColor = annotationRegion ?? palette.annotationColor(1.0);
    var appBarColor = appBarBackgroundColor ?? backgroundColor;

    return AnnotationRegionWidget(
      color: annotationRegionColor,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: backgroundColor,
        appBar:_buildAppBar(context, appBarColor: appBarColor),
        bottomNavigationBar: bottomNavigationBar,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        floatingActionButton: floatingActionButton,
        body: Builder(
          builder: (context) {
            if (appBarMaxHeight == 0) {
              appBarMaxHeight = scaffoldKey != null ? scaffoldKey!.currentState!.appBarMaxHeight ?? 0.0 : 0.0;
            }

            return SafeArea(
              top: false,
              maintainBottomViewPadding: true,
              child: body,
            );
          },
        ),
      ),
    );
  }

  PreferredSizeWidget? _buildAppBar(BuildContext context, {Color? appBarColor}) {
    if(useAppBar) {
      return AppBar(
        titleSpacing: titleSpacing,
        surfaceTintColor: Colors.transparent,
        backgroundColor: appBarColor,
        automaticallyImplyLeading: automaticallyImplyLeading,
        centerTitle: centerTitle,
        leading: leading,
        actions: actions,
        title: Builder(
          builder: (context) {
            if(title is String) {
              return Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium!.merge(
                  TextStyle(
                    fontSize: Constants.appBarTitle,
                    color: titleColor ?? palette.textColor(1.0),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              );
            }

            return title ?? const SizedBox();
          },
        ),
      );
    }

    return null;
  }
}