

import 'package:flutter/material.dart';
import 'package:steps_tracker_prototype/model/User.dart';
import 'package:steps_tracker_prototype/services/auth/authentication.dart';
import 'package:steps_tracker_prototype/services/auth/firebase_functions.dart';
import 'package:steps_tracker_prototype/utils/error_handler.dart';


class UserController extends ChangeNotifier{
  StepsTrackerUser _stepsTrackerUser = StepsTrackerUser();


  StepsTrackerUser get stepsTrackerUser => _stepsTrackerUser;


  set stepsTrackerUser(StepsTrackerUser value) {
    _stepsTrackerUser = value;
  }

  loginUser(context,_nameController)async {
    try{
      // await user.loginUser(_nameController.text);
      if (nameIsValid(_nameController.text) == 1) {
        stepsTrackerUser.name = _nameController.text;
        stepsTrackerUser.user= await signIn();
        stepsTrackerUser.uid=stepsTrackerUser.user.uid;
        print("User:${stepsTrackerUser.user.uid}");
        notifyListeners();
        // return "Sign in successfully";
      }
      else {
        print("Error:Name is Empty");
        throw ErrorMessage("Name is Empty");
      }
      print("new user :$stepsTrackerUser");
      await FireStoreFunctions().addUser(stepsTrackerUser);
      // print("USEEER:$result");
      // print("$result");
      // Navigator.of(context).popAndPushNamed(HomePage.id);
    }catch(e){
      print("fff");
      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: Text("Alert Dialog"),
              content: Text("${e.message}"),
            );
          }
      );
    }

  }
  Future<void> signOutUser() async {
    await signOut();
    print("user:${_stepsTrackerUser.user}");
    _stepsTrackerUser.user=null;
    print("user:${_stepsTrackerUser.user}");
    notifyListeners();
  }

  void saveSteps(dynamic steps){
    _stepsTrackerUser.steps=steps;
    FireStoreFunctions().updateSteps(steps,_stepsTrackerUser.uid);

    // notifyListeners();
  }
}


int nameIsValid(name){
  if(name==null||name.isEmpty){
    return 0;
  }else{
    return 1;
  }
}


