
import 'package:firebase_auth/firebase_auth.dart';

class StepsTrackerUser {
  String uid;
  String name;
  User user;
  String steps = "unknown";
  int previousPoints=0;
  int previousSteps=0;
  int extraPoints=0;

  // int points = 0;
  int totalPoints=0;
  int oldPoints=0;
  int newPoints=0;
  int totalRewardPoints=0;
  bool isNewUser=true;

  StepsTrackerUser({ this.newPoints,this.totalPoints,this.totalRewardPoints,this.name,this.uid, this.user,this.steps});
}

