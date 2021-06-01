
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:steps_tracker_prototype/model/user.dart';
import 'package:steps_tracker_prototype/utils/constants.dart';
class LeaderBoard extends StatefulWidget {
  final List<StepsTrackerUser> users;
  LeaderBoard(this.users);

  @override
  _LeaderBoardState createState() => _LeaderBoardState(this.users);
}

class _LeaderBoardState extends State<LeaderBoard> {
  final List<StepsTrackerUser> users;
  @override
  Widget build(BuildContext context) {
    double _width=MediaQuery.of(context).size.width;
    // double _height=MediaQuery.of(context).size.height;
    return Container(
      child: (users.length>0)?ListView.builder(itemCount: users.length,scrollDirection: Axis.vertical,
          shrinkWrap: true,itemBuilder: (BuildContext builder,index){
                  return
                    Card(
                      color:  (users[index].uid==FirebaseAuth.instance.currentUser.uid)?Constant.primaryColor:Colors.white,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children:[
                          Text("${index+1}",style: TextStyle(color: (users[index].uid==FirebaseAuth.instance.currentUser.uid)?Colors.white:Colors.black)),
                          Container(
                            width: _width*0.3,
                              child: Text("${users[index].name}",style: TextStyle(color: (users[index].uid==FirebaseAuth.instance.currentUser.uid)?Colors.white:Colors.black),)),
                          Chip(label: Text("${users[index].steps}")),
                          Chip(label: Text("${users[index].newPoints}"))

                        ]
                    ),
                  );

      }):Center(child: CircularProgressIndicator(),)
    );
  }

  _LeaderBoardState(this.users);
}
