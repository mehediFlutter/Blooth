import 'package:blooth/view/home/home_screen.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String homeScreen = '/home_screen';

  List<GetPage> routes = [
    GetPage(
      name: homeScreen,
      page: () => HomeScreen(),
      transition: Transition.native,
      transitionDuration: Duration(microseconds: 300),
    ),
  ];
}
