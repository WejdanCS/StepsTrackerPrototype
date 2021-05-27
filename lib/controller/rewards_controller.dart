
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:steps_tracker_prototype/controller/partners_controller.dart';
import 'package:steps_tracker_prototype/model/partner.dart';
import 'package:steps_tracker_prototype/model/reward.dart';

class RewardController extends ChangeNotifier{
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  // Partner partner=Partner();
  // Reward reward =Reward();
  List<Reward> _rewards = [];
  PartnersController partnersController=PartnersController();
  Future <DocumentSnapshot<Object>> partnerInfo;
  List<String> _partners = [];
  List<Future<dynamic>>_waitList=[];



  List<Reward> get rewards{
     // notifyListeners();
     return _rewards;

  }

  //   // notifyListeners();
  //   return _partnersName;
  //
  // }

  Stream getRewardData(){
    return _fireStore.collection("rewards").snapshots();
  }

  List<String> get partners => _partners; //   getPartnerName(String partnerId){
  //
  //       _fireStore.collection("partners").doc(partnerId).snapshots().forEach((element) {
  //      _partnersName =element["partnerName"];
  //     // print(element["partnerName"]);
  //   });
  //
  //
  //   // print(partnerName);
  //   // return  partnerName ;
  //     return _partnersName;
  // }


  addRewardInfo(data) {

      // var partnerName;
      // var partnerRef=getPartnerName(data.get("partnerId")).map((event) =>{
      //   partnerName=event["partnerName"]
      //
      // });
    // Partner partner=partnersController.getPartnerInfo(data.get("partnerId"));
    // print(partner.partnerName);
    // DocumentReference partner=data.get("partner");
    // Map <String,dynamic> partnerMap={};
    // partnerInfo= partner.get();
    // partnerInfo.then((value) =>
    //     {
    //
    //       _partners.add(value["partnerName"]),
    //       print(value["partnerName"])
    //     }
    //     );
    // partnerInfo.whenComplete(() => );
    // print(partnerMap);



      var reward = Reward(
          rewardId: data.id,
          partnerId: data.get("partnerId"),
          rewardName: data.get("rewardName"),
          rewardImage: data.get("rewardImage"),
          rewardDesc: data.get("rewardDesc"),
          coupon: data.get("coupon"),
          points: data.get("points"),
          partner:data.get("partner")
          // partner:Partner(
          //   partnerName: _,
          //   partnerId: data.get("partnerId")
          // ),
      );
      // print(_partnersName.length);
      _rewards.add(reward);
      // _waitList.add(reward);
    _waitList.add(partnerInfo);

    // notifyListeners();
  }
}