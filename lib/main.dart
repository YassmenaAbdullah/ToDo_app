import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:toda/firebase_options.dart';
import 'package:toda/ui/home/home_screen.dart';
import 'package:toda/ui/my_theme.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
