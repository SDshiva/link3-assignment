import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';

class SensorService {
  final StreamController<UserAccelerometerEvent> userAccelerometerController =
      StreamController<UserAccelerometerEvent>();
  final StreamController<AccelerometerEvent> accelerometerController =
      StreamController<AccelerometerEvent>();
  final StreamController<GyroscopeEvent> gyroscopeController =
      StreamController<GyroscopeEvent>();

  SensorService() {
    userAccelerometerEvents.listen(userAccelerometerController.add);
    accelerometerEvents.listen(accelerometerController.add);
    gyroscopeEvents.listen(gyroscopeController.add);
  }

  void dispose() {
    userAccelerometerController.close();
    accelerometerController.close();
    gyroscopeController.close();
  }
}
