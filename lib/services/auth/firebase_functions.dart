
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:steps_tracker_prototype/model/User.dart';
import 'package:steps_tracker_prototype/utils/constants.dart';

class FireStoreFunctions{
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final User _user;

  // FireStoreFunctions(this._user);
Future <void> addUser(StepsTrackerUser user)async{
  try {
    await _firestore.collection(Constant.collectionName).doc(user.uid).set({
      Constant.name: user.name,
      Constant.nOfSteps: user.steps,
      Constant.totalPoints: user.totalPoints
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



}