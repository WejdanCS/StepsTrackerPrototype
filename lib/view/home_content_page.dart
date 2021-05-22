import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:provider/provider.dart';
import 'package:steps_tracker_prototype/model/User.dart';
import 'package:steps_tracker_prototype/utils/constants.dart';
class HomeContent extends StatefulWidget {
  const HomeContent({Key key}) : super(key: key);

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  StepsTrackerUser _userProvider;
  @override
  void initState() {
      // _userProvider.initPlatformState();

    // Future.delayed(
    //     Duration.zero,()=>_userProvider.initPlatformState
    //
    // );
    super.initState();
    // if(_userProvider!=null){
    //   print("USSSSERR:${_userProvider.steps}");
    //   _userProvider.initPlatformState();
    // }


  }
  //
  // @override
  // void didChangeDependencies() {
  //   if(_userProvider!=null){
  //   // initPlatformState
  //     _userProvider.initPlatformState();
  //   }
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    //
    print("User provider::${_userProvider.steps}");

    double _width=MediaQuery.of(context).size.width;
    double _height=MediaQuery.of(context).size.height;
    print(_userProvider.name);
    print(_userProvider.steps);


    return Container(
    // color: Colors.grey,
      child: Padding(
        padding:  EdgeInsets.only(top: _height*0.03),
        child: ListView(
          children: [
            //Number of steps
            Column(
              children: [
                Image.asset('assets/images/feets.png',width: 200,height: 200,),
                SizedBox(height: _height*0.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //steps _steps
                    Text("${_userProvider.steps}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Constant.primaryColor),),

                    // Text("${"255"}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Constant.primaryColor),),
                    SizedBox(width: _width*0.01,),

                    Text("Steps",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18,color: Constant.secondaryColor),)
                  ],
                )
              ],
            ),
          //  Number of Points
            Padding(
              padding: EdgeInsets.symmetric(vertical: _width*0.05),
              child: Card(
               child: Row(
                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Column(
                   children: [
                     Text("Points",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Constant.secondaryColor)),
                       Container(
                         width: 50,
                        height: 50,

                        decoration: BoxDecoration(
                          color: Constant.thirdColor,
                             borderRadius: BorderRadius.all(Radius.circular(50))
                         ),
                         child: Center(
                           child: Text("${"55"}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white)),
                         ),
                       ),

                   ],
                 ),
                 SizedBox(width: _width*0.03,),
                 Padding(
                   padding: EdgeInsets.only(top: _height*0.02),
                   child: Text("You can't replace points with coupons"),
                 )
               ],
              )
              ),
            ),
            //leader board
          ],

        ),
      ),

    );

  }

  void didChangeDependencies() {
    print("UUUUSSSEEEEERRR");
    _userProvider=Provider.of<StepsTrackerUser>(context);
  //   // _userProvider=Provider.of<StepsTrackerUser>(context, listen: true);
  //   if(_userProvider!=null){
  //     print("User provider::${_userProvider.steps}");
      _userProvider.initPlatformState();
  //
  //
  //   }
    super.didChangeDependencies();
  }
}
