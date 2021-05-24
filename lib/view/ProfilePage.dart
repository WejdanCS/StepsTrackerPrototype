
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steps_tracker_prototype/controller/user_controller.dart';
import 'package:steps_tracker_prototype/model/User.dart';
import 'package:steps_tracker_prototype/utils/constants.dart';
import 'package:steps_tracker_prototype/view/landing_page.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    var _userController=Provider.of<UserController>(context);
    final _user=_userController.stepsTrackerUser;
    double _width=MediaQuery.of(context).size.width;
    double _height=MediaQuery.of(context).size.height;

    return Container(
      width: _width,
      height: _height,
      // color: Constant.primaryColor,
      child: Column(
        children: [
          Column(
            children: [
              Text("Name:${_user.name}"),
              Text("User Id:${_user.uid}")
            ],
          ),
          TextButton(onPressed: () async {
    try{
    await _userController.signOutUser();
    print("signOut Successfully");
    Navigator.of(context).popAndPushNamed(LandingPage.id);
    }catch(e){
    print("Error:${e.message}");
    }
          }, child: Text("SignOut",style: TextStyle(color: Constant.primaryColor),))
        ],
      )
    );
  }


}
