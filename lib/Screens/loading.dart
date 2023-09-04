import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/Screens/Home.dart';
class Loading extends StatefulWidget{
  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void dispose() {
    super.dispose();
  }
   final spinkit=SpinKitWave(
     color: Colors.white,
     size: 50.0,
   );
 @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NewHome()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade500,
              Colors.blue.shade300
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft
          )
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                Image.asset('assets/images/weather.png',scale: 1.5,),
                Text('Weather App',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                Text('Credit To\nMizan Sheikh',style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                spinkit,
              ],
            ),
          ),
        ),
      ),
    );
  }
}