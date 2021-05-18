import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Steps Tracker",style:TextStyle(color: Color(0xFF535151)) ,),
        leading: IconButton(
            icon: Icon(Icons.card_giftcard,color: Colors.amber,),
            onPressed: cataloge
        ),
      ),
    );
  }
}

void cataloge(){
  print("go to Cataloge");
}
