

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:steps_tracker_prototype/model/user.dart';
import 'package:steps_tracker_prototype/services/auth/authentication.dart';
import 'package:steps_tracker_prototype/services/auth/firebase_functions.dart';
import 'package:steps_tracker_prototype/utils/constants.dart';
import 'package:steps_tracker_prototype/utils/error_handler.dart';


class UserController with ChangeNotifier{
  StepsTrackerUser stepsTrackerUser=StepsTrackerUser();
  bool isLoading=false;

  initPlatformState(){
  }

  loginUser(context,nameController)async {

    try{
      if (nameIsValid(nameController.text) == 1) {
        isLoading=true;
         User user= await signIn();
         stepsTrackerUser=StepsTrackerUser(name: nameController.text,uid: user.uid,user: user,newPoints: 0,totalPoints: 0,totalRewardPoints: 0,intSteps: 0);
        await FireStoreFunctions().addUser(stepsTrackerUser);
        isLoading=false;

        notifyListeners();
      }
      else {
        throw ErrorMessage("Name is Empty, please enter your name");
      }
      // await FireStoreFunctions().addUser(stepsTrackerUser);
      // isLoading=false;
      //
      // notifyListeners();
    }catch(e){

      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: Text("Alert Dialog"),
              content: Text("${e.message}"),
              actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Constant.secondaryColor,
                    ),
                    onPressed: ()=>Navigator.of(context).pop(),
                    child: Text("ok"))
              ],
            );
          }
      );
    }

  }
  Future<void> signOutUser() async {
    await signOut();
    stepsTrackerUser.user=null;
    isLoading=false;
    notifyListeners();
  }


  saveSteps(dynamic steps) async {
    stepsTrackerUser.steps=await steps;
    try{
      int intSteps=int.parse(stepsTrackerUser.steps);
      await FireStoreFunctions().updateIntSteps(intSteps,stepsTrackerUser.uid);

    }catch(e){
      print(e);
    }

    await FireStoreFunctions().updateSteps(steps,stepsTrackerUser.uid);

  }


  void addPoints(String steps,context){
    try{

      double stepsInt=double.parse(steps);

      if(((stepsInt/100)*10).round()>stepsTrackerUser.totalPoints) {
        stepsTrackerUser.totalPoints = ((stepsInt / 100) * 10).round();
        stepsTrackerUser.newPoints=stepsTrackerUser.totalPoints-stepsTrackerUser.totalRewardPoints;

        //update total points
        FireStoreFunctions().updatePoints(Constant.totalPoints,stepsTrackerUser.totalPoints,stepsTrackerUser.uid);
        FireStoreFunctions().updatePoints(Constant.newPoints,stepsTrackerUser.newPoints,stepsTrackerUser.uid);
        bool isSpentPoints=false;
        FireStoreFunctions().updateHistory(stepsTrackerUser.newPoints,stepsTrackerUser.uid, DateTime.now().toUtc(),isSpentPoints);
        SnackBar snackBar=SnackBar(
          content: Text("Added new points to your accounts"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }

    }catch(e){
      print(e);
    }
  }
  void exchangePoints(context,int userPoints,int rewardPoints,int totalRewardPoints,String coupon){
    int totalPoints=(userPoints-totalRewardPoints);
    int newPoints=totalPoints-rewardPoints;

    bool isOk=false;
    if(totalPoints>=rewardPoints&&totalPoints>=0&&newPoints>=0){

      showDialog(context: context, builder: (BuildContext build){
        return AlertDialog(
          title: Column(
            children: [
              Text("Confirm exchange Points"),
              Divider()
            ],
          ),
          content: Text("you are sure to take this reward??"),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Constant.secondaryColor,
                ),
                onPressed: (){

                  stepsTrackerUser.newPoints=newPoints;
                  stepsTrackerUser.totalRewardPoints+=rewardPoints;
                  FireStoreFunctions().updatePoints(Constant.totalRewardPoints,stepsTrackerUser.totalRewardPoints,stepsTrackerUser.uid);
                  FireStoreFunctions().updatePoints(Constant.newPoints,stepsTrackerUser.newPoints,stepsTrackerUser.uid);
                  bool isSpentPoints=true;
                  FireStoreFunctions().updateHistory(rewardPoints,stepsTrackerUser.uid, DateTime.now().toUtc(),isSpentPoints);
                  isOk=true;
                  Navigator.of(context).pop();

                  if(isOk==true){
                    showDialog(context: context, builder: (BuildContext build){
                      return AlertDialog(
                        title: Column(
                          children: [
                            Text("Exchange Points"),
                            Divider()
                          ],
                        ),
                        //Todo display coupon of this reward
                        content: Text("Your Coupon is $coupon"),
                        actions: [
                          ElevatedButton(
                            child:Text("ok"),
                            style: ElevatedButton.styleFrom(
                              primary: Constant.secondaryColor,
                            ),

                            onPressed: (){
                              Navigator.of(context).pop();
                            },)

                        ],

                      );
                    }
                    );

                  }

                },
                child: Text("Ok")),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Constant.secondaryColor,
                ),
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Text("No"))

          ],
        );
      }
      );

    }
    else if(totalPoints<rewardPoints){
      int needPoints=rewardPoints-totalPoints;
      showDialog(context: context, builder: (BuildContext build){
        return AlertDialog(
          title: Column(
            children: [
              Text("Exchange Points"),
              Divider()
            ],
          ),
          content:
              Text("You can't exchange your points ,because you need $needPoints points to get this reward"),

          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Constant.secondaryColor,
                ),
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Text("Ok"))
          ],
        );
      });
    }


  }
  Stream userHistory(uid){
   return FireStoreFunctions().getHistory(uid);
  }
}


int nameIsValid(name){
  if(name==null||name.isEmpty){
    return 0;
  }else{
    return 1;
  }
}


