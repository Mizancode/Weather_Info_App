import 'package:flutter/material.dart';
import 'package:weather_app/Screens/Home.dart';class ErrorScreen extends StatefulWidget{
  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
                 Image.asset('assets/images/remove_error.png',scale: 1.2,),
                 SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                 Text('OPPS',style: TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold),),
                 Text('Something Wrong',style: TextStyle(color: Colors.red.shade900,fontSize: 30,fontWeight: FontWeight.bold),),
                 SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                 ElevatedButton(onPressed: (){
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NewHome()));
                 }, child: Text('Go Back',style: TextStyle(color: Colors.black,fontSize: 20),),style: ButtonStyle(
                   backgroundColor: MaterialStatePropertyAll(Colors.grey),
                   shape: MaterialStatePropertyAll(StadiumBorder())
                 ),)

            ],
          ),
        ),
      )
    );
  }
}