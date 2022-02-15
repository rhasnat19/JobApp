// ignore_for_file: avoid_print

import 'package:auth_app/services/firebase_service.dart';
import 'package:auth_app/services/navigation_service.dart';
import 'package:auth_app/services/util_services.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  try {
    locator.registerSingleton(UtilService());
    locator.registerSingleton(FirebaseService());
    locator.registerSingleton(NavigationService());
  } catch (err) {
    print(err);
  }
}
