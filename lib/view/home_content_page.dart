// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pedometer/pedometer.dart';
import 'package:provider/provider.dart';
import 'package:steps_tracker_prototype/controller/user_controller.dart';
import 'package:steps_tracker_prototype/model/User.dart';
// import 'package:steps_tracker_prototype/model/User.dart';
import 'package:steps_tracker_prototype/services/auth/firebase_functions.dart';
import 'package:steps_tracker_prototype/utils/constants.dart';
import 'package:steps_tracker_prototype/view/leaderboard.dart';
// import 'package:steps_tracker_prototype/utils/pedometer.dart';
class HomeContent extends StatefulWidget {
  const HomeContent({Key key}) : super(key: key);

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  // UserController userController;
  // StepCount value;
  // StepsTrackerUser user;


  // StepsTracker _stepsTrackerProvider;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //
    // });
    //  value = Provider.of<StepCount>(context);
    //  userController=Provider.of<UserController>(context);
    //
    // print("changes");
    // print(_value.steps);


  }


  @override
  Widget build(BuildContext context) {
    // Query<Map<String, dynamic>> usersInfo=FireStoreFunctions().getUsersInfo();
    //
    // print("User provider steps:${user.steps}");

    double _width=MediaQuery.of(context).size.width;
    double _height=MediaQuery.of(context).size.height;
    // print(user.name);
    // print(user.steps);


    return Consumer<UserController>(
        builder: (context, userController, child) {
          // userProviderController=userController;
          print("gg");
          // print(userProviderController.stepsTrackerUser.steps);
          // userController.saveSteps(steps)
          // userController.saveSteps(userProviderController.stepsTrackerUser.steps);
          // userController.addPoints(userProviderController.stepsTrackerUser.steps);


          return Consumer<StepCount>(builder: (context,stepCounts,child){
            return (stepCounts!=null)?Container(
              // color: Colors.grey,
              child: Padding(
                padding: EdgeInsets.only(top: _height * 0.03),
                child: ListView(
                  children: [
                    //Number of steps
                    Column(
                      children: [
                        SvgPicture.asset(
                          "assets/images/feets.svg", width: 200, height: 200,),
                        // Image.asset('assets/images/feets.png',width: 200,height: 200,),
                        SizedBox(height: _height * 0.02,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //steps _steps
                            Text("${stepCounts.steps}",
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Constant.primaryColor),),

                            // Text("${"255"}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Constant.primaryColor),),
                            SizedBox(width: _width * 0.01,),

                            Text("Steps", style: TextStyle(fontWeight: FontWeight
                                .normal, fontSize: 18, color: Constant
                                .secondaryColor),)
                          ],
                        )
                      ],
                    ),
                    //  Number of Points
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: _width * 0.05),
                      child: Card(
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text("Points", style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Constant.secondaryColor)),
                                  Container(
                                    width: 50,
                                    height: 50,

                                    decoration: BoxDecoration(
                                        color: Constant.thirdColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50))
                                    ),
                                    child: Center(
                                      child: Text(
                                          "${userController.stepsTrackerUser
                                              .newPoints}", style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.white)),
                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(width: _width * 0.03,),
                              Padding(
                                padding: EdgeInsets.only(top: _height * 0.02),
                                child: (userController.stepsTrackerUser
                                    .newPoints >= 5) ? Text(
                                    "Check rewards catalog") : Text(
                                    "You can't replace points with coupons"),
                              ),

                            ],
                          )
                      ),
                    ),
                    Container(
                      width: _width,
                      // height: _height * 0.39,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text("Leader board", style: TextStyle(
                                color: Constant.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),),
                            Padding(padding: EdgeInsets.symmetric(
                                horizontal: _width * 0.03,
                                vertical: _height * 0.02),
                              child: Column(
                                children: [
                                  Card(
                                    // margin:EdgeInsets.symmetric(horizontal: _width*0.02),

                                    child: Container(
                                      margin: EdgeInsets.only(top: _height * 0.02,
                                          bottom: _height * 0.02),
                                      child: Row(

                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceAround,
                                          children: [

                                            Text("Name", style: TextStyle(
                                                color: Constant.primaryColor,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16)),
                                            Text("Steps", style: TextStyle(
                                                color: Constant.primaryColor,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16)),
                                            Text("Points", style: TextStyle(
                                                color: Constant.primaryColor,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16))

                                          ]
                                      ),
                                    ),

                                  ),
                                  // Text(),
                                  // .orderBy("date", descending: true)
                                  StreamBuilder(stream: FireStoreFunctions()
                                      .getUsersInfo(),
                                      builder: (BuildContext builder, snapshots) {
                                        if (!snapshots.hasData) {
                                          return CircularProgressIndicator();
                                        }
                                        // Stream<QuerySnapshot<Map<String, dynamic>>> docdd=snapshots.data.docs;
                                        List<StepsTrackerUser>users=[];
                                        for (var doc in snapshots.data.docs) {

                                          StepsTrackerUser user=StepsTrackerUser(
                                            newPoints: doc.get("newPoints"),
                                            name: doc.get("name"),
                                              steps:doc.get("nOfSteps"),
                                              totalPoints: doc.get("totalPoints"),
                                              uid:doc.get("uid")
                                              // newPoints 1
                                          // totalPoints 431
                                          // totalRewardPoints 430
                                        );

                                          print("doc ${user.steps}");
                                          print(doc.get("newPoints"));
                                          //  user=doc;
                                          // print(doc.get("n0fSteps"));
                                          // print(doc.get("n0fSteps"));
                                          users.add(user);
                                        }
                                        print("user Steps:");
                                        print(users[0].steps);
                                        // return  Text("hhh");
                                        return LeaderBoard(users);
                                        // return (users.length>0)?Container(
                                        //   width: _width,
                                        //   height: _height*0.03,
                                        //   child: SingleChildScrollView(
                                        //     child: ListView.builder(itemCount:users.length ,itemBuilder: (BuildContext builder,index){
                                        //
                                        //       return Card(
                                        //         color: Constant.primaryColor,
                                        //         child: Row(
                                        //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        //             children:[
                                        //               Text("${users[index].name}"),
                                        //               Chip(label: Text("${users[index].steps}")),
                                        //               Chip(label: Text("${users[index].newPoints}"))
                                        //
                                        //             ]
                                        //         ),
                                        //       );
                                        //     }),
                                        //   ),
                                        // ):Center(child: CircularProgressIndicator(),);
                                      }


                                  )



                                  // ListView(
                                  //                    shrinkWrap: true,
                                  //                    children: [
                                  //                      //if this user is current user
                                  //                      Card(
                                  //                        color: Constant.primaryColor,
                                  //                        child: Row(
                                  //                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  //                            children:[
                                  //                              Text("${user.name}"),
                                  //                              Chip(label: Text("${user.steps}")),
                                  //                              Chip(label: Text("${user.newPoints}"))
                                  //
                                  //                            ]
                                  //                        ),
                                  //                      ),
                                  //                      //other user
                                  //                      Card(
                                  //                        child: Row(
                                  //                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  //                            children:[
                                  //                              Text("${user.name}"),
                                  //                              Chip(label: Text("${user.steps}")),
                                  //                              Chip(label: Text("${user.newPoints}"))
                                  //
                                  //                            ]
                                  //                        ),
                                  //                      )
                                  //                    ],
                                  //                    // children: [
                                  //                    //   Row(
                                  //                    //     children: [
                                  //                    //       Text("${user.name}"),
                                  //                    //       Chip(label: Text("${user.steps}")),
                                  //                    //
                                  //                    //     ],
                                  //                    //   )
                                  //                    // ],
                                  //                  )
                                ],
                              ),)
                          ],
                        ),
                      ),
                    )

                    // leader board
                  ],

                ),
              ),

            ):Center(child: CircularProgressIndicator(),);
          });
        });

  }

  // void didChangeDependencies() {
  //
  //   // userController=Provider.of<UserController>(context);
  //   // user= userController.stepsTrackerUser;
  //   // _stepsTrackerProvider=StepsTracker();
  //   // print("steps tracker provide${_stepsTrackerProvider.steps}");
  //       // actions: [
  //         // ElevatedButton(onPressed: ()=>Navigator.of(context).pop(), child: Text("Ok"))
  //       // ],
  //
  //
  //   // _stepsTrackerProvider.initPlatformState();
  //   // _stepsTrackerProvider.userLoginDate=user.user.metadata.lastSignInTime;
  //   // try{
  //   //   int totalSteps=int.parse(_stepsTrackerProvider.steps);
  //   //   if(totalSteps>userController.stepsTrackerUser.previousSteps){
  //   //     userController.stepsTrackerUser.extraSteps=totalSteps-userController.stepsTrackerUser.previousSteps;
  //   //     userController.stepsTrackerUser.previousSteps=totalSteps;
  //   //
  //   //
  //   //     var snackBar=SnackBar(
  //   //       content:
  //   //           Text("added ${userController.stepsTrackerUser.extraSteps}"),
  //   //     );
  //   //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   //     //  snackBar=SnackBar(
  //   //     //   content:
  //   //     //   Text("pre steps ${userController.stepsTrackerUser.previousSteps}")
  //   //     // );
  //   //     // ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   //     //
  //   //     // snackBar=SnackBar(
  //   //     //     content:
  //   //     //     Text("total steps ${userController.stepsTrackerUser.steps}")
  //   //     // );
  //   //     // ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   //
  //   //   }
  //   //
  //   // }catch(e){
  //   //   print(e.toString());
  //   // }
  //
  //   //add points
  //
  //   // userController.savePreviousSteps( _stepsTrackerProvider.steps);
  //   print("fff");
  //   print(_stepsTrackerProvider.steps);
  //   // userProviderController.saveSteps(_stepsTrackerProvider.steps);
  //   // userProviderController.addPoints(_stepsTrackerProvider.steps);
  //
  //
  //   // if(user.steps){
  //   //
  //   // }
  //   // user.newPoints=user.totalPoints-user.totalRewardPoints;
  //   // user.newPoints=user.totalPoints;
  //   super.didChangeDependencies();
  // }
}
