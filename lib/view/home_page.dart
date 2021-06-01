import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:steps_tracker_prototype/controller/user_controller.dart';
import 'package:steps_tracker_prototype/utils/constants.dart';
import 'package:steps_tracker_prototype/utils/pedometer.dart';
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
  StepsTracker stepsTracker;
  int _currentIndex = 0;
  final List<Widget> _children =[
    HomeContent(),
    History(),
    ProfilePage(),
  ];

   @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if(!mounted)return;
    super.didChangeDependencies();
    userController=Provider.of<UserController>(context);
    stepsTracker=Provider.of<StepsTracker>(context);

    userController.saveSteps(stepsTracker.steps);
    userController.addPoints(stepsTracker.steps,context);
  }
  @override
  Widget build(BuildContext context) {
    // request activity recognition permission
    askPermission(context);
    // checkPermission();
    return Scaffold(
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
    );

  }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<void> checkPermission () async {
    print("status:${await Permission.activityRecognition.status}");
  }

}
void askPermission(context)async{
  var status = await Permission.activityRecognition.status;
  if(status.isDenied){
    var result=await Permission.activityRecognition.request();
      if(result.isPermanentlyDenied){
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






