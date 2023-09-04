import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/Model/WeatherModel.dart';
import 'package:weather_app/Screens/error.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:http/http.dart' as http;
class NewHome extends StatefulWidget{
  @override
  State<NewHome> createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  bool isLoading=false;
  final spinkit=SpinKitWave(
    color: Colors.blue,
    size: 40.0,
  );
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  var cityname='London';
  var searchController=TextEditingController();
  Future<WeatherModel> getWeatherDetail() async{
    isLoading=false;
    final respone=await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=85f7746b9e820900e92e91d51e4fd70e&units=metric'));
    var data=jsonDecode(respone.body.toString());
    isLoading=true;
    if(respone.statusCode==200){
      return WeatherModel.fromJson(data);
    }else if(cityname.isEmpty || cityname==' '){
      return await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NewHome()));
    }else{
      return await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ErrorScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery=MediaQuery.of(context).size;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: AppBar(
              backgroundColor: Colors.blue.shade500,
            )
        ),
        body: Container(
          height: mediaQuery.height,
          width: mediaQuery.width,
          child: Column(
            children: [
              SizedBox(height: mediaQuery.height*0.009,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                width: mediaQuery.width,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Search City',
                              border: InputBorder.none
                            ),
                            controller: searchController,
                          )
                      ),
                      IconButton(onPressed: (){
                          cityname=searchController.text.toString();
                          setState(() {
                          searchController.clear();
                          });
                      }, icon: Icon(Icons.search,size: 35,))
                    ],
                  ),
                ),
              ),
              SizedBox(height: mediaQuery.height*0.005,),
              Container(
                height: mediaQuery.height*0.43,
                width: mediaQuery.width,
                child: Stack(
                  children: [
                    Container(
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: mediaQuery.width,
                          maxHeight: mediaQuery.height*0.33,
                          minWidth: 0,
                          minHeight: 0
                        ),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/background_sky.jpg'),fit: BoxFit.cover
                          ),
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(50.0))
                        ),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        height: mediaQuery.height*0.30,
                        width: mediaQuery.width*0.8,
                        decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(20.0)
                        ),
                        child: FutureBuilder(
                          future: getWeatherDetail(),
                          builder: (context,snapshot){
                            return !isLoading ? Center(
                              child: Container(
                                height: mediaQuery.height*0.30,
                                width: mediaQuery.width*0.8,
                                child: spinkit,
                              ),
                            ) : Column(
                              children: [
                                SizedBox(height: mediaQuery.height*0.01,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.location_on_outlined,color: Colors.blue,size: 35,),
                                    SizedBox(width: mediaQuery.width*0.01,),
                                    Text(snapshot.data!.name.toString().toUpperCase(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 35,fontStyle: FontStyle.italic),),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.network('https://openweathermap.org/img/wn/${snapshot.data!.weather![0].icon.toString()}@2x.png',),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(WeatherIcons.thermometer,color: Colors.white,size: 30,),
                                        SizedBox(height: mediaQuery.height*0.01,),
                                        Text('${snapshot.data!.main!.temp.toString().substring(0,4)}°C',style: TextStyle(color: Colors.red,fontSize: 40,fontWeight: FontWeight.bold),),
                                      ],
                                    )

                                  ],
                                ),
                                Text(snapshot.data!.weather![0].main.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),
                                SizedBox(height: mediaQuery.height*0.01,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Min_temp:${snapshot.data!.main!.tempMin.toString().substring(0,4)}°C',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                                    SizedBox(width: mediaQuery.width*0.03,),
                                    Text('Max_temp:${snapshot.data!.main!.tempMax.toString().substring(0,4)}°C',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),)
                                  ],
                                )
                              ],
                            );
                          },
                        )
                      ),
                      left: 40,
                      top: 100,
                    ),
                  ],
                ),
              ),
              SizedBox(height: mediaQuery.height*0.01,),
              Text('Additional Details',style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold,fontSize: 30),),
              Divider(thickness: 2,endIndent: 70,indent: 70,),
              SizedBox(height: mediaQuery.height*0.02,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                height: mediaQuery.height*0.3,
                child: FutureBuilder(
                  future: getWeatherDetail(),
                  builder: (context,snapshot){
                    return !isLoading ? Container(
                        height: mediaQuery.height*0.3,
                        child: Center(child: spinkit,)) : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.severe_cold,color: Colors.blue,size: 40,),
                            Text(' Feel_temp : ',style: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                            Text('${snapshot.data!.main!.feelsLike.toString().substring(0,4)}°C',style: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold),),
                          ],
                        ),
                        SizedBox(height: mediaQuery.height*0.02,),
                        Divider(thickness: 2,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(WeatherIcons.wind,color: Colors.black,size:40,),
                            Text('Wind_speed : ',style: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                            Text('${snapshot.data!.wind!.speed.toString().substring(0,4)} m/sec',style: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold),),
                          ],
                        ),
                        SizedBox(height: mediaQuery.height*0.02,),
                        Divider(thickness: 2,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(WeatherIcons.humidity,color: Colors.red,size:40,),
                            Text('Humidity : ',style: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                            Text('${snapshot.data!.main!.humidity.toString()}%',style: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold),)
                          ],
                        ),
                        SizedBox(height: mediaQuery.height*0.02,),
                        Divider(thickness: 2,),

                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}