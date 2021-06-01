import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steps_tracker_prototype/controller/user_controller.dart';
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
    final UserController _userController=Provider.of<UserController>(context);
    final  user=_userController.stepsTrackerUser.user;

    if(user==null){
      return LoginPage();
    }else{
      return HomePage();
   }

  }

}
