import 'package:blooth/core/route/rout_helper.dart';
import 'package:blooth/environment.dart';
import 'package:blooth/view/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 100),
      initialRoute: RouteHelper.homeScreen,
      navigatorKey: Get.key,
      getPages: RouteHelper().routes,
      title: Environment.blooth,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const HomeScreen(),
    );
  }
}
