
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:steps_tracker_prototype/model/User.dart';
import 'package:steps_tracker_prototype/utils/constants.dart';

class FireStoreFunctions{
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final User _user;

  // FireStoreFunctions(this._user);
Future <void> addUser(StepsTrackerUser user)async{
  try {
    await _firestore.collection(Constant.collectionName).doc(user.uid).set({
      "uid":user.uid,
      Constant.name: user.name,
      Constant.nOfSteps: user.steps,
      Constant.totalPoints: user.totalPoints,
      Constant.newPoints:user.newPoints,

    });
    print("sucessfully added user:$user");
  }catch(e){
    print("ERRROR:$e");
  }

}
  Future <void> updateSteps(String steps,String uid)async{
    try {
      await _firestore.collection(Constant.collectionName).doc(uid).update({
        Constant.nOfSteps: steps,
      });
      print("sucessfully update steps:$steps");
    }catch(e){
      print("ERRROR:$e");
    }

  }
  Future<void> updatePoints(field,points,String uid) async {
    // steps,stepsTrackerUser.uid
    try {
      await _firestore.collection(Constant.collectionName).doc(uid).update({
        field: points,
      });
      print("sucessfully update $field points:$points");
    }catch(e){
      print("ERRROR:$e");
    }

  }
  Future<void> updateHistory(points,String uid,DateTime date,isSpentPoints) async {
    // steps,stepsTrackerUser.uid
    try {
      DocumentReference userRef=_firestore.collection("user").doc(uid);
      await _firestore.collection("history").doc(uid).collection("Points").doc().set({
        "points": points,
        "date":date,
        "isSpentPoints":isSpentPoints,
        "uid":userRef
      });
      // print("sucessfully update $field points:$points");
    }catch(e){
      print("ERRROR:$e");
    }

  }

  Stream getHistory(uid){
    var snapshotes =_firestore.collection("history").doc(uid).collection("Points").snapshots();
    // snapshote.forEach((element) {
    //   for(var doc in element.docs){
    //     print(doc.get("points"));
    //
    //   }
    // });
    return snapshotes;
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> getUsersInfo(){
    Query<Map<String, dynamic>> usersInfo=_firestore.collection("user").orderBy("nOfSteps", descending: true);
   return usersInfo.snapshots();
  }
  // Future <int> getTotalPoints(String uid)async{
  //
  //     var userInfo=await _firestore.collection(Constant.collectionName).doc(uid).get();
  //     var points=userInfo["totalPoints"];
  //     // print("sucessfully update steps:$steps");
  //     return points;
  // }



}