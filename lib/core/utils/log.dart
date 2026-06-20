import 'package:blooth_4/environment.dart';
import 'package:logger/logger.dart';

void printX(Object? object) {
  if (Environment.DEV_MODE) {
    // print(object);
    var logger = Logger();
    logger.i("$object");
  }
}

void printE(Object? object) {
  if (Environment.DEV_MODE) {
    // print(object);
    var logger = Logger();
    logger.e("$object");
  }
}

void printW(Object? object) {
  if (Environment.DEV_MODE) {
    // print(object);
    var logger = Logger();
    logger.w("$object");
  }
}
