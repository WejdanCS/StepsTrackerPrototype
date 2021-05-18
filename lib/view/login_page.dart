import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steps_tracker_prototype/model/User.dart';
import 'package:steps_tracker_prototype/view/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    // double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    // StepsTrackerUser user=StepsTrackerUser();
    final _userProvider=Provider.of<StepsTrackerUser>(context);


    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: _height*0.20),
        // color: Colors.white,
        child: Column(
          
          children: [
            Text("Login as anonymous user"),
            Padding(padding: EdgeInsets.symmetric(vertical:2.0,horizontal: 20),
              child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                  hintText: "Enter your name",
                  hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey)
              ),

            ),
            ),
            SizedBox(height: _height*0.02,),
            ElevatedButton(
              child: Text("Login"),
              onPressed: ()=>{_loginUser(context, _userProvider, _nameController)}

              //  Firebase login >>
              //  TODO:check name if null or empty
              //TODO:if successfully login
                //TODO: otherwise return error to user

                // _nameController.clear()
                // print(_name)
              // }
            )
          ],
        ),
      ),
    );
  }

  _loginUser(context,user,_nameController)async {
    try{
      var result=await user.loginUser(_nameController.text);
      print("USEEER:$result");
      print("$result");
      // Navigator.of(context).popAndPushNamed(HomePage.id);
    }catch(e){
      print("fff");
      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: Text("Alert Dialog"),
              content: Text("${e.message}"),
            );
          }
      );
    }

  }
  }
