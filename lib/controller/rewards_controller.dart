
import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:steps_tracker_prototype/controller/partners_controller.dart';
import 'package:steps_tracker_prototype/model/partner.dart';
import 'package:steps_tracker_prototype/model/reward.dart';

class RewardController extends ChangeNotifier {
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  // Partner partner=Partner();
  // Reward reward =Reward();
  List<Reward> _rewards = [];
  Stream<Reward> rewardsStream;

  // List<Partner>_partners=[];
  bool _isReady=false;

  PartnersController partnersController=PartnersController();

  List<Reward> get rewards =>
      _rewards;

   // Future <DocumentSnapshot<Object>> partnerInfo;
  // List<String> _partners = [];
  // List<Future<dynamic>>_waitList=[];
  //
  //
  //
  // List<Reward> get rewards{
  //    // notifyListeners();
  //    return _rewards;
  //
  // }

  //   // notifyListeners();
  //   return _partnersName;
  //
  // }

  Stream <QuerySnapshot<Map<String, dynamic>>> getRewardData(){
    return _fireStore.collection("rewards").snapshots();
  }
   Stream <Reward> getData(){
     var partnerId;
    // final client = http.Client();
     _isReady=false;
     getRewardData().forEach((snapshot) {
       for( var doc in snapshot.docs) {
         DocumentReference partnerRef = doc["partner"];
         print(partnerRef.snapshots());
         Partner partner=Partner();
         partnerRef.snapshots().forEach((snapshot) {

           partner.partnerName=snapshot.get("partnerName");
           // notifyListeners();
           // for (var doc in snapshot.data()) {
           // DocumentReference partner=doc["partner"];


           // Reward reward=Reward(
           //   rewardName: doc["rewardName"],
           //   rewardDesc: doc["rewardDesc"],
           //   partner: partner
           // );
           // print(reward.rewardName);
           // print(reward.partner.partnerName);
           // }

           // rewardsStream=Stream.value(reward);
           // rewardsStream.listen((event) {
           //
           // });
           // rewardsStream.listen((event) {
           //   print("event$event");
           //
           // });
           // _rewards.add(reward);


         }
         );
         // print("partner Name:${partner.partnerName}");
       }
     });
     _isReady=true;
     // notifyListeners();


     return rewardsStream;
   }

  bool get isReady => _isReady;

//  try {
    //    getRewardData().then((value) =>
    //    {
    //      print(value.docs),
    //      for( var doc in value.docs){
    //        partnerId = doc["partnerId"],
    //        print(doc["partnerId"]),
    //        _rewards.add(Reward(
    //          rewardId: doc.id,
    //          rewardName: doc.get("rewardName"),
    //        )),
    //        partnersController.getPartnerInfo(partnerId).then((value) =>
    //        {
    //          print(value.get("partnerName")),
    //          _partners.add(Partner(
    //            partnerName: value.get("partnerName"),
    //          ))
    //        })
    //
    //      },
    //      _isReady=true
    //    });
    //  }catch(e){
    //    print(e.toString());
    //  }
    // print(streamOne.length);
    // print(streamOne.toList());

     // streamOne.forEach((element) {
     //   print(element.docs[0]["partnerId"]);
     // });


    // var partnerRef=partnersController.getPartnerInfo(streamOne.forEach((element) {
    //   print(element["partnerId"]);
    //   print("elemeny");}));
    //     //   partnerName=event["partnerName"]
    //     //
    //     // });
    // print(partnerRef);
    // Stream streamTwo =  partnersController.getPartnerInfo(partnerId);

    // return StreamZip([streamOne, streamTwo]).asBroadcastStream();
    //  notifyListeners();
  }

  // List<Partner> get partners => _partners;
// List<String> get partners => _partners; //   getPartnerName(String partnerId){
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


  // addRewardInfo(data) {
  //
  //     // var partnerName;
  //     // var partnerRef=getPartnerName(data.get("partnerId")).map((event) =>{
  //     //   partnerName=event["partnerName"]
  //     //
  //     // });
  //   // Partner partner=partnersController.getPartnerInfo(data.get("partnerId"));
  //   // print(partner.partnerName);
  //   // DocumentReference partner=data.get("partner");
  //   // Map <String,dynamic> partnerMap={};
  //   // partnerInfo= partner.get();
  //   // partnerInfo.then((value) =>
  //   //     {
  //   //
  //   //       _partners.add(value["partnerName"]),
  //   //       print(value["partnerName"])
  //   //     }
  //   //     );
  //   // partnerInfo.whenComplete(() => );
  //   // print(partnerMap);
  //
  //
  //
  //     var reward = Reward(
  //         rewardId: data.id,
  //         partnerId: data.get("partnerId"),
  //         rewardName: data.get("rewardName"),
  //         rewardImage: data.get("rewardImage"),
  //         rewardDesc: data.get("rewardDesc"),
  //         coupon: data.get("coupon"),
  //         points: data.get("points"),
  //         partner:data.get("partner")
  //         // partner:Partner(
  //         //   partnerName: _,
  //         //   partnerId: data.get("partnerId")
  //         // ),
  //     );
  //     // print(_partnersName.length);
  //     _rewards.add(reward);
  //     // _waitList.add(reward);
  //   _waitList.add(partnerInfo);
  //
  //   // notifyListeners();
  // }
