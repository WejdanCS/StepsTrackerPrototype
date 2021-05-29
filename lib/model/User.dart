
import 'package:firebase_auth/firebase_auth.dart';

class StepsTrackerUser {
  String uid;
  String name;
  User user;
  String steps = "unknown";
  int points = 0;
  int totalPoints=0;
  int newPoints=0;
  int totalRewardPoints=0;
  bool isNewUser=true;

  StepsTrackerUser({ this.name,this.uid, this.user});
}

