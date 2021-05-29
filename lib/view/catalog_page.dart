
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steps_tracker_prototype/controller/partners_controller.dart';
import 'package:steps_tracker_prototype/controller/rewards_controller.dart';
import 'package:steps_tracker_prototype/controller/user_controller.dart';
import 'package:steps_tracker_prototype/model/partner.dart';
import 'package:steps_tracker_prototype/model/reward.dart';
import 'package:steps_tracker_prototype/utils/constants.dart';
class CatalogPage extends StatefulWidget {
  static const id="/CatalogPage";
  const CatalogPage({Key key}) : super(key: key);

  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  UserController userController;
  // List dataList=[];
  RewardController _rewardController;
  // final _rewardController = RewardController();
  getStreamData() async{

    //   ..asBroadcastStream();
    // stream.listen((data) {
    //   // print(data[0]["partnerId"]);
    //
    //   setState(() {
    //     dataList.add(data[0]);
    //     dataList.add(data[1]);
    //   });
    // });

  }
  // @override
  // void initState() {
  //   // TODO: implement initState
  //
  //     _rewardController = Provider.of<RewardController>(super.context);
  //     _rewardController.getData();
  //   super.initState();
  // }
  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //
  //   super.didChangeDependencies();
  // }
  @override
  void dispose() {
    // TODO: implement dispose
    _rewardController.rewards.clear();
    // _rewardController.isReady=false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _rewardController = Provider.of<RewardController>(context);

    print(_rewardController.rewards.length);

    double _width = MediaQuery
        .of(context)
        .size
        .width;
    double _height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Constant.primaryColor,
        title: Text("Rewards Catalog"),
      ),
        body: Container(
          child: StreamBuilder(
            stream: _rewardController.getRewardData(),
            builder: (context,snapshot){
              if(snapshot.hasData){
                List<Reward>rewards=[];
                for (var doc in snapshot.data.docs){
                  print(doc["rewardName"]);
                  DocumentReference partnerRef = doc["partner"];
                  rewards.add(Reward(
                    rewardName: doc["rewardName"],
                    rewardDesc: doc["rewardDesc"],
                    points: doc["points"],
                    rewardImage: doc["rewardImage"],
                    coupon: doc["coupon"],
                    partner: partnerRef
                    )
                  );


                }

                return ListView.builder(itemCount: rewards.length,itemBuilder: (context,index){

                  return
                    Padding(
                      padding: EdgeInsets.symmetric(
                                  horizontal: _width * 0.04, vertical: _height * 0.02),
                      child: Card(
                                            elevation: 2,
                                            child: Column(
                                              children: [
                                                Stack(
                                                  children: [
                                                    Image.network(
                                                      rewards[index].rewardImage, fit: BoxFit.fill,
                                                      width: _width,height: _height*0.3,),
                                                    Positioned(
                                                        left: _width * 0.01,
                                                        top: _height * 0.01,
                                                        //ToDo: check PartnerName and return it here ..
                                                        child: Chip(
                                                          label: StreamBuilder(stream: rewards[index].partner.snapshots(),builder: (context,snapshot){
                                                            if(snapshot.hasData){
                                                              return Text(snapshot.data["partnerName"]);
                                                            }
                                                            return Center(child: CircularProgressIndicator(),);
                                                          }),
                                                              ),
                                                    ),
                                                    Positioned(
                                                      right: _width * 0.01,
                                                      top: _height * 0.01,
                                                      child: CircleAvatar(
                                                        backgroundColor: Constant
                                                            .primaryColor,
                                                        child: Padding(
                                                          padding: EdgeInsets.only(
                                                              top: _height * 0.005),
                                                          child: Column(
                                                            children: [
                                                              Text(rewards[index].points
                                                                  .toString(),
                                                                style: TextStyle(
                                                                    color: Colors.white,
                                                                    fontStyle: FontStyle
                                                                        .normal,
                                                                    fontWeight: FontWeight
                                                                        .bold),),
                                                              Text("points",
                                                                style: TextStyle(
                                                                    fontSize: 10,
                                                                    color: Colors.white),)
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),


                                                  ],
                                                ),
                                                Text(rewards[index]
                                                    .rewardName),
                                                SizedBox(height: _height * 0.01,),
                                                Text(rewards[index]
                                                    .rewardDesc),
                                                // Divider(color: Colors.grey),
                                                SizedBox(height: _height * 0.01,),
                                                Container(
                                                  width: _width,
                                                  height: _height * 0.05,
                                                  child: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        primary: Constant.secondaryColor,

                                                      ),
                                                      child: Text("Get this reward"),

                                                      onPressed: () {

                                                        int rewardPoints=rewards[index].points;
                                                        int totalPoints=userController.stepsTrackerUser.totalPoints;
                                                        int totalRewardPoints=userController.stepsTrackerUser.totalRewardPoints;

                                                        print("reward points$rewardPoints");
                                                        print("totalPoints points:$totalPoints");
                                                        print("total Reward Points :$totalRewardPoints");
                                                        userController.exchangePoints(context,totalPoints,rewardPoints,totalRewardPoints,rewards[index].coupon);
                                                        print("clicked");
                                                      }
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                    );
                });
              }
              return Center(child: CircularProgressIndicator(),);


            },
          )
        ));
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    userController=Provider.of<UserController>(context);
    super.didChangeDependencies();
  }

}