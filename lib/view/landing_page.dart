import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steps_tracker_prototype/model/User.dart';
import 'package:steps_tracker_prototype/view/home_page.dart';
import 'package:steps_tracker_prototype/view/login_page.dart';
class LandingPage extends StatefulWidget {
  static const id="/LandingPage";
  const LandingPage({Key key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  @override
  Widget build(BuildContext context) {
    final _userProvider=Provider.of<StepsTrackerUser>(context);
    print("ff");
    print(_userProvider.user);
    if(_userProvider.user==null){
      print("User:${_userProvider.user}");
      return LoginPage();
    }else{
      print("User:${_userProvider.user}");
      return HomePage();
    }

  }
}
