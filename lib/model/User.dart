
import 'package:firebase_auth/firebase_auth.dart';

class StepsTrackerUser {
  String uid;
  String name;
  User user;
  String steps = "unknown";
  int points = 0;

  StepsTrackerUser({ this.name,this.uid, this.user});
}

