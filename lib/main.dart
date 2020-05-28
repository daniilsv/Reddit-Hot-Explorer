import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reddit_explorer/app/locator.dart';
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
    return const GetMaterialApp(
      title: 'Reddit Hot Explorer',
      home: SubredditsView(),
    );
  }
}
