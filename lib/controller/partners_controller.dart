
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:steps_tracker_prototype/model/partner.dart';
import 'package:steps_tracker_prototype/model/reward.dart';

class PartnersController extends ChangeNotifier{
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  List<Partner> _partners=[];
  // Reward reward =Reward();
  Stream streamPartner;

  Stream getPartnerInfo(partnerId){
    streamPartner=_fireStore.collection("partners").doc(partnerId).snapshots().asBroadcastStream();
           //     .snapshots().forEach((element) {
           //   print(element["partnerName"]);
           //    partner=Partner(partnerId: partnerId,
           //       partnerName:element["partnerName"]
           //
           //   );
           // });


               return streamPartner;

           //  _partners.add(Partner(partnerId: partnerId,partnerName: element["partnerName"]));
          // });
    // notifyListeners();
  }

  // List<Partner> get partners => _partners;

// String get partnersName{
  //   // notifyListeners();
  //   return _partnersName;
  //
  // }



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


   addPartnerInfo(snapshot){
    for (var doc in snapshot.data.docs) {
      print("wejS");
      var data = doc;
      // var partnerName;
      // var partnerRef=getPartnerName(data.get("partnerId")).map((event) =>{
      //   partnerName=event["partnerName"]
      //
      // });
      var reward = Partner(
        partnerId: data.id,
        partnerName: data.get("partnerName")
      );
      _partners.add(reward);
    }
    // notifyListeners();
  }

  List<Partner> get partners => _partners;
}