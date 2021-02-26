import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medloc/auth.dart';
import 'package:flutter_medloc/root_page.dart';
import 'dart:async';
import 'root_page.dart';


class SplashScreenOne extends StatefulWidget{
  @override
  _SplashScreenOneState createState() => _SplashScreenOneState();
}

class _SplashScreenOneState extends State<SplashScreenOne>{

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),()=> Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
      return RootPage(auth: new Auth());
    })));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          SizedBox(height: 230.0,),
          Image.asset('images/s1.jpg'),
        ],
      )
    );
  }

}


