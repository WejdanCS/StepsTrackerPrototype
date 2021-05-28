import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steps_tracker_prototype/controller/partners_controller.dart';
import 'package:steps_tracker_prototype/controller/rewards_controller.dart';
import 'package:steps_tracker_prototype/controller/user_controller.dart';
import 'package:steps_tracker_prototype/utils/constants.dart';
import 'package:steps_tracker_prototype/utils/pedometer.dart';
import 'package:steps_tracker_prototype/view/catalog_page.dart';
import 'package:steps_tracker_prototype/view/landing_page.dart';
import 'package:steps_tracker_prototype/view/login_page.dart';

import 'model/User.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserController()),
    ChangeNotifierProvider(create: (context) => StepsTracker()),
    ChangeNotifierProvider(create: (context)=> RewardController()),
    // ChangeNotifierProvider(create: (context)=> PartnersController()),


  ],
  child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        accentColor:Constant.primaryColor ,),
      initialRoute: LandingPage.id,
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        LandingPage.id: (context) => LandingPage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        LoginPage.id: (context) => LoginPage(),
        CatalogPage.id:(context)=>CatalogPage()
      },
    );
  }
}


