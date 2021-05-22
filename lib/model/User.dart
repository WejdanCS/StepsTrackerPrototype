
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:pedometer/pedometer.dart';
import 'package:steps_tracker_prototype/services/auth/authentication.dart';
import 'package:steps_tracker_prototype/services/auth/firebase_functions.dart';
import 'package:steps_tracker_prototype/utils/error_handler.dart';

class StepsTrackerUser extends ChangeNotifier {
  String _uid;
  String _name;
  User _user;
  String _steps="unknown";
  int _points=0;
  get steps => _steps;

  User get user => _user;

  String get name => _name;


  int get points => _points;

  String get uid => _uid;

  Future<void> loginUser(name) async {
    if (nameIsValid(name) == 1) {
      _name = name;
      _user = await signIn();
      _uid=_user.uid;
      print("User:${_user.uid}");
      notifyListeners();
      // return "Sign in successfully";
    }
    else {
      print("Error:Name is Empty");
      throw ErrorMessage("Name is Empty");
    }
  }

  Future<void> signOutUser() async {
    await signOut();
    print("user:${_user}");
    _user = null;
    _name = null;
    // try{
    //   var newSteps=int.parse(_steps);
    //   print("new steps$newSteps");
    //   print(newSteps);
    //   _steps=(newSteps -newSteps).toString();
    //   print("STEEPS $_steps");
    //
    // }catch(e){
    //   print("ERROR:$e");
    // }
    notifyListeners();
  }
  void saveSteps(dynamic steps){
    _steps=steps;
    FireStoreFunctions().updateSteps(_steps,uid);

    // notifyListeners();
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

