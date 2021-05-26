import 'package:steps_tracker_prototype/model/partner.dart';

class Reward{
  String rewardId;
  String partnerId;
  String rewardName;
  String rewardImage;
  String rewardDesc;
  String coupon;
  int points;
  Partner partner;

  Reward({this.partnerId,this.rewardId,this.rewardName, this.rewardImage, this.rewardDesc,
      this.coupon, this.points,this.partner});
}