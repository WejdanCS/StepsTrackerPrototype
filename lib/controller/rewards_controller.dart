
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:steps_tracker_prototype/model/partner.dart';
import 'package:steps_tracker_prototype/model/reward.dart';

class RewardController extends ChangeNotifier{
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  // Partner partner=Partner();
  // Reward reward =Reward();
  List<Reward> _rewards = [];
  String _partnersName;


  List<Reward> get rewards{
     // notifyListeners();
     return _rewards;

  }
  // String get partnersName{
  //   // notifyListeners();
  //   return _partnersName;
  //
  // }

  Stream getRewardData(){
    return _fireStore.collection("rewards").snapshots();
  }

  //   getPartnerName(String partnerId){
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


  addRewardInfo(snapshot){
    for (var doc in snapshot.data.docs) {
      print("wejS");
      var data = doc;
      // var partnerName;
      // var partnerRef=getPartnerName(data.get("partnerId")).map((event) =>{
      //   partnerName=event["partnerName"]
      //
      // });
      var reward = Reward(
          rewardId: data.id,
          partnerId: data.get("partnerId"),
          rewardName: data.get("rewardName"),
          rewardImage: data.get("rewardImage"),
          rewardDesc: data.get("rewardDesc"),
          coupon: data.get("coupon"),
          points: data.get("points"),
          partner:Partner(partnerId:data.get("partnerId")),
      );
      _rewards.add(reward);
    }
    // notifyListeners();
  }
}