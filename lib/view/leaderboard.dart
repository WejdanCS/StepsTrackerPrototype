
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:steps_tracker_prototype/model/User.dart';
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
    return Container(
      child: (users.length>0)?ListView.builder(itemCount: users.length,scrollDirection: Axis.vertical,
          shrinkWrap: true,itemBuilder: (BuildContext builder,index){
        print(users[index].uid);
        print(FirebaseAuth.instance.currentUser.uid);
        print(users[index].uid==FirebaseAuth.instance.currentUser.uid);

                  return
                    Card(
                      color:  (users[index].uid==FirebaseAuth.instance.currentUser.uid)?Constant.primaryColor:Colors.white,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children:[
                          Text("${users[index].name}"),
                          Chip(label: Text("${users[index].steps}")),
                          Chip(label: Text("${users[index].newPoints}"))

                        ]
                    ),
                  );



        // Center(child: CircularProgressIndicator(),);
      }):Center(child: CircularProgressIndicator(),)
    );
  }

  _LeaderBoardState(this.users);
}
