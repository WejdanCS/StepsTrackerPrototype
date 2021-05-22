
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:pedometer/pedometer.dart';
import 'package:steps_tracker_prototype/auth/authentication.dart';
import 'package:steps_tracker_prototype/utils/error_handler.dart';

class StepsTrackerUser extends ChangeNotifier{
   String _name;
   User _user;
   Stream<StepCount> _stepCountStream;
   Stream<PedestrianStatus> _pedestrianStatusStream;
   String _status = '?', _steps = '?';

   User get user => _user;
   String get name => _name;

  get steps => _steps;

  Future<void> loginUser(name) async {

    if(nameIsValid(name)==1){
      _name=name;
      _user=await signIn();
      print("User:${_user.uid}");
      notifyListeners();
        // return "Sign in successfully";
    }
    else{
      print("Error:Name is Empty");
      throw ErrorMessage("Name is Empty");
    }
  }
   Future<void>signOutUser()async{
     await signOut();
     print("user:${_user}");
     _user=null;
     _name=null;
     notifyListeners();

   }

   //--------user steps
   void initPlatformState() {
    print("ggg");
     _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
     _pedestrianStatusStream
         .listen(onPedestrianStatusChanged)
         .onError(onPedestrianStatusError);

     _stepCountStream = Pedometer.stepCountStream;
     _stepCountStream.listen(onStepCount).onError(onStepCountError);
    // notifyListeners();
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
     print(event);
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

/*
check if name is empty or null
 */
int nameIsValid(name){
  if(name==null||name.isEmpty){
    return 0;
  }else{
    return 1;
  }
}

