import 'package:ai_radio/pages/home_page.dart';
import 'package:ai_radio/pages/login_page.dart';
import 'package:ai_radio/pages/podcast_page.dart';
import 'package:ai_radio/pages/weather.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
class DisplayPage extends StatefulWidget {
  const DisplayPage({Key key}) : super(key: key);

  @override
  _DisplayPageState createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Welcome to AI Radio App",
          style: TextStyle(
              color: Colors.red,
              fontFamily: 'Pacifico',
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg.jpeg'), fit: BoxFit.cover),
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 25,
                    spreadRadius: 16,
                    color: Colors.black.withOpacity(0.3)),
              ],
            ),
            child: SingleChildScrollView(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                          width: 1.5, color: Colors.white.withOpacity(0.1))),
                  child:Column(
                    children: <Widget>[
                      SizedBox(height: 50),
          ElevatedButton(onPressed: (){
            Get.to(HomePage());
          }, child: Text('AI Radio')),
                       SizedBox(height: 50),
          ElevatedButton(onPressed: (){
            Get.to(WeatherPage());
          }, child: Text('Weather')),
          SizedBox(height: 50),
          ElevatedButton(onPressed: (){
            Get.to(PodcastPage());
          }, child: Text('Podcast')),
          SizedBox(height: 50),
          ElevatedButton(onPressed: () async{
            await FirebaseAuth.instance.signOut();
            setState(() {
              Navigator.pop(context, MaterialPageRoute(builder: (context)=>LoginPage()));
            });
          }, child: Text('Log out')),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
