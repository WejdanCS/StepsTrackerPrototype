import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pedometer/pedometer.dart';
import 'package:provider/provider.dart';
import 'package:steps_tracker_prototype/controller/user_controller.dart';
import 'package:steps_tracker_prototype/model/User.dart';
import 'package:steps_tracker_prototype/utils/constants.dart';
import 'package:steps_tracker_prototype/utils/pedometer.dart';
class HomeContent extends StatefulWidget {
  const HomeContent({Key key}) : super(key: key);

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  UserController userController;
  StepsTrackerUser user;

  StepsTracker _stepsTrackerProvider;
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    //
    print("User provider steps:${user.steps}");

    double _width=MediaQuery.of(context).size.width;
    double _height=MediaQuery.of(context).size.height;
    print(user.name);
    print(user.steps);


    return Container(
    // color: Colors.grey,
      child: Padding(
        padding:  EdgeInsets.only(top: _height*0.03),
        child: ListView(
          children: [
            //Number of steps
            Column(
              children: [
                SvgPicture.asset("assets/images/feets.svg",width: 200,height: 200,),
                // Image.asset('assets/images/feets.png',width: 200,height: 200,),
                SizedBox(height: _height*0.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //steps _steps
                    Text("${user.steps}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Constant.primaryColor),),

                    // Text("${"255"}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Constant.primaryColor),),
                    SizedBox(width: _width*0.01,),

                    Text("Steps",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18,color: Constant.secondaryColor),)
                  ],
                )
              ],
            ),
          //  Number of Points
            Padding(
              padding: EdgeInsets.symmetric(vertical: _width*0.05),
              child: Card(
               child: Row(
                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Column(
                   children: [
                     Text("Points",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Constant.secondaryColor)),
                       Container(
                         width: 50,
                        height: 50,

                        decoration: BoxDecoration(
                          color: Constant.thirdColor,
                             borderRadius: BorderRadius.all(Radius.circular(50))
                         ),
                         child: Center(
                           child: Text("${user.newPoints}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white)),
                         ),
                       ),

                   ],
                 ),
                 SizedBox(width: _width*0.03,),
                 Padding(
                   padding: EdgeInsets.only(top: _height*0.02),
                   child: (user.newPoints>=5)?Text("Check rewards catalog"):Text("You can't replace points with coupons"),
                 ),

               ],
              )
              ),
            ),
            Container(
              width: _width,
              height: _height*0.39,
              // color: Constant.primaryColor,
              child: Column(
                children: [
                  Text("Leader board",style: TextStyle(color: Constant.primaryColor,fontWeight: FontWeight.bold,fontSize: 18),),
                 Padding(padding:EdgeInsets.symmetric(horizontal: _width*0.03,vertical: _height*0.02),
                 child:  Column(
                   children: [
                     Card(
                       // margin:EdgeInsets.symmetric(horizontal: _width*0.02),

                       child: Container(
                         margin:EdgeInsets.only(top: _height*0.02,bottom: _height*0.02),
                         child: Row(

                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                             children:[

                               Text("Name",style: TextStyle(color: Constant.primaryColor,fontWeight: FontWeight.normal,fontSize: 16)),
                               Text("Steps",style: TextStyle(color: Constant.primaryColor,fontWeight: FontWeight.normal,fontSize: 16)),
                               Text("Points",style: TextStyle(color: Constant.primaryColor,fontWeight: FontWeight.normal,fontSize: 16))

                             ]
                         ),
                       ),

                     ),
                     ListView(
                       shrinkWrap: true,
                       children: [
                         //if this user is current user
                         Card(
                           color: Constant.primaryColor,
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceAround,
                               children:[
                                 Text("${user.name}"),
                                 Chip(label: Text("${user.steps}")),
                                 Chip(label: Text("${user.newPoints}"))

                               ]
                           ),
                         ),
                         //other user
                         Card(
                           child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceAround,
                               children:[
                                 Text("${user.name}"),
                                 Chip(label: Text("${user.steps}")),
                                 Chip(label: Text("${user.newPoints}"))

                               ]
                           ),
                         )
                       ],
                       // children: [
                       //   Row(
                       //     children: [
                       //       Text("${user.name}"),
                       //       Chip(label: Text("${user.steps}")),
                       //
                       //     ],
                       //   )
                       // ],
                     )
                   ],
                 ),)
                ],
              ),
            )

            //leader board
          ],

        ),
      ),

    );

  }

  void didChangeDependencies() {
    print("UUUUSSSEEEEERRR");
    userController=Provider.of<UserController>(context);
    user= userController.stepsTrackerUser;
    _stepsTrackerProvider=Provider.of<StepsTracker>(context);
    _stepsTrackerProvider.initPlatformState();
    userController.saveSteps(_stepsTrackerProvider.steps);
    //add points
    userController.addPoints(_stepsTrackerProvider.steps);
    // if(user.steps){
    //
    // }
    // user.newPoints=user.totalPoints-user.totalRewardPoints;
    // user.newPoints=user.totalPoints;
    super.didChangeDependencies();
  }
}
