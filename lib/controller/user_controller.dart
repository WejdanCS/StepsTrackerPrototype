

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:steps_tracker_prototype/model/User.dart';
import 'package:steps_tracker_prototype/services/auth/authentication.dart';
import 'package:steps_tracker_prototype/services/auth/firebase_functions.dart';
import 'package:steps_tracker_prototype/utils/constants.dart';
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
      stepsTrackerUser.newPoints=stepsTrackerUser.totalPoints-stepsTrackerUser.totalRewardPoints;
      //update total points
      FireStoreFunctions().updatePoints(Constant.totalPoints,stepsTrackerUser.totalPoints,stepsTrackerUser.uid);
      FireStoreFunctions().updatePoints(Constant.newPoints,stepsTrackerUser.newPoints,stepsTrackerUser.uid);
      print("your points are:$totalPoints");

    }catch(e){
      print(e);
    }
    // notifyListeners();
  }
  void exchangePoints(context,int userPoints,int rewardPoints,int totalRewardPoints,String coupon){
    int totalPoints=(userPoints-totalRewardPoints);
    int newPoints=totalPoints-rewardPoints;
    print("new points:$newPoints");
    print("total Points:$totalPoints");
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
                  // Navigator.of(context).pop();

                  stepsTrackerUser.newPoints=newPoints;
                  stepsTrackerUser.totalRewardPoints+=rewardPoints;
                  FireStoreFunctions().updatePoints(Constant.totalRewardPoints,stepsTrackerUser.totalRewardPoints,stepsTrackerUser.uid);
                  FireStoreFunctions().updatePoints(Constant.newPoints,stepsTrackerUser.newPoints,stepsTrackerUser.uid);
                  isOk=true;
                  print(isOk.toString());
                  Navigator.of(context).pop();
                  print(isOk.toString());
                  print(isOk.toString());
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

                  // Navigator.of(context).popAndPushNamed(CouponDialog.id);

                  // if(newPoints>=0){
                  //   print("new Points =$newPoints");
                  //   stepsTrackerUser.newPoints=newPoints;
                  //   stepsTrackerUser.totalRewardPoints+=rewardPoints;
                  //   FireStoreFunctions().updatePoints(Constant.totalRewardPoints,stepsTrackerUser.totalRewardPoints,stepsTrackerUser.uid);
                  //   FireStoreFunctions().updatePoints(Constant.newPoints,stepsTrackerUser.newPoints,stepsTrackerUser.uid);
                  //   showDialog(context: context, builder: (BuildContext build){
                  //     return AlertDialog(
                  //       title: Column(
                  //         children: [
                  //           Text("Exchange Points"),
                  //           Divider()
                  //         ],
                  //       ),
                  //       //Todo display coupon of this reward
                  //       content: Text("Your Coupon is $coupon"),
                  //       actions: [
                  //         ElevatedButton(
                  //           child:Text("ok"),
                  //           style: ElevatedButton.styleFrom(
                  //             primary: Constant.secondaryColor,
                  //           ),
                  //
                  //           onPressed: (){
                  //             Navigator.of(context).pop();
                  //           },)
                  //
                  //       ],
                  //
                  //     );
                  //   }
                  //   );
                  // }else{
                  //   Navigator.of(context).pop();
                  // }

                  // isDone=true;
                  // if(isDone==true){
                  //   Navigator.of(context).pop();
                  // }
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
      // showDialog(context: context, builder: builder)
      int needPoints=rewardPoints-totalPoints;
      print("you can't exchange your points,because you need $needPoints to get this reward");
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
}


int nameIsValid(name){
  if(name==null||name.isEmpty){
    return 0;
  }else{
    return 1;
  }
}


