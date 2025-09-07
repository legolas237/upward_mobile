import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:upward_mobile/config/config.dart';
import 'package:upward_mobile/screens/splash_screen/bloc/starter_bloc.dart';
import 'package:upward_mobile/theme/palette.dart';
import 'package:upward_mobile/theme/theme_provider.dart';
import 'package:upward_mobile/widgets/app_scaffold.dart';

// ignore: must_be_immutable
class SplashScreen extends StatefulWidget {
  static const String routePath = "/";

  SplashScreen({super.key});

  late Palette palette;

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    // Get theme palette
    widget.palette = ThemeProvider.of(context)!.theme.palette;

    return BlocConsumer<StarterBloc, StarterState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (mounted && state.status == StarterStatus.initial) {
          context.read<StarterBloc>().add(
            InitAuth(),
          );
        }

        return ScaffoldWidget(
          automaticallyImplyLeading: false,
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      Constants.appName,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 52.0,
                        fontFamily: "Pacifico",
                        color: widget.palette.isDark ? widget.palette.textColor(1.0) : widget.palette.primaryColor(1.0),
                      ),
                    ),
                  ),
                ),
                Text(
                  "From",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontSize: 13.0,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  Constants.copyright,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 14.0),
              ],
            ),
          ),
        );
      },
    );
  }
}
