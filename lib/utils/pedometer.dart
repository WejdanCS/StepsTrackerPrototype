// import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';

class StepsTracker {

  Stream<StepCount> _stepCountStream;
  Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = 'unknown', _steps = 'unknown';
  // int _previousSteps=0;
  // int _extraSteps=0;

  DateTime userLoginDate;

  get steps => _steps;

  String get status => _status;

  Stream<StepCount> stepCountStreamProvider (){
    // initPlatformState();
    _stepCountStream = Pedometer.stepCountStream;
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
    return _stepCountStream;
  }
  Stream<PedestrianStatus> statusStreamProvider (){
    // initPlatformState();
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;

    return _pedestrianStatusStream;
  }
       //--------user steps
  void initPlatformState() {
    print("ggg");
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;


    // _pedestrianStatusStream
    //     .listen(onPedestrianStatusChanged)
    //     .onError(onPedestrianStatusError);

    // if(_steps)
    // try{
    //   int totalSteps=int.parse(_steps);
    //   if(_previousSteps==0){
    //     _previousSteps=totalSteps;
    //   }
    //   if(_previousSteps<totalSteps){
    //     _previousSteps=totalSteps;
    //     _extraSteps=totalSteps-_previousSteps;
    //     print("extra steps:${_extraSteps}");
    //
    //     print("totalSteps :${totalSteps}");
    //     print("previous steps ${_previousSteps}");
    //
    //   }
    //
    //
    // }catch(e){
    //
    // }
    // _previousSteps<=_steps
    _stepCountStream = Pedometer.stepCountStream;



    // _stepCountStream.listen(onStepCount).onError(onStepCountError);

    // notifyListeners();
  }
  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    _status = event.status;
    // notifyListeners();
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    _steps = 'Step Count not available';
    // notifyListeners();
  }

  void onStepCount(StepCount event) {

    print(event);
    print(event.timeStamp);
    // if(userLoginDate.isAfter(event.timeStamp)){
    // if(_previousSteps!=steps){
    //
    //
    // }
      _steps = event.steps.toString();
     print(userLoginDate);
    // }


    // notifyListeners();
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    _status = 'Pedestrian Status not available';
    print(_status);

    // notifyListeners();
  }

  // Stream<PedestrianStatus> get pedestrianStatusStream =>
  //     _pedestrianStatusStream;
}
