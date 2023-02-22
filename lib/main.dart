import 'package:flutter/material.dart';
import 'package:flutter_demo/location.dart';
import 'package:flutter_demo/location_controller.dart';
import 'package:get/get.dart';

void main() {
  initServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Location',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const Location(),
    );
  }
}

Future initServices() async {
  Get.put<UserLocationController>(UserLocationController());
}
