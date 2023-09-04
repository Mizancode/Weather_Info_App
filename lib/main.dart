import 'package:flutter/material.dart';
import 'package:weather_app/Screens/loading.dart';
void main(){
  runApp(MyMain());
}
class MyMain extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Loading(),
    );
  }
}