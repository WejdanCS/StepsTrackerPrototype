
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:steps_tracker_prototype/model/partner.dart';
import 'package:steps_tracker_prototype/model/reward.dart';

class RewardController extends ChangeNotifier {
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  List<Reward> _rewards = [];
  Stream<Reward> rewardsStream;
  bool _isReady=false;

  List<Reward> get rewards =>
      _rewards;

  Stream <QuerySnapshot<Map<String, dynamic>>> getRewardData(){
    return _fireStore.collection("rewards").snapshots();
  }

   Stream <Reward> getData(){
     _isReady=false;
     getRewardData().forEach((snapshot) {
       for( var doc in snapshot.docs) {
         DocumentReference partnerRef = doc["partner"];
         print(partnerRef.snapshots());
         Partner partner=Partner();
         partnerRef.snapshots().forEach((snapshot) {

           partner.partnerName=snapshot.get("partnerName");

         }
         );
       }
     });
     _isReady=true;

     return rewardsStream;
   }

  bool get isReady => _isReady;


  }
