import 'dart:async';

import 'package:cowin_slot_detector/pages/homepage/home_page.dart';
import 'package:cowin_slot_detector/utils/app_config.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool animated = true;
  startTime() async {
    var duration = Duration(seconds: 3);
    return new Timer(duration, route);
  }

  route()
  {
    Navigator.pushReplacement(context,
      MaterialPageRoute(
          builder: (context) => HomePage()));
  }

  switchValue()
  {
    if(animated)
      {
        animated = false;
      }
    else {
      animated = true;
    }
    return animated;
  }



  @override
  Widget build(BuildContext context) {
    startTime();
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image(
                  width: 100,
                  fit: BoxFit.fitWidth,
                  height: 100,
                  image: AssetImage('${AppConfig.getDefaultAssetsImage}/logo.png'),
                ),
                AnimatedDefaultTextStyle(
                  child: Text('SLOT DETECTOR'),
                  style: switchValue() ? TextStyle(
                    color: Colors.blue,
                    fontSize: 26,
                  ) : TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  duration: Duration(milliseconds: 200),
                ),
                Padding(
                  padding: EdgeInsets.all(30),
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    strokeWidth: 1,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}


