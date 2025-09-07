import 'package:flutter/material.dart';

import 'package:upward_mobile/screens/home_screen/home_screen.dart';

@immutable
class HomeScreenBlocProvider extends StatelessWidget {
  const HomeScreenBlocProvider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}