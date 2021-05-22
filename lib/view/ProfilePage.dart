
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    final _userProvider=Provider.of<StepsTrackerUser>(context);
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
              Text("Name:${_userProvider.name}"),
              Text("User Id:${_userProvider.user.uid}")
            ],
          ),
          TextButton(onPressed: ()=>signOut(_userProvider), child: Text("SignOut",style: TextStyle(color: Constant.primaryColor),))
        ],
      )
    );
  }

  signOut(_userProvider)async {
    try{
      await _userProvider.signOutUser();
      _userProvider=null;
      print("signOut Successfully");
      Navigator.of(context).popAndPushNamed(LandingPage.id);
    }catch(e){
      print("Error:${e.message}");
    }
  }
}
