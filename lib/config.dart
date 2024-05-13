import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:work_order/services/auth_service.dart';
import 'package:get/get.dart';

initConfigurations() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase
  await Firebase.initializeApp();

  //Get.lazyPut<ThemeController>(() => ThemeController());
  Get.lazyPut<AuthService>(() => AuthService());
}