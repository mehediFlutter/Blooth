import 'package:blooth/core/blooth_service/blooth_service.dart';
import 'package:blooth/core/route/rout_helper.dart';
import 'package:blooth/environment.dart';
import 'package:blooth/view/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  BloothService.chekBloothOn();
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
        initialRoute: RouteHelper.homeScreen,
        navigatorKey: Get.key,
        getPages: RouteHelper().routes,
        title: Environment.blooth,
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        home: const HomeScreen(),
      ),
    );
  }
}
