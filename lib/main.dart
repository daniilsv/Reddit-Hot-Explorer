import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reddit_explorer/app/locator.dart';
import 'package:supercharged/supercharged.dart';
import 'package:reddit_explorer/ui/subreddits/view.dart';

void main() {
  setupLocator();
  Get.config(
    defaultPopGesture: true,
    enableLog: true,
    defaultOpaqueRoute: true,
    defaultTransition: Transition.cupertino,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Reddit Hot Explorer',
      home: const SubredditsView(),
      theme: ThemeData(
        primaryColor: '#FF4500'.toColor(),
        primaryIconTheme: IconThemeData(
          color: '#FF4500'.toColor(),
        ),
      ),
    );
  }
}
