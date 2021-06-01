
import 'package:flutter/foundation.dart';
import 'package:pedometer/pedometer.dart';

class StepsTracker with ChangeNotifier{
  Stream<StepCount> _stepCountStream;
  Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = 'unknown', _steps = 'unknown';

  DateTime userLoginDate;

  get steps => _steps;

  String get status => _status;

  Stream<PedestrianStatus> statusStreamProvider (){
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;

    return _pedestrianStatusStream;
  }

  void initPlatformState(){
    print("ggg");
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;


    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
  }


  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    _status = event.status;
    notifyListeners();
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    _steps = 'Step Count not available';
    notifyListeners();
  }

  void onStepCount(StepCount event) {
    _steps = event.steps.toString();
    notifyListeners();
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    _status = 'Pedestrian Status not available';
    print(_status);

    notifyListeners();
  }
}
