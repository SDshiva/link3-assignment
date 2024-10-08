import 'package:get/get.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SensorController extends GetxController {
  final int maxDataPoints = 6; // Show data points for the last 6 seconds
  final RxList<GyroscopeEvent> gyroData = <GyroscopeEvent>[].obs;
  final RxList<AccelerometerEvent> accelerometerData =
      <AccelerometerEvent>[].obs;

  @override
  void onInit() {
    super.onInit();

    // Start collecting sensor data
    _subscribeToSensors();
  }

  @override
  void onClose() {
    // Cleanup if necessary
    super.onClose();
  }

  void _subscribeToSensors() {
    // Listen to gyroscope events
    gyroscopeEvents.listen((GyroscopeEvent event) {
      _addGyroData(event);
    }, onError: (error) {
      // Handle errors here
      print('Error accessing gyroscope data: $error');
    });

    // Listen to accelerometer events
    accelerometerEvents.listen((AccelerometerEvent event) {
      _addAccelerometerData(event);
    }, onError: (error) {
      // Handle errors here
      print('Error accessing accelerometer data: $error');
    });
  }

  void _addGyroData(GyroscopeEvent event) {
    gyroData.add(event);
    if (gyroData.length > maxDataPoints) {
      gyroData.removeAt(0); // Keep only the last 6 data points
    }
  }

  void _addAccelerometerData(AccelerometerEvent event) {
    accelerometerData.add(event);
    if (accelerometerData.length > maxDataPoints) {
      accelerometerData.removeAt(0);
    }
  }
}
