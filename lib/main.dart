import 'package:flutter/material.dart';
import 'package:toda/ui/home/home_screen.dart';
import 'package:toda/ui/my_theme.dart';

void main() {
  runApp(Myapplication());
}

class Myapplication extends StatelessWidget {
  Widget build(BuildContext) {
    return MaterialApp(
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
      },
      initialRoute: HomeScreen.routeName,
      theme: MyTheme.lightTheme,
    );
  }
}
