import 'package:firebase_auth/firebase_auth.dart';
Future<User> signIn()async{
  UserCredential userCred= await FirebaseAuth.instance.signInAnonymously();
  return userCred.user;
}

Future<void> signOut()async{
   await FirebaseAuth.instance.signOut();
}