import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:steps_tracker_prototype/model/partner.dart';

class Reward{
  String rewardId;
  String partnerId;
  String rewardName;
  String rewardImage;
  String rewardDesc;
  String coupon;
  int points;
  DocumentReference partner;

  Reward({this.partnerId,this.rewardId,this.rewardName, this.rewardImage, this.rewardDesc,
      this.coupon, this.points,this.partner});



}