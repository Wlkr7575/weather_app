import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'dart:math';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App Dadlaga',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var temp;
  var description;
  var currently;
  var humidity;
  var windspeed;
  var pressure;
  bool date;
  Future getWheater()async{
    http.Response response =await http.get("http://api.openweathermap.org/data/2.5/weather?q=Ulaanbaatar&units=metric&appid=00486977a94480379d83c947a5383ec3");
    var result = jsonDecode(response.body);
    setState(() {
      this.temp = result['main']['temp'];
      this.description = result['weather'][0]['description'] == "clear sky"? description='Цэлмэг':result['weather'][0]['description'];
      this.currently = result['weather'][0]['main'];
      this.humidity = result['main']['humidity'];
      this.windspeed = result['wind']['speed'];
      this.pressure = result['main']['pressure'];
    });
  }
Future checkDay()async{

  var hour = DateTime.now().hour;
  if(hour >=20){
    this.date = true;
  }else if(hour <= 20) {
    this.date = false;
  }
    print(hour);
}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getWheater();
    this.checkDay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(date == true? "src/Night.jpg":"src/day.jpg"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(bottom: 100.0,top: 100.0),
                  child: Text(
                    'Улаанбаатарт одоо',
                    style: TextStyle(
                      color: date == true? Colors.white:Colors.black54,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                Text(
                  temp != null ? temp.toString()+"\u00B0": "Loading",
                  style: TextStyle(
                    color: date == true? Colors.white:Colors.black54,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w600
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0,bottom: 100.0),
                  child: Text(
                    currently !=null ? currently.toString():"Loading",
                    style: TextStyle(
                        color: date == true? Colors.white:Colors.black54,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                          Column(
                            children: [
                              FaIcon(FontAwesomeIcons.thermometerHalf,color: date == true? Colors.white:Colors.black54,),
                              Text("температур",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,color: date == true? Colors.white:Colors.black54,),),
                              Text(temp !=null ? temp.toString()+"\u00B0":"Loading",style: TextStyle(color: date == true? Colors.white:Colors.black54,fontWeight: FontWeight.w200),),
                            ],
                          ),
                          Column(
                            children: [
                              FaIcon(FontAwesomeIcons.cloudSunRain,color: date == true? Colors.white:Colors.black54,),
                              Text("Weather",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,color:date == true? Colors.white:Colors.black54,),),
                              Text(description !=null ? description.toString():"Loading",style: TextStyle(color: date == true? Colors.white:Colors.black54,fontWeight: FontWeight.w200),),
                            ],
                          ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            FaIcon(FontAwesomeIcons.tint,color: date == true? Colors.white:Colors.black54,),
                            Text("Агаарын чийгшил",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,color: date == true? Colors.white:Colors.black54,),),
                            Text(humidity !=null ? humidity.toString()+'%':"Loading",style: TextStyle(color: date == true? Colors.white:Colors.black54,fontWeight: FontWeight.w200),),
                          ],
                        ),
                        Column(
                          children: [
                            FaIcon(FontAwesomeIcons.wind,color: date == true? Colors.white:Colors.black54,),
                            Text("Салхины хурд",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,color: date == true? Colors.white:Colors.black54,),),
                            Text(windspeed !=null ? windspeed.toString():"Loading",style: TextStyle(color: date == true? Colors.white:Colors.black54,fontWeight: FontWeight.w200),),
                          ],
                        ),

                    ],)

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
