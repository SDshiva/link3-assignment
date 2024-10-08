// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'config/app_theme.dart';
import 'features/sensor_tracking/views/sensor_view.dart';
import 'features/home_view.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Link3 Technologies Ltd.",
      theme: AppTheme.lightTheme,
      home: HomeScreenView(),
      getPages: [
        GetPage(
          name: '/sensor-screen',
          page: () => SensorView(),
        ),
        // GetPage(name: 'to-do-screen', page: () => ,)
      ],
      debugShowCheckedModeBanner: false,
    ),
  );
}
