// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import '../controllers/sensor_controller.dart';

class SensorView extends StatefulWidget {
  const SensorView({super.key});

  @override
  _SensorViewState createState() => _SensorViewState();
}

class _SensorViewState extends State<SensorView> {
  final SensorController sensorController = Get.put(SensorController());

  @override
  void initState() {
    super.initState();
    // Start checking for alerts periodically
    _checkForAlerts(); // Start the periodic alert checking
  }

  @override
  void dispose() {
    // Dispose any resources if needed
    super.dispose();
  }

  Future<void> _checkForAlerts() async {
    while (true) {
      await Future.delayed(Duration(seconds: 1)); // Check every 1 second
      _alertIfNeeded();
    }
  }

  void _alertIfNeeded() {
    const double threshold = 0.5; // Define a movement threshold
    // Check the last data point for alerts
    if (sensorController.gyroData.isNotEmpty) {
      final lastGyroDataPoint = sensorController.gyroData.last;
      if ((lastGyroDataPoint.x.abs() > threshold &&
              lastGyroDataPoint.y.abs() > threshold) ||
          (lastGyroDataPoint.x.abs() > threshold &&
              lastGyroDataPoint.z.abs() > threshold) ||
          (lastGyroDataPoint.y.abs() > threshold &&
              lastGyroDataPoint.z.abs() > threshold)) {
        // Show alert dialog only if it's not already shown

        if (!Get.isDialogOpen!) {
          print("Default dialog function is executed.");
          Get.defaultDialog(
            title: 'ALERT',
            middleText: 'High movement detected on multiple axes!',
            onConfirm: () => Get.back(),
            confirmTextColor: Colors.white,
            textConfirm: 'OK',
          );
        }
      }
    }

    if (sensorController.accelerometerData.isNotEmpty) {
      final lastAccDataPoint = sensorController.accelerometerData.last;
      if ((lastAccDataPoint.x.abs() > threshold &&
              lastAccDataPoint.y.abs() > threshold) ||
          (lastAccDataPoint.x.abs() > threshold &&
              lastAccDataPoint.z.abs() > threshold) ||
          (lastAccDataPoint.y.abs() > threshold &&
              lastAccDataPoint.z.abs() > threshold)) {
        // Show alert dialog only if it's not already shown
        if (!Get.isDialogOpen!) {
          Get.defaultDialog(
            title: 'ALERT',
            middleText: 'High movement detected on multiple axes!',
            onConfirm: () => Get.back(),
            confirmTextColor: Colors.white,
            textConfirm: 'OK',
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor Data'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Gyro',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Column(
              children: [
                const Text(
                  'Gyroscope Sensor Data (rad/s)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 250,
                  child: Obx(() {
                    return LineChart(
                      sensorLineChartData(
                        sensorController.gyroData
                            .map((e) => [e.x, e.y, e.z])
                            .toList(),
                      ),
                    );
                  }),
                ),
                // Legend for the gyro data
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    LegendItem(color: Colors.red, label: 'Gyro Z Axis'),
                    LegendItem(color: Colors.green, label: 'Gyro Y Axis'),
                    LegendItem(color: Colors.blue, label: 'Gyro X Axis'),
                  ],
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Accelerometer Sensor Data',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 250,
              child: Obx(() {
                return LineChart(
                  sensorLineChartData(
                    sensorController.accelerometerData
                        .map((e) => [e.x, e.y, e.z])
                        .toList(),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  LineChartData sensorLineChartData(List<List<double>> sensorValues) {
    List<FlSpot> xSpots = [];
    List<FlSpot> ySpots = [];
    List<FlSpot> zSpots = [];

    for (int i = 0; i < sensorValues.length; i++) {
      xSpots.add(FlSpot(i.toDouble(), sensorValues[i][0])); // Gyro X
      ySpots.add(FlSpot(i.toDouble(), sensorValues[i][1])); // Gyro Y
      zSpots.add(FlSpot(i.toDouble(), sensorValues[i][2])); // Gyro Z
    }

    return LineChartData(
      gridData: FlGridData(show: true),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            getTitlesWidget: (value, meta) {
              if (value % 1 == 0) {
                return Text(value.toString());
              }
              return const Text('');
            },
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: (value, meta) {
              if (value % 1 == 0) {
                return Text(value.toString());
              }
              return const Text('');
            },
          ),
        ),
      ),
      borderData:
          FlBorderData(show: true, border: Border.all(color: Colors.grey)),
      lineBarsData: [
        LineChartBarData(
          spots: xSpots,
          isCurved: true,
          color: Colors.blue,
          belowBarData: BarAreaData(show: false),
        ),
        LineChartBarData(
          spots: ySpots,
          isCurved: true,
          color: Colors.green,
          belowBarData: BarAreaData(show: false),
        ),
        LineChartBarData(
          spots: zSpots,
          isCurved: true,
          color: Colors.red,
          belowBarData: BarAreaData(show: false),
        ),
      ],
    );
  }
}

// Legend widget
class LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const LegendItem({super.key, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(label),
        const SizedBox(width: 16),
      ],
    );
  }
}
