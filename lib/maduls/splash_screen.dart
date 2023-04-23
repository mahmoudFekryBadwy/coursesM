import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:coursesm/maduls/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () {Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) =>  const HomeScreen()
    ), (route) => false);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Image(
            image: AssetImage(
                'assets/images/img_1.png'),
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Center(child: CircularProgressIndicator(color: Colors.white,),)
            ],
          ),
          ),
        ],
      ),
    );
  }
}