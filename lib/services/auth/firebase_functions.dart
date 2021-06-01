
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:steps_tracker_prototype/model/user.dart';
import 'package:steps_tracker_prototype/utils/constants.dart';

class FireStoreFunctions{
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future <void> addUser(StepsTrackerUser user)async{
  try {
    await _firestore.collection(Constant.collectionName).doc(user.uid).set({
      "uid":user.uid,
      Constant.name: user.name,
      Constant.nOfSteps: user.steps,
      Constant.totalPoints: user.totalPoints,
      Constant.newPoints:user.newPoints,

    });
  }catch(e){
    print("ERRROR:$e");
  }

}
  Future <void> updateSteps(String steps,String uid)async{
    try {
      await _firestore.collection(Constant.collectionName).doc(uid).update({
        Constant.nOfSteps: steps,
      });
    }catch(e){
      print("ERRROR:$e");
    }

  }
  Future <void> updateIntSteps(int steps,String uid)async{
    try {
      await _firestore.collection(Constant.collectionName).doc(uid).update({
        "intSteps": steps,
      });
    }catch(e){
      print("ERRROR:$e");
    }

  }
  Future<void> updatePoints(field,points,String uid) async {
    try {
      await _firestore.collection(Constant.collectionName).doc(uid).update({
        field: points,
      });
    }catch(e){
      print("ERRROR:$e");
    }

  }
  Future<void> updateHistory(points,String uid,DateTime date,isSpentPoints) async {
    try {
      DocumentReference userRef=_firestore.collection("user").doc(uid);
      await _firestore.collection("history").doc(uid).collection("Points").doc().set({
        "points": points,
        "date":date,
        "isSpentPoints":isSpentPoints,
        "uid":userRef
      });
    }catch(e){
      print("ERRROR:$e");
    }

  }

  Stream getHistory(uid){
    var snapshotes =_firestore.collection("history").doc(uid).collection("Points").orderBy("date", descending: true).snapshots();
    return snapshotes;
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> getUsersInfo(){
    Query<Map<String, dynamic>> usersInfo=_firestore.collection("user").orderBy("intSteps", descending: true);
   return usersInfo.snapshots();
  }

}