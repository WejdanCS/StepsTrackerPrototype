
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:steps_tracker_prototype/controller/user_controller.dart';
import 'package:steps_tracker_prototype/model/user.dart';
import 'package:steps_tracker_prototype/services/auth/firebase_functions.dart';
import 'package:steps_tracker_prototype/utils/constants.dart';
import 'package:steps_tracker_prototype/utils/pedometer.dart';
import 'package:steps_tracker_prototype/view/leaderboard.dart';
class HomeContent extends StatefulWidget {
  const HomeContent({Key key}) : super(key: key);

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  bool changeValues=false;
@override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
    changeValues=true;

    super.didChangeDependencies();

  }


  @override
  Widget build(BuildContext context) {

    double _width=MediaQuery.of(context).size.width;
    double _height=MediaQuery.of(context).size.height;

    return Consumer<UserController>(
        builder: (context, userController, child) {
          return (!userController.isLoading)?Consumer<StepsTracker>(builder: (context,stepsTracker,child){
            //initialize step counter and start streaming
            stepsTracker.initPlatformState();

            return (stepsTracker!=null)?Container(
              child: Padding(
                padding: EdgeInsets.only(top: _height * 0.03),
                child: ListView(
                  children: [
                    Column(
                      children: [
                        SvgPicture.asset(
                          "assets/images/feets.svg", width: 200, height: 200,),
                        SizedBox(height: _height * 0.02,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Text("${stepsTracker.steps}",
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Constant.primaryColor),),

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
                                    child: Container(
                                      margin: EdgeInsets.only(top: _height * 0.02,
                                          bottom: _height * 0.02),
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceAround,
                                          children: [
                                            Text("#", style: TextStyle(
                                                color: Constant.primaryColor,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16)),
                                            Container(
                                              width: _width*0.3,
                                              child: Text("Name", style: TextStyle(
                                                  color: Constant.primaryColor,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 16)),
                                            ),
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
                                  StreamBuilder(stream: FireStoreFunctions()
                                      .getUsersInfo(),
                                      builder: (BuildContext builder, snapshots) {
                                        if (!snapshots.hasData) {
                                          return CircularProgressIndicator();
                                        }
                                        List<StepsTrackerUser>users=[];
                                        for (var doc in snapshots.data.docs) {
                                          StepsTrackerUser user=StepsTrackerUser(
                                              newPoints: doc.get("newPoints"),
                                              name: doc.get("name"),
                                              steps:doc.get("nOfSteps"),
                                              totalPoints: doc.get("totalPoints"),
                                              uid:doc.get("uid")
                                          );
                                          users.add(user);
                                        }

                                        return LeaderBoard(users);

                                      }
                                  )

                                ],
                              ),)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),

            ):Center(child: CircularProgressIndicator(),);
          }):Center(child: CircularProgressIndicator(),);
        });

  }


}
