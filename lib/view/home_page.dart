import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:steps_tracker_prototype/controller/user_controller.dart';
// import 'package:steps_tracker_prototype/model/User.dart';
import 'package:steps_tracker_prototype/utils/constants.dart';
// import 'package:steps_tracker_prototype/utils/pedometer.dart';
import 'package:steps_tracker_prototype/view/ProfilePage.dart';
import 'package:steps_tracker_prototype/view/catalog_page.dart';
import 'package:steps_tracker_prototype/view/history.dart';
import 'package:steps_tracker_prototype/view/home_content_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserController userController;
  StepCount _value;
  // StepsTrackerUser user;
  // StepsTracker _stepsTrackerProvider;
  int _currentIndex = 0;
  final List<Widget> _children =[
    //homeContent
    HomeContent(),
    History(),
    ProfilePage(),
  ];
  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // userController=Provider.of<UserController>(context,listen: true);
    // // userController.initPlatformState();
    // _value = Provider.of<StepCount>(context,listen: true);
    // userController.stepsTracker.pedestrianStatusStream
    //     .listen(userController.stepsTracker.onPedestrianStatusChanged)
    //     .onError(userController.stepsTracker.onPedestrianStatusError);
    // userController.stepsTracker.stepCountStream.listen(userController.stepsTracker.onStepCount).onError(userController.stepsTracker.onStepCountError);

  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if(!mounted)return;
    super.didChangeDependencies();
    userController=Provider.of<UserController>(context,listen: true);
    // userController.initPlatformState();
    _value = Provider.of<StepCount>(context,listen: true);
    if(_value!=null){
      print(_value.steps);
      userController.saveSteps(_value.steps.toString());
      userController.addPoints(_value.steps.toString());
      print("Valyess:${_value.steps}");
    }
  }
  @override
  Widget build(BuildContext context) {
    // userController=Provider.of<UserController>(context,listen: true);
    // userController.initPlatformState();
    //  _value = Provider.of<StepCount>(context,listen: true);

    // print("value:${_value}");
    // userController.initPlatformState();
    // print("userID:");
    // print(userController.stepsTrackerUser.user.uid);
    // print("Steps:");
    // userController.saved();
    // print(userController.stepsTrackerUser.steps);
    // if(_value!=null){
    //   userController.saveSteps(_value.steps.toString());
    //   userController.addPoints(_value.steps.toString());
    // }

    // userController.addPoints(userController.stepsTracker.steps);

    // showDialog(context: context, builder: (BuildContext context) {
    // return Text("fff");
    // });
    askPermission(context);
    checkPermission();
    return (_value!=null ||userController!=null)?Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Steps Tracker",style:TextStyle(color: Color(0xFF535151)) ,),
        leading: IconButton(
            icon: Icon(Icons.card_giftcard,color: Constant.thirdColor,),
            onPressed: ()=>{
              Navigator.of(context).pushNamed(CatalogPage.id)
            }
        ),
      ),
      bottomNavigationBar:
      // Padding(
      // padding: EdgeInsets.only(bottom: 15),
      // child:
      BottomNavigationBar(
        selectedItemColor: Constant.primaryColor,
        currentIndex: _currentIndex,
        onTap: onTabTapped, // new
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'History',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile'
          )
        ],
      ),
      body: _children[_currentIndex],
    ):Center(child: CircularProgressIndicator(),);

  }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<void> checkPermission () async {
    print("status:${await Permission.activityRecognition.status}");

  }



  // void didChangeDependencies() {
  //
  //   userController=Provider.of<UserController>(context);
  //   user= userController.stepsTrackerUser;
  //   _stepsTrackerProvider=Provider.of<StepsTracker>(context);
  //   print("steps tracker provide${_stepsTrackerProvider.steps}");
  //   // actions: [
  //   // ElevatedButton(onPressed: ()=>Navigator.of(context).pop(), child: Text("Ok"))
  //   // ],
  //
  //
  //   _stepsTrackerProvider.initPlatformState();
  //   // _stepsTrackerProvider.userLoginDate=user.user.metadata.lastSignInTime;
  //   // try{
  //   //   int totalSteps=int.parse(_stepsTrackerProvider.steps);
  //   //   if(totalSteps>userController.stepsTrackerUser.previousSteps){
  //   //     userController.stepsTrackerUser.extraSteps=totalSteps-userController.stepsTrackerUser.previousSteps;
  //   //     userController.stepsTrackerUser.previousSteps=totalSteps;
  //   //
  //   //
  //   //     var snackBar=SnackBar(
  //   //       content:
  //   //           Text("added ${userController.stepsTrackerUser.extraSteps}"),
  //   //     );
  //   //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   //     //  snackBar=SnackBar(
  //   //     //   content:
  //   //     //   Text("pre steps ${userController.stepsTrackerUser.previousSteps}")
  //   //     // );
  //   //     // ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   //     //
  //   //     // snackBar=SnackBar(
  //   //     //     content:
  //   //     //     Text("total steps ${userController.stepsTrackerUser.steps}")
  //   //     // );
  //   //     // ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   //
  //   //   }
  //   //
  //   // }catch(e){
  //   //   print(e.toString());
  //   // }
  //
  //   //add points
  //
  //   // userController.savePreviousSteps( _stepsTrackerProvider.steps);
  //   userController.saveSteps(_stepsTrackerProvider.steps);
  //   userController.addPoints(_stepsTrackerProvider.steps);
  //
  //
  //   // if(user.steps){
  //   //
  //   // }
  //   // user.newPoints=user.totalPoints-user.totalRewardPoints;
  //   // user.newPoints=user.totalPoints;
  //   super.didChangeDependencies();
  // }
}
void askPermission(context)async{
  var status = await Permission.activityRecognition.status;
  if(status.isDenied){
    print("status 222");

    var result=await Permission.activityRecognition.request();
      if(result.isPermanentlyDenied){
        print("status 33");
        await showDialog(
            context: context,
            builder:
                (BuildContext context)
            {
              return
                AlertDialog(
                  title: Text('Activity Recognition Permission'),
                  content: Text(
                      'This app needs Activity Recognition access to calculate your steps'),
                  actions: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Constant.primaryColor),
                      child: Text('Deny'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Constant.primaryColor),
                      child: Text('Settings'),
                      onPressed: () => {
                        openAppSettings()
                      }
                      )
                  ],);
            });
      }

  }
}






