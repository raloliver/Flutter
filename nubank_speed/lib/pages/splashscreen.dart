import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nubank_speed/pages/loginscreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 5), () => _screenLogin());
  }

  _screenLogin(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(
        fit: StackFit.expand,
        children: <Widget>[

          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(138, 5, 190, 1)
            ),
          ),

          Center(
            child: Image.asset("assets/logo-white.png", width: 100, height: 100),

          )


        ],
      ),
    );
  }
}