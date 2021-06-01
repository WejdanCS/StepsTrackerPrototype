import 'package:cloud_firestore/cloud_firestore.dart';

class UserHistory{

  int points;
  Timestamp date;
  bool isSpentPoints;
  DocumentReference uid;

  UserHistory({this.points, this.date, this.isSpentPoints, this.uid});
}