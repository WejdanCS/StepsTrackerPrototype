
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:steps_tracker_prototype/auth/authentication.dart';

class StepsTrackerUser extends ChangeNotifier{
   String _name;
   User _user;

   User get user => _user;

  Future<String> loginUser(name) async {

    if(nameIsValid(name)==1){
      try{
      _name=name;
      _user=await signIn();
      print("User:${_user.uid}");
      notifyListeners();
        // print(user);
        return "Sign in successfully";
      }catch(e){
        print("ERROR:${e.message}");
        return "ERROR:${e.message}";
      }
    }
    else{
      print("Error:Name is Empty");
      return throw "Error:Name is Empty";
    }
  }
}
/*
check if name is empty or null
 */
int nameIsValid(name){
  if(name==null||name.isEmpty){
    return 0;
  }else{
    return 1;
  }

}