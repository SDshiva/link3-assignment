import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SafeArea(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("A To-Do List"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed('/sensor-screen');
                    },
                    child: Text("Sensor Tracking"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
