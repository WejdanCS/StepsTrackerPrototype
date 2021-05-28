
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steps_tracker_prototype/controller/partners_controller.dart';
import 'package:steps_tracker_prototype/controller/rewards_controller.dart';
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


  // @override
  // void initState() {
  //   // _rewardController.getData();
  //   // _rewardController.getData();
  //   super.initState();
  //
  // }
  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   // _rewardController.getData().listen((event) {
  //   //   print(event.rewardName);
  //   // });
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    _rewardController = Provider.of<RewardController>(context);

    print(_rewardController.rewards.length);


    // final _partnersController=Provider.of<PartnersController>(context);
    double _width = MediaQuery
        .of(context)
        .size
        .width;
    double _height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
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
                    partner: partnerRef
                    )
                  );


                }

                return ListView.builder(itemCount: rewards.length,itemBuilder: (context,index){

                  return Column(
                    children: [
                      Text(rewards[index].rewardName),
                      StreamBuilder(stream: rewards[index].partner.snapshots(),builder: (context,snapshot){
                        if(snapshot.hasData){
                          return Text(snapshot.data["partnerName"]);
                        }
                        return CircularProgressIndicator();
                      }),
                    ],
                  );
                });
              }
              return CircularProgressIndicator();


            },
          )
        ));

        // ListView.builder(itemCount: _rewardController.rewards.length,itemBuilder: (context,index){
        //       return Text(_rewardController.rewards[index].rewardName);
        //     },


            // StreamBuilder<QuerySnapshot>(
            //   stream: _rewardController.getRewardData(),
            //   builder: (BuildContext context,
            //       AsyncSnapshot<QuerySnapshot> snapshot) {
            //     if (snapshot.hasError) {
            //       return Text('Something went wrong');
            //     }
            //
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return Center(
            //         child: CircularProgressIndicator(
            //           backgroundColor: Constant.primaryColor,
            //         ),
            //       );
            //     }
            //     if (snapshot.hasData) {
            //
            //       // List<Reward> _rewards = [];
            //       // List<Partner> _partners= [];
            //
            //
            //       for (var doc in snapshot.data.docs) {
            //         var data = doc;
            //
            //
            //         _rewardController.addRewardInfo(data);
            //         // print(data.get("partnerId"));
            //
            //         // print("Index:$")
            //         // getPartnerName(_partnersController);
            //
            //
            //         // _partnersController.addPartnerInfo(data.get("partnerId"));
            //       }
            //       // print(_partnersController.partners[0].partnerName);
            //       // var reward=Reward(
            //       //     rewardId:data.id,
            //       //     partnerId:data.get("partnerId"),
            //       //     rewardName:data.get("rewardName"),
            //       //     rewardImage:data.get("rewardImage"),
            //       //     rewardDesc:data.get("rewardDesc"),
            //       //     coupon:data.get("coupon"),
            //       //     points:data.get("points")
            //       // );
            //       // _rewards.add(reward);
            //       // var partnerName;
            //       // var partnerRef=_rewardController.getPartnerName(reward.partnerId).map((event) =>{
            //       //   partnerName=event["partnerName"]
            //       // });
            //
            //
            //       // .then((value) => {
            //       //   partnerName.add(value["partnerName"]),
            //       //   print(value["partnerName"])
            //       // });
            //       // _partners.add(Partner(
            //       //   partnerId: reward.partnerId,
            //       //   partnerName:partnerName
            //       // ));
            //
            //
            //       // print(_partners);
            //       // print(_rewards);
            //       // }
            //
            //       return Padding(
            //         padding: EdgeInsets.symmetric(
            //             horizontal: _width * 0.04, vertical: _height * 0.02),
            //         child: ListView.builder(
            //             itemCount: _rewardController.rewards.length,
            //             itemBuilder: (context, index) {
            //               print("index:$index}");
            //               return
            //                 Card(
            //                     elevation: 2,
            //                     child: Column(
            //                       children: [
            //                         Stack(
            //                           children: [
            //                             Image.network(
            //                               _rewardController.rewards[index]
            //                                   .rewardImage, fit: BoxFit.fill,
            //                               width: _width,),
            //                             Positioned(
            //                                 left: _width * 0.01,
            //                                 top: _height * 0.01,
            //                                 //ToDo: check PartnerName and return it here ..
            //                                 child: Chip(
            //                                   label: Text("")
            //                                   // getPartnerName(_partnersController,_rewardController.rewards[index].partnerId)
            //                                   // Text(_rewardController.rewards[index].partner.toString()
            //                                   //   ,style: TextStyle(color: Colors.white),),
            //                                   // backgroundColor: Constant
            //                                   //     .primaryColor,)
            //                                       ),
            //                             ),
            //                             Positioned(
            //                               right: _width * 0.01,
            //                               top: _height * 0.01,
            //                               child: CircleAvatar(
            //                                 backgroundColor: Constant
            //                                     .primaryColor,
            //                                 child: Padding(
            //                                   padding: EdgeInsets.only(
            //                                       top: _height * 0.005),
            //                                   child: Column(
            //                                     children: [
            //                                       Text(_rewardController
            //                                           .rewards[index].points
            //                                           .toString(),
            //                                         style: TextStyle(
            //                                             color: Colors.white,
            //                                             fontStyle: FontStyle
            //                                                 .normal,
            //                                             fontWeight: FontWeight
            //                                                 .bold),),
            //                                       Text("points",
            //                                         style: TextStyle(
            //                                             fontSize: 10,
            //                                             color: Colors.white),)
            //                                     ],
            //                                   ),
            //                                 ),
            //                               ),
            //                             ),
            //
            //
            //                           ],
            //                         ),
            //                         Text(_rewardController.rewards[index]
            //                             .rewardName),
            //                         SizedBox(height: _height * 0.01,),
            //                         Text(_rewardController.rewards[index]
            //                             .rewardDesc),
            //                         // Divider(color: Colors.grey),
            //                         SizedBox(height: _height * 0.01,),
            //                         Container(
            //                           width: _width,
            //                           height: _height * 0.05,
            //                           child: ElevatedButton(
            //                               style: ElevatedButton.styleFrom(
            //                                 primary: Constant.secondaryColor,
            //
            //                               ),
            //                               child: Text("Get this reward"),
            //
            //                               onPressed: () {
            //                                 print("clicked");
            //                               }
            //                           ),
            //                         ),
            //                       ],
            //                     )
            //                 );
            //             }),
            //       );
            //     } else {
            //       return  Center(
            //         child: CircularProgressIndicator(
            //           backgroundColor: Constant.primaryColor,
            //         ),
            //       );
            //     }
            //   },
              // )


  }
  //
  // Widget getPartnerName(_partnersController,partnerId){
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: _partnersController.getPartnerInfo(partnerId),
  //     builder: (BuildContext context,
  //         AsyncSnapshot<QuerySnapshot> snapshot) {
  //       if (snapshot.hasError) {
  //         return Text('Something went wrong');
  //       }
  //
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Center(
  //           child: CircularProgressIndicator(
  //             backgroundColor: Constant.primaryColor,
  //           ),
  //         );
  //       }
  //       if (snapshot.hasData) {
  //
  //         // List<Reward> _rewards = [];
  //         // List<Partner> _partners= [];
  //
  //
  //         for (var doc in snapshot.data.docs) {
  //           var data = doc;
  //
  //
  //           _partnersController.addPartnerInfo(data);
  //           // print(data.get("partnerId"));
  //
  //           // print("Index:$")
  //           // getPartnerName(_partnersController);
  //
  //
  //           // _partnersController.addPartnerInfo(data.get("partnerId"));
  //         }
  //         // print(_partnersController.partners[0].partnerName);
  //         // var reward=Reward(
  //         //     rewardId:data.id,
  //         //     partnerId:data.get("partnerId"),
  //         //     rewardName:data.get("rewardName"),
  //         //     rewardImage:data.get("rewardImage"),
  //         //     rewardDesc:data.get("rewardDesc"),
  //         //     coupon:data.get("coupon"),
  //         //     points:data.get("points")
  //         // );
  //         // _rewards.add(reward);
  //         // var partnerName;
  //         // var partnerRef=_rewardController.getPartnerName(reward.partnerId).map((event) =>{
  //         //   partnerName=event["partnerName"]
  //         // });
  //
  //
  //         // .then((value) => {
  //         //   partnerName.add(value["partnerName"]),
  //         //   print(value["partnerName"])
  //         // });
  //         // _partners.add(Partner(
  //         //   partnerId: reward.partnerId,
  //         //   partnerName:partnerName
  //         // ));
  //
  //
  //         // print(_partners);
  //         // print(_rewards);
  //         // }
  //
  //         return ListView.builder(
  //               itemCount: _partnersController.partners.length,
  //               itemBuilder: (context, index) {
  //                 print("index:$index}");
  //                 return
  //                  Text(_partnersController.partners[index].partnerName);
  //               });
  //       } else {
  //         return  Center(
  //           child: CircularProgressIndicator(
  //             backgroundColor: Constant.primaryColor,
  //           ),
  //         );
  //       }
  //     },
  //   );
  // }
  //
  // void getData(_rewardController) async{
  //   await _rewardController.getData();
  // }


}