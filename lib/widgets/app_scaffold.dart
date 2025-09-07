import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:upward_mobile/blocs/auth/auth_bloc.dart';
import 'package:upward_mobile/config/config.dart';
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
    this.titleColor,
    this.brightness,
    this.tabs,
    this.appBarBackgroundColor,
    this.annotationRegion,
    this.extendBodyBehindAppBar = false,
    this.resizeToAvoidBottomInset = true,
    this.floatingActionButton,
    this.systemOverlayStyle,
    this.titleSpacing,
  });

  late Palette palette;

  final Widget body;
  final dynamic title;
  final Color? titleColor;
  final bool useAppBar;
  final bool centerTitle;
  final List<Widget> actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Widget? bottomNavigationBar;
  final PreferredSizeWidget? tabs;
  final Color? backgroundColor;
  final Color? appBarBackgroundColor;
  final Color? annotationRegion;
  final Brightness? brightness;
  final bool extendBodyBehindAppBar;
  final bool resizeToAvoidBottomInset;
  final Widget? floatingActionButton;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final double? titleSpacing;

  // Static
  static double appBarMaxHeight = Constants.appBarMaxHeight;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.theme.palette;
    // Listen ...
    final authBloc = BlocProvider.of<AuthBloc>(context);
    // Var ...
    var annotationRegionColor = annotationRegion ?? palette.annotationColor(1.0);
    var appBarColor = appBarBackgroundColor ?? backgroundColor;

    return AnnotationRegionWidget(
      color: annotationRegionColor,
      brightness: brightness,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: backgroundColor,
        appBar:_buildAppBar(appBarColor: appBarColor),
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

  PreferredSizeWidget? _buildAppBar({Color? appBarColor}) {
    if(useAppBar) {
      return AppBar(
        titleSpacing: titleSpacing,
        surfaceTintColor: Colors.transparent,
        backgroundColor: appBarColor,
        automaticallyImplyLeading: automaticallyImplyLeading,
        centerTitle: centerTitle,
        leading: leading,
        title: ScaffoldTitleWidget(title: title, titleColor: titleColor),
        actions: actions,
        bottom: tabs,
        systemOverlayStyle: systemOverlayStyle,
      );
    }

    return null;
  }
}

// ignore: must_be_immutable
class ScaffoldTitleWidget extends StatelessWidget {
  ScaffoldTitleWidget({
    super.key,
    this.title,
    this.titleColor,
    this.fontSize,
    this.textAlign = TextAlign.start,
  });

  late Palette palette;

  final dynamic title;
  final Color? titleColor;
  final double? fontSize;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    palette = ThemeProvider.of(context)!.theme.palette;

    if (title is Widget) return title;

    if (title is String) {
      return Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign,
        style: Theme.of(context).textTheme.bodyMedium!.merge(
          TextStyle(
            fontSize: fontSize ?? Constants.appBarTitle,
            color: titleColor ?? palette.textColor(1.0),
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}