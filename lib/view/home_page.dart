import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:steps_tracker_prototype/utils/constants.dart';
import 'package:steps_tracker_prototype/view/ProfilePage.dart';
import 'package:steps_tracker_prototype/view/catalog_page.dart';
import 'package:steps_tracker_prototype/view/home_content_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children =[
    //homeContent
    HomeContent(),
    Container(color: Colors.white70,),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
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
    );
  }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}



void cataloge(){
  print("go to Cataloge");
}


