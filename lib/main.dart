import 'package:blooth_4/core/route/rout_helper.dart';
import 'package:blooth_4/environment.dart';
import 'package:blooth_4/view/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.noTransition,
        transitionDuration: const Duration(milliseconds: 100),
        // initialRoute: RouteHelper.homeScreen,
        initialRoute: RouteHelper.homeScreen,
        navigatorKey: Get.key,
        getPages: RouteHelper().routes,
        title: Environment.blooth,
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        home: HomeScreen(),
      ),
    );
  }
}
