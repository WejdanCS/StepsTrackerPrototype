import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:steps_tracker_prototype/CustomWidgets/custom_text.dart';
import 'package:steps_tracker_prototype/controller/user_controller.dart';
import 'package:steps_tracker_prototype/model/User.dart';
import 'package:steps_tracker_prototype/services/auth/firebase_functions.dart';
import 'package:steps_tracker_prototype/utils/constants.dart';
class LoginPage extends StatelessWidget {
  static const id="/LoginPage";
  const LoginPage({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays ([]);
    TextEditingController _nameController = TextEditingController();
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    // StepsTrackerUser user=StepsTrackerUser();
    // final _userProvider=Provider.of<StepsTrackerUser>(context);
    final UserController userController=Provider.of<UserController>(context);


    return Scaffold(
      backgroundColor: Constant.secondaryColor,

        body:
           SingleChildScrollView(
             child: Padding(
              padding: EdgeInsets.only(top: _height*0.080),
              child: Container(
                width: _width,
                height: _height,
                child: Column(
                  children: [

                    // Image.asset('assets/images/feets.png'),
                SvgPicture.asset("assets/images/feets.svg"),
                        Padding(
                          padding: EdgeInsets.only(top: _height*0.05),
                          child: Column(
                            children: [
                              CustomText(text:"Hello, in Steps Counter App",fontSize: 26,fontWeight: FontWeight.w500),
                              SizedBox(height: _height*0.06,),
                              CustomText(text:"Login as Anonymous user",fontSize: 20,fontWeight: FontWeight.bold),
                              CustomText(text:"and start your journey",fontSize: 18,fontWeight: FontWeight.normal),
                              SizedBox(height: _height*0.03,),
                              Padding(padding: EdgeInsets.symmetric(vertical:2.0,horizontal: 20),
                                  child: TextField(
                                    onSubmitted: (value){
                                      _nameController.text=value;
                                    },

                                    cursorColor: Constant.primaryColor,
                                    style: TextStyle(color: Colors.white),
                                    cursorWidth: 1.5,
                                    controller: _nameController,
                                    decoration: InputDecoration(
                                      hintText: "Enter your name",
                                      hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.white),
                                      filled: true,
                                      // fillColor: Constant.primaryColor.withOpacity(0.8),
                                      prefixIcon: Icon(Icons.person, color: Constant.primaryColor),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                            color: Constant.primaryColor,
                                          )),

                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),

                                      ),

                                    ),
                                  )),

                              SizedBox(height: _height*0.02,),
                              Container(
                                width: _width*0.3,
                                height: _height*0.08,
                                child: ElevatedButton(
                                    style:ElevatedButton.styleFrom(
                                        primary: Constant.primaryColor,
                                        shape: StadiumBorder()

                                      // shape:
                                    ),
                                    child: Text("Login"),
                                    onPressed: ()=>{
                                      // askPermission(context),
                                      userController.loginUser(context, _nameController)
                                    }

                                  //  Firebase login >>
                                  //  TODO:check name if null or empty
                                  //TODO:if successfully login
                                  //TODO: otherwise return error to user

                                  // _nameController.clear()
                                  // print(_name)
                                  // }
                                ),
                              )
                            ],
                          ),
                        ),
                             SizedBox(height: _height*0.05,),
                             Align(
                                  alignment: Alignment.bottomLeft,
                                  child:               SvgPicture.asset("assets/images/human-footprint.svg"),
                                 ),
                      ] ,
                    )


              ),
          ),
           ),

    );
  }



  // _loginUser(context,user,_nameController)async {
  //   try{
  //     await user.loginUser(_nameController.text);
  //     await FireStoreFunctions().addUser(user);
  //     // print("USEEER:$result");
  //     // print("$result");
  //     // Navigator.of(context).popAndPushNamed(HomePage.id);
  //   }catch(e){
  //     print("fff");
  //     showDialog(
  //         context: context,
  //         builder: (BuildContext context){
  //           return AlertDialog(
  //             title: Text("Alert Dialog"),
  //             content: Text("${e.message}"),
  //           );
  //         }
  //     );
  //   }
  //
  // }

  }
