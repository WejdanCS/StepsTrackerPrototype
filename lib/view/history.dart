import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:steps_tracker_prototype/controller/user_controller.dart';
import 'package:steps_tracker_prototype/model/history.dart';

class History extends StatefulWidget {
  const History({Key key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {

  @override
  Widget build(BuildContext context) {

    double _width=MediaQuery.of(context).size.width;
    double _height=MediaQuery.of(context).size.height;
    return Container(

      // color: Colors.blue,
      child: Consumer<UserController>(
        builder: (context, user, child) {
          return  StreamBuilder(
            stream: user.userHistory(user.stepsTrackerUser.uid),
            builder: (BuildContext builder,snapshots){

              if(!snapshots.hasData){
                return CircularProgressIndicator();
              }
              List<UserHistory> historyData=[];
              for(var doc in snapshots.data.docs){

                var history=UserHistory(
                  points:doc.get("points"),
                  date:doc.get("date"),
                  isSpentPoints:doc.get("isSpentPoints"),
                  uid:doc.get("uid")
              );
                historyData.add(history);

              }
              return ListView.builder(itemCount: historyData.length,itemBuilder: (BuildContext builder,index){
                DateTime fullDate=historyData[index].date.toDate();
                var dateFormat = DateFormat("yy-MM-dd");
                var hourFormat = DateFormat("hh:mm a");

                String date = "${dateFormat.format(fullDate)} ,${hourFormat.format(fullDate)}";

                return
                          Card(
                            color: (historyData[index].isSpentPoints==false)?Color(0xff4daf7c): Color(0xFFAF4D4D),
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: _width*0.02,vertical: _height*0.01),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:[

                                    Column(

                                      children: [
                                        (historyData[index].isSpentPoints==false)?Text("${"Added new points to your accounts "}",style: TextStyle(fontSize: 16,color: Colors.white),):
                                        Text("${"Spent ${historyData[index].points} points"}",style: TextStyle(fontSize: 16,color: Colors.white),),
                                        SizedBox(height: _height*0.02,),
                                        Text("Date: $date",style: TextStyle(color: Colors.white54,fontSize: 12),)

                                      ],
                                    ),
                                    Icon(((historyData[index].isSpentPoints==false)?Icons.add:Icons.remove),color: Colors.white,size: 40,)

                                  ]
                              ),
                            // ),
                          ),);
              });
            },
          );

        })

    );
  }
}

