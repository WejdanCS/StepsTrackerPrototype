

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:steps_tracker_prototype/model/User.dart';
import 'package:steps_tracker_prototype/services/auth/authentication.dart';
import 'package:steps_tracker_prototype/services/auth/firebase_functions.dart';
import 'package:steps_tracker_prototype/utils/error_handler.dart';


class UserController extends ChangeNotifier{
  StepsTrackerUser stepsTrackerUser=StepsTrackerUser();

  loginUser(context,nameController)async {
    try{
      if (nameIsValid(nameController.text) == 1) {
        // stepsTrackerUser.name = _nameController.text;
         User user= await signIn();
        // stepsTrackerUser.uid=stepsTrackerUser.user.uid;
         stepsTrackerUser=StepsTrackerUser(name: nameController.text,uid: user.uid,user: user);
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
    print("user:${stepsTrackerUser.user}");
    stepsTrackerUser.user=null;
    print("user:${stepsTrackerUser.user}");
    notifyListeners();
  }

  void saveSteps(dynamic steps){
    stepsTrackerUser.steps=steps;
    FireStoreFunctions().updateSteps(steps,stepsTrackerUser.uid);

    // notifyListeners();
  }
  void addPoints(String steps){
    print("Steps ::$steps");
    try{
      double stepsInt=double.parse(steps);
      int totalPoints=((stepsInt/100)*50).round();
      stepsTrackerUser.totalPoints=totalPoints;
      //update total points
      FireStoreFunctions().updatePoints(stepsTrackerUser.totalPoints,stepsTrackerUser.uid);
      // FireStoreFunctions().updatePoints(stepsTrackerUser.points,stepsTrackerUser.uid);
      print("your points are:$totalPoints");

    }catch(e){
      print(e);
    }
    // notifyListeners();
  }
  void exchangePoints(int userPoints,int rewardPoints,int totalRewardPoints){
    int totalPoints=(userPoints-totalRewardPoints);
    if(totalPoints>=rewardPoints){
      int newPoints=totalPoints-rewardPoints;
      print("new Points =$newPoints");
      stepsTrackerUser.newPoints=newPoints;
      stepsTrackerUser.totalRewardPoints+=rewardPoints;




    }else if(totalPoints<rewardPoints){
      // showDialog(context: context, builder: builder)
      int needPoints=rewardPoints-totalPoints;
      print("you can't exchange your points,because you need $needPoints to get this reward");
    }


  }
}


int nameIsValid(name){
  if(name==null||name.isEmpty){
    return 0;
  }else{
    return 1;
  }
}


